module HandleHtmlRequests
  extend ActiveSupport::Concern

  included { before_filter :handle_html_requests }

  protected
  def handle_html_requests
    return if json_request? || whitelisted?
    return if request.xhr?
    respond_to { |format| format.html { render 'application/index' } }
  end

  private
  def whitelisted?
    params[:controller] =~ /admin|devise/
  end

  def json_request?
    "#{params[:format]}" == 'json'
  end
end
