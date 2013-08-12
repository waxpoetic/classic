class ReleasesController < ApplicationController
  respond_to :json

  def index
    @releases = Release.all

    respond_with @releases
  end
end
