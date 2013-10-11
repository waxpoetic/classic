require 'stripe'
require 'active_model/errors'

# Represents a charge made by [Stripe](http://stripe.com), which can
# only be built off an Order that was saved in the database and is
# valid.

class Charge
  # An Order object, which is a record in the database, that stores all
  # of the data we need to make this Stripe charge happen.
  attr_reader :order

  # An ActiveModel::Errors object designed to store errors in a clean
  # and consistent way.
  attr_reader :errors

  # Prepare to charge the card from an Order, and set up an object to
  # store errors in case we get any.
  def initialize from_order
    @order = from_order
    @errors = ActiveModel::Errors.new self
  end

  # Charge the card and return `true` if everything worked. Return
  # `false` if there was an error with the card and add those errors to
  # the errors object.
  def save
    @saved ||= to_stripe.present?
  rescue Stripe::CardError => error
    errors.add :credit_card, "has been declined."
    Rails.logger.error "CC Decline for Order ##{order.id}: #{error.message}"
    false
  end

  # Report whether the Stripe::Charge successfully created on the API
  # server or not.
  def success?
    saved
  end

  # Find or build a "customer" on Stripe's server that represents the
  # user making this Order. Uses the email and stripe_token methods from
  # Order to help build the customer JSON payload.
  def customer
    @customer ||= begin
      Stripe::Customer.create customer_params, stripe_secret
    rescue Stripe::InvalidRequestError => error
      errors.add :customer, "could not be created: #{error.message}"
      nil
    end
  end

  # Send computed Charge off to Stripe as a Stripe::Charge. Returns
  # `nil` if it didn't succeed with an error in the `errors` object.
  # Requires a valid Order object to succeed.
  def to_stripe
    @stripe_charge ||= begin
      Stripe::Charge.create charge_params, stripe_secret
    rescue Stripe::InvalidRequestError => error
      errors.add :base, "Billing Error: #{error.message}"
      nil
    end
  end

  private
  attr_accessor :saved
  ATTRIBUTE_NAMES = %w(credit_card customer).reduce({}) { |memo, attribute|
    memo.merge attribute => attribute.humanize
  }.with_indifferent_access

  def self.human_attribute_name attr, options={}
    ATTRIBUTE_NAMES[attr]
  end

  def charge_params
    {
      amount: order.total.to_i,
      card: order.stripe_token,
      description: "Online product order ##{order.id}",
      currency: 'usd'
    }
  end

  def customer_params
    { email: order.user.email, card: order.stripe_token }
  end

  def stripe_secret
    ENV['STRIPE_SECRET_KEY'] || ""
  end
end
