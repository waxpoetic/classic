require 'spec_helper'

describe Order do
  fixtures :products, :users
  let(:product) { products :just_the_start_ose }
  let(:user) { users :tubbo }
  subject { Order.new user: user }

  context "before being checked out" do
    before do
      subject.is_checked_out = false
      subject.stub(:update_database_with_charge) do
        subject.update_attributes(is_checked_out: true)
        true
      end
    end

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

    context "when checking out" do
      before { subject.checkout }

      it "posts the charge to stripe" do
        expect(subject.charge).to be_a Charge
      end

      it "confirms that the charge was made to the user" do
        expect(subject.charge).to be_success
      end
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
