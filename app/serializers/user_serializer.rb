class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :api_key

  def api_key
    object.authentication_token
  end
end
