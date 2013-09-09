require 'spec_helper'

describe Charge do
  fixtures :orders
  let(:order) { orders :wonderbars_discography }
  subject { Charge.new order }

  it "attaches to an order" do
    expect(subject.order).to eq(order)
  end

  it "creates an errors object for api errors" do
    expect(subject.errors).to be_a ActiveModel::Errors
  end

  context "finds or builds a customer on Stripe" do
    it "uses the user on the order" do
      expect(subject.order.user.email).to be_present
    end

    it "uses the stripe_token on the order" do
      expect(subject.order.stripe_token).to be_present
    end

    it "builds a customer" do
      expect(subject.customer).to be_a Stripe::Customer
    end
  end

  context "when saving with a working card" do
    it "builds the charge on Stripe" do
      expect(subject.send(:build_stripe_charge)).to be_a Stripe::Charge
    end

    it "charges the total amount using the Stripe API" do
      expect(subject.save).to be_true
    end
  end

  context "when saving with a bad card" do
    it "saves card errors to the errors object and returns false" do
      expect(subject.save).to be_false
      expect(subject.errors.full_messages).to include('Credit card has been declined.')
    end
  end
end
