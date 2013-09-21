require 'token_authenticatable/token'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable, :lockable
  has_many :orders

  include TokenAuthenticatable::Token

  # The current order for the given user. If one can not be found, it
  # will be created and subsequently persisted.
  def cart
    @current_order ||= begin
      orders_not_checked_out = orders.where is_checked_out: false

      if orders_not_checked_out.any?
        orders_not_checked_out.first
      else
        orders.create
      end
    end
  end

end
