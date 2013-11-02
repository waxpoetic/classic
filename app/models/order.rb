# Local data mapping of orders that are sent to Stripe for billing
# purposes. They are logged in our database before being sent off to
# Stripe as a Charge. This object is also responsible for calculating
# and producing a grand total that the Charge will amount to.
class Order < ActiveRecord::Base
  belongs_to :user
  has_many :product_orders
  has_many :products, through: :product_orders

  before_validation :ensure_not_checked_out,
                    :calculate_total_if_not_specified

  validates :total, presence: true
  validates :is_checked_out, presence: true
  validates :is_merchandise, presence: true

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

  # Test whether a given Product is included in this Order.
  def include? product
    products.map(&:id).include? product.id
  end

  # Perform a "checkout" of this order by creating a Charge on Stripe
  # and updating the database with a true/false result as to whether the
  # charge succeeded. All Stripe errors made during API calls are stored
  # in the Charge's ActiveModel::Errors object.
  def checkout with_token=''
    return true if is_checked_out?
    @stripe_token = with_token
    @charge = Charge.new self
    update_database_with_charge
  end

  def is_merchandise?
    products.merchandise.any?
  end

  private
  def update_database_with_charge
    if @charge.save
      update_attributes is_checked_out: true
    else
      errors.add :charge, "failed: #{@charge.errors.full_messages}"
      update_attributes is_checked_out: false
    end

    is_checked_out?
  end

  def ensure_not_checked_out
    self.is_checked_out ||= false
  end

  def calculate_total_if_not_specified
    self.total ||= products.pluck(:price).sum
  end
end
