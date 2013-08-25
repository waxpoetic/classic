require 'spec_helper'

class Charge
  def customer
    cust = OpenStruct.new
    cust.id = 1
    cust
  end

  protected
  def build_stripe_charge
    true
  end
end

describe Order do
  fixtures :products, :users
  let(:product) { products :just_the_start_ose }
  let(:user) { users :tubbo }
  subject { Order.new user: user }

  context "before being checked out" do
    before { subject.is_checked_out = false }

    it "collects products together" do
      expect(subject.add(product)).to be_valid
      expect(subject.product_orders.map(&:product_id)).to include(product.id)
    end

    it "removes a product" do
      expect(subject.add(product)).to be_valid
      expect(subject.remove(product)).to be_true, \
        "#{subject.errors.full_messages}"
      expect(subject.products.map(&:id)).to_not include(product.id)
    end

    it "calculates the total amount to be charged" do
      expect(subject.add(product)).to be_valid
      expect(subject.total).to eq(product.price)
    end

    it "makes the charge on stripe" do
      expect(subject.checkout('')).to be_true, \
        "#{subject.errors.full_messages}"
      expect(subject.charge).to be_a Charge
    end

    it "confirms that the charge was made to the user" do
      expect(subject.checkout('')).to be_true, \
      "#{subject.errors.full_messages}"
    end
  end

  context "after having been checked out" do
    before { subject.is_checked_out = true }

    it "can no longer add products" do
      expect(subject.add(product)).to be_false
    end

    it "can no longer remove products" do
      expect(subject.remove(product)).to be_false
    end
  end
end
