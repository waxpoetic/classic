require 'spec_helper'

describe Order do
  let(:product) { products :just_the_start_open_source }
  subject { Order.new user: user }

  it "collects products together in preparation for a sale" do
    expect(order.add(product)).to be_true
    expect(order).to include(product)
    expect(order.products).to_not be_empty
  end

  it "calculates the total amount to be charged" do
    expect(order.add(product)).to be_true
    expect(order.total).to eq(product.price)
  end

  it "makes the charge on stripe" do
    expect(order.checkout).to be_true
    expect(order.charge).to be_a Charge
    expect(order.charge.succeeded).to be_true
  end

  it "confirms that the charge was made to the user" do
    expect(order.checkout).to be_true
    expect(order.charge.succeeded).to be_true
    expect(order).to have_sent_confirmation_mail
  end

  context "before being checked out" do
    it "removes a product" do
      expect(order.add(product)).to be_true
      expect(order.remove(product)).to be_true
      expect(order).to_not include(product)
    end
  end

  context "after having been checked out" do
    before { subject.is_checked_out = true }

    it "can no longer add products" do
      expect(order.add(product)).to be_false
    end

    it "can no longer remove products" do
      expect(order.remove(product)).to be_false
    end
  end
end
