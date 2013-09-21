require 'token_authenticatable/authentication'
require 'handle_html_requests'
require 'user_finder'

# Methods inherited by all controllers. Enables optional token
# authentication, handling HTML requests, and finding users by
# current_user or ID.

class ApplicationController < ActionController::Base
  include TokenAuthenticatable::Authentication
  include HandleHtmlRequests
  include UserFinder

  protect_from_forgery
end
