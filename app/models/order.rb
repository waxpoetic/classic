# Local data mapping of orders that are sent to Stripe for billing
# purposes. They are logged in our database before being sent off to
# Stripe as a Charge. This object is also responsible for calculating
# and producing a grand total that the Charge will amount to.
class Order < ActiveRecord::Base
  belongs_to :user
  has_many :products, through: :product_orders

  def total_amount
  end
end
