module ControllerAuthorization
  extend ActiveSupport::Concern
  included { fixtures :users }

  def sign_in!
    @user = users :tubbo
    sign_in @user
  end
end
