module HandleHtmlRequests
  extend ActiveSupport::Concern

  included { before_filter :handle_html_requests }

  protected
  def handle_html_requests
    return if admin_interface? || json_request?
    return if request.xhr?
    respond_to { |format| format.html { render 'application/index' } }
  end

  private
  def admin_interface?
    params[:controller] =~ /admin/
  end

  def json_request?
    "#{params[:format]}" == 'json'
  end
end
