class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :blankify_html

  def index
    logger.info "Starting Ember app.."
  end

  private
  def blankify_html
    return if request.xhr?
    respond_to { |format| format.html { render 'application/index' } }
  end
end
