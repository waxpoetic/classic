class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :handle_html_requests

  private
  def handle_html_requests
    unless params[:controller] =~ /admin/
      return if request.xhr?
      respond_to { |format| format.html { render 'application/index' } }
    end
  end
end
