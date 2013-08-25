class CartController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def show
    @cart = current_user.cart

    respond_with @cart
  end
end
