require 'spec_helper'

describe ProductOrder do
  fixtures :orders, :products
  let(:order) { orders :wonderbars_discography }
  let(:product) { products :just_the_start_open_source }

  subject { ProductOrder.new order: order, product: product }

  it "models the relationship between a product and an order" do
    expect(subject).to have_order
    expect(subject).to have_product
  end

  it "is not valid if not representing an order" do
    subject.order = nil

    expect(subject).to_not be_valid
  end

  it "is not valid if not representing a product" do
    subject.product = nil

    expect(subject).to_not be_valid
  end

end
