require 'spec_helper'

describe ReleasesController do
  fixtures :artists, :releases
  let(:release) { releases :boyfriend }

  context "the latest releases are requested" do
    let(:artist) { release.artist }
    before { get :index, format: 'json' }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "includes all releases" do
      expect(assigns(:releases)).to include(release)
    end
  end

  context "all releases for an artist are requested" do
    let(:other_release) { releases :shuffle_not }
    let(:other_artist) { other_release.artist }

    before { get :index, artist_id: other_artist.id, format: 'json' }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "does not include an alien release" do
      expect(assigns(:releases)).to_not include(release)
    end

    it "includes all releases by this artist" do
      expect(assigns(:releases)).to include(other_release)
    end
  end

  context "a single release is requested" do
    before { get :show, id: release.id, format: 'json' }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "finds the correct release" do
      expect(assigns(:release)).to eq(release)
    end
  end
end
