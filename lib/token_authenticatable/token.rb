require 'active_support/concern'

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_validation :ensure_authentication_token
    validate :authentication_token, presence: true
  end

  def ensure_authentication_token
    self.authentication_token = generate_authentication_token \
      if authentication_token.blank?
  end

  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      return token unless token_taken? token
    end
  end

  def token_taken? token
    User.where(authentication_token: token).any?
  end
end
