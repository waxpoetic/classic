class ReleasesController < ApplicationController
  respond_to :json

  def index
    @releases = Release.where search_params

    respond_with @releases
  end

  private
  def search_params
    params.permit(:artist_id, :name)
  end
end
