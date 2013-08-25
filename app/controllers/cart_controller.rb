# The 'cart' of the current User represents the Order they are currently
# waiting to be fulfilled.
class CartController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # GET /users/1/cart
  def show
    @cart = current_user.cart

    respond_with @cart
  end

  private
  def find_current_order
    @cart = current_user.cart
  end
end
