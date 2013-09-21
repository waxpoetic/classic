require 'spec_helper'

describe OrderSerializer do
  fixtures :orders
  let(:order) { orders :wonderbars_discography }
  subject { OrderSerializer.new order }

  [:id, :total, :is_checked_out].each do |attribute|
    it "exposes #{attribute.to_s.humanize.downcase}" do
      expect(subject.send(attribute)).to eq(order.send(attribute))
    end
  end

  it "exposes user object" do
    expect(subject.products).to eq(order.products)
  end

  it "exposes products" do
    expect(subject.products).to eq(order.products)
  end
end
