require 'spec_helper'

describe ReleasesController do
  fixtures :artists, :releases

  let(:release) { releases :boyfriend }
  let(:artist) { release.artist }
  let(:other_release) { releases :shuffle_not }
  let(:other_artist) { other_release.artist }

  context "when the latest releases are requested" do
    before { get :index, format: 'json' }
    let(:collection) { JSON.parse response.body }
    let(:release_ids) { collection['releases'].map {|r| r['id'] } }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "includes all releases" do
      expect(release_ids).to include(release.id)
    end
  end

  context "when all releases for an artist are requested" do
    before { get :index, artist_id: other_artist.id, format: 'json' }
    let(:collection) { JSON.parse response.body }
    let(:release_ids) { collection['releases'].map {|r| r['id'] } }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "does not include an alien release" do
      expect(release_ids).to_not include(release.id)
    end

    it "includes all releases by this artist" do
      expect(release_ids).to include(other_release.id)
    end
  end
end
