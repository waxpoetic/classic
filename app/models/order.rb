# Local data mapping of orders that are sent to Stripe for billing
# purposes. They are logged in our database before being sent off to
# Stripe as a Charge. This object is also responsible for calculating
# and producing a grand total that the Charge will amount to.
class Order < ActiveRecord::Base
  belongs_to :user
  has_many :products, through: :product_orders

  validates :total, presence: true

  attr_accessor :card_number, :security_code,
                :expiration_month, :expiration_year, :stripe_token

  # Add a product to the Order as a ProductOrder, and append its price
  # to the total price.
  def add product
    entry = product_orders.create! product_id: product.id
    update_attributes total: total + product.price
  rescue ActiveRecord::ValidationError
    errors.add :products, "could not be added: #{entry.errors.full_messages}"
    false
  end

  # Remove a ProductOrder entry from this Order, and deduct it from the
  # total price.
  def remove product
    entry = product_orders.find_by_product_id product.id
    return false unless entry.destroy
    update_attributes total: total - product.price
  rescue ActiveRecord::RecordNotFound
    errors.add :products, "could not be found in order"
    false
  end

  def check_out!
    charge = Charge.new self
    return false unless charge.save
    update_attributes is_checked_out: false
  end

  private
  def from_credit_card_attributes
    @credit_card_attrs ||= {
      number: card_number,
      cvc: security_code,
      exp_month: expiration_month,
      exp_year: expiration_year
    }
  end
end
