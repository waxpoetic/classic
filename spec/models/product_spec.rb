require 'spec_helper'

describe Product do
  fixtures :releases
  let(:release) { releases :just_the_start }

  subject do
    release.products.build \
      name: 'open source edition example',
      price: 9.99
  end

  it "represents a single release" do
    expect(subject.release).to be_a Release
  end

  it "must have a price" do
    expect(subject.price).to == 9.99
  end
end
