class ArtistsController < ApplicationController
  respond_to :json

  def index
    @artists = Artist.all

    respond_with @artists
  end
end
