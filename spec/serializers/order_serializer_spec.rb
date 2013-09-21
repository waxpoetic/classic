require 'spec_helper'

describe OrderSerializer do
  fixtures :orders
  let(:order) { orders :wonderbars_discography }
  subject { OrderSerializer.new order }

  it "exposes attributes id, total & is_checked_out" do
    expect(subject.id).to eq(order.id)
    expect(subject.total).to eq(order.total)
    expect(subject.is_checked_out).to eq(order.is_checked_out)
  end
  it "exposes user object" do
    expect(subject.products).to eq(order.products)
  end
  it "exposes products" do
    expect(subject.products).to eq(order.products)
  end
end
