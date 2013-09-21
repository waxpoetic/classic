require 'concerns/token_authenticatable'
require 'concerns/cart'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable, :lockable
  has_many :orders

  include TokenAuthenticatable
  include Cart
end
