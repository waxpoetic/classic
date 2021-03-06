require 'spec_helper'
require 'carrierwave/test/matchers'

describe Release do
  include CarrierWave::Test::Matchers

  fixtures :artists
  let(:artist) { artists :wonderbars }

  subject { Release.new \
    name: 'just the start',
    catalog_number: 'WXP666',
    released_on: 3.days.ago.to_date,
    artist: artist,
    cover_image: 'jts.png'
  }

  it "validates with all required params" do
    expect(subject).to be_valid
  end

  it "must have a name" do
    subject.name = nil

    expect(subject).to_not be_valid
  end

  it "must have a catalog number" do
    subject.catalog_number = nil

    expect(subject).to_not be_valid
  end

  it "must have been released on a date" do
    subject.released_on = nil

    expect(subject).to_not be_valid
  end

  it "must have been released by an artist on wax poetic" do
    subject.artist = nil

    expect(subject).to_not be_valid
  end

  it "has a cover image" do
    expect(subject.cover_image).to_not be_nil
  end
end
