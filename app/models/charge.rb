# Represents a charge made by [Stripe](http://stripe.com), which can
# only be built off an Order that was saved in the database and is
# valid.
class Charge
  include ActiveModel::Errors

  attr_reader :order

  # Prepare to charge the card from an Order.
  def initialize from_order
    @order = from_order
  end

  # Charge the card and return `true` if everything worked. Return
  # `false` if there was an error with the card and add those errors to
  # the errors object.
  def save
    return false unless order.valid?

    Stripe::Charge.create \
      customer: customer.id,
      amount: order.total,
      description: "Online product order ##{order.id}",
      currency: 'usd'
    true
  rescue Stripe::CardError => error
    errors.add :credit_card, error.message
    false
  end

  # Find or build a "customer" on Stripe's server that represents the
  # user making this Order.
  def customer
    @customer ||= Stripe::Customer.create \
      email: order.user.email,
      card: order.stripe_token
  end
end
