require 'spec_helper'

describe Charge do
  fixtures :orders

  context "when saving with a working card" do
    let(:token) do
      params = {
        card: {
          number: '4012888888881881',
          cvc: '123',
          exp_month: 1.year.from_now.month,
          exp_year: 1.year.from_now.year
        }
      }

      token_response = Stripe::Token.create params, ENV['STRIPE_API_KEY']
      token_response['id']
    end
    let(:order) do
      order = orders :wonderbars_discography
      order.stripe_token = token
      order
    end
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
        VCR.use_cassette :create_stripe_customer do
          expect(subject.customer).to_not be_nil, "#{subject.errors.full_messages}"
        end
      end
    end

    it "builds the charge on Stripe" do
      VCR.use_cassette :build_stripe_charge do
        expect(subject.to_stripe).to_not be_nil, "#{subject.errors.full_messages}"
      end
    end

    it "charges the total amount using the Stripe API" do
      VCR.use_cassette :create_stripe_charge do
        expect(subject.save).to be_true, "#{subject.errors.full_messages}"
      end
    end
  end

  context "when saving with a bad card" do
    let(:token) do
      params = {
        card: {
          number: '4000000000000002',
          cvc: '123',
          exp_month: 1.year.from_now.month,
          exp_year: 1.year.from_now.year
        }
      }

      response = Stripe::Token.create params, ENV['STRIPE_API_KEY']
      response['id']
    end
    let(:order) do
      order = orders :wonderbars_discography
      order.stripe_token = token
      order
    end
    subject { Charge.new order }

    it "saves card errors to the errors object and returns false" do
      VCR.use_cassette :attempt_failed_credit_card_charge do
        expect(subject.save).to be_false
        expect(subject.errors.full_messages).to include('Credit card has been declined.')
      end
    end
  end
end
