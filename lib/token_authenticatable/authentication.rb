require 'devise'

# Controller-level methods for token authentication. Wraps Devise's
# authentication methods to support finding a User by its given
# user_token in the params. Include this into any controller to require
# user authentication for requests made inside the object.

module UserAuthentication
  protected
  def authenticate_user_from_token!
    authenticate_user! unless found_user && authenticated_with_token?
    sign_in found_user, store: false
  end

  private
  def authenticated_with_token?
    Devise.secure_compare found_user.authentication_token, user_token
  end

  def found_user
    @user ||= user_email && User.where(email: user_email).first
  end

  def user_email
    params[:user_email].presence
  end

  def user_token
    params[:user_token].presence
  end
end
