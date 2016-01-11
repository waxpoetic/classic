class ReleasesController < ApplicationController
  respond_to :json

  def index
    @releases = Release.where(search_params).order 'released_at DESC'

    respond_with @releases
  end

  def show
    @release = Release.find params[:id]
    render json: { errors: ["Release not found."] } and return \
      unless @release.present?

    respond_with @release
  end

  private
  def search_params
    params.permit(:artist_id, :name)
  end
end
