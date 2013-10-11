require 'token_authenticatable/token'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable, :lockable

  has_many :past_orders, class_name: 'Order', \
    conditions: { is_checked_out: false }
  has_many :unfulfilled_orders, class_name: 'Order', \
    conditions: { is_checked_out: false }

  include TokenAuthenticatable::Token

  # The current order for the given user. If one can not be found, it
  # will be created and subsequently persisted.
  def cart
    @current_order ||= begin
      if unfulfilled_orders.any?
        unfulfilled_orders.first
      else
        unfulfilled_orders.create
      end
    end
  end
end
