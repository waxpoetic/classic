class ArtistsController < ApplicationController
  respond_to :json

  def index
    @artists = Artist.where search_params

    respond_with @artists
  end

  def show
    @artist = Artist.find params[:id]
    render json: { errors: ["Artist not found."] } and return \
      unless @artist.present?

    respond_with @artist
  end

  private
  def search_params
    params.permit(:name)
  end
end
