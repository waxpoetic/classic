require 'stripe'
require 'active_model/errors'

# Represents a charge made by [Stripe](http://stripe.com), which can
# only be built off an Order that was saved in the database and is
# valid. The basic API client to Stripe, this class is responsible for
# mmodeling charges created on Stripe's side to our application's
# environment.

class Charge
  attr_reader :order, :errors

  # Prepare to charge the card from an Order.
  def initialize from_order
    @order = from_order
    @errors = ActiveModel::Errors.new self
  end

  # Charge the card and return `true` if everything worked. Return
  # `false` if there was an error with the card and add those errors to
  # the errors object.
  def save
    @saved = build_stripe_charge
  rescue Stripe::CardError => error
    errors.add :credit_card, "has been declined."
    false
  end

  # Report whether the Stripe::Charge successfully created
  def success?
    @saved
  end

  # Find or build a "customer" on Stripe's server that represents the
  # user making this Order.
  def customer
    @customer ||= Stripe::Customer.create \
      email: order.user.email,
      card: order.stripe_token
  end

  protected
  def build_stripe_charge
    @stripe_charge ||= Stripe::Charge.create \
      customer: customer.id,
      amount: order.total,
      description: "Online product order ##{order.id}",
      currency: 'usd'
  end
end
