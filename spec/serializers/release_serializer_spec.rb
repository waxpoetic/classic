require 'spec_helper'

describe ReleaseSerializer do
  fixtures :releases, :artists
  let(:release) { releases :boyfriend }
  subject { ReleaseSerializer.new release }

  [
    :id, :name, :released_on, :catalog_number,
    :description, :tracks, :notes
  ].each do |attribute|
    it "exposes #{attribute.to_s.humanize.downcase}" do
      expect(subject.send(attribute)).to eq(release.send(attribute))
    end
  end

  it "exposes cover image url" do
    expect(subject.cover).to eq(release.cover_image.url)
  end

  it "exposes artist name" do
    expect(subject.artist_name).to eq(release.artist.name)
  end

  it "exposes permalink url" do
    expect(subject.permalink).to eq("/releases.#{release.id}")
  end
end
