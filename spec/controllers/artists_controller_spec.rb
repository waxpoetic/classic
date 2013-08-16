require 'spec_helper'

describe ArtistsController do
  fixtures :artists
  let(:artist) { artists :wonderbars }

  context "when all artists are requested as json" do
    before { get :index, format: :json }
    let(:collection) { JSON.parse response.body }

    it "responds successfully" do
      expect(response.status).to eq(200)
      expect(response).to be_success
    end

    it "outputs all artists in json" do
      expect(collection['artists']).to_not be_nil
    end

    it "returns a collection of json-serialized artists" do
      expect(collection['artists']).to be_a Array
    end

    it "does not return an empty collection" do
      expect(collection['artists']).to_not be_empty
    end

    it "includes every artist" do
      artist_ids = collection['artists'].map { |a| a['id'] }
      expect(artist_ids).to include(artist.id)
    end
  end
end
