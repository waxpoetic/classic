# Local data mapping of orders that are sent to Stripe for billing
# purposes. They are logged in our database before being sent off to
# Stripe as a Charge. This object is also responsible for calculating
# and producing a grand total that the Charge will amount to.
class Order < ActiveRecord::Base
  belongs_to :user
  has_many :product_orders
  has_many :products, through: :product_orders

  before_validation :ensure_not_checked_out

  validates :total, presence: true
  validates :is_checked_out, presence: true

  attr_accessor :stripe_token, :charge

  scope :unfilled, -> { where is_checked_out: false }
  scope :filled, -> { where is_checked_out: true }

  # Add a product to the Order as a ProductOrder, and append its price
  # to the total price. If this Order has already been checked out,
  # return `false`.
  def add product
    return false if is_checked_out?
    entry = product_orders.build product: product, order: self
    update_attributes total: total + product.price if entry.save
    entry
  end

  # Remove a ProductOrder entry from this Order, and deduct it from the
  # total price.
  def remove product
    return false if is_checked_out?
    entry = product_orders.find_by_product_id product.id
    entry.destroy
  end

  def include? product
    products.map(&:id).include? product.id
  end

  def checkout with_token
    return true if is_checked_out?

    @stripe_token = with_token
    @charge = Charge.new self

    if @charge.save
      update_attributes is_checked_out: true
    else
      errors.add :charge, "failed: #{@charge.errors.full_messages}"
      update_attributes is_checked_out: false
    end

    is_checked_out?
  end

  private
  def ensure_not_checked_out
    self.is_checked_out ||= false
  end
end
