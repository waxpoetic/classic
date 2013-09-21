require 'concerns/user_authentication'

# Allow users to create and see their past filled orders. Requires a
# user to be authenticated for most actions.

class OrdersController < ApplicationController
  include UserAuthentication
  respond_to :json
  before_filter :authenticate_user_from_token!
  before_filter :find_or_set_user_object

  # List of all orders by this user.
  #
  # GET /orders
  def index
    @orders = @user.orders

    respond_with @orders
  end

  # Check out the current_user's "cart" Order.
  #
  # POST /orders
  def create
    if @user.cart.checkout params[:stripe_token]
      respond_with orders_path(id: current_user.cart.id)
    else
      render json: { errors: @cart.errors.full_messages }
    end
  end

  # GET /orders/1
  def show
    @order = @user.orders.find params[:id]
    respond_with @order
  rescue ActiveRecord::RecordNotFound
    render json: {
      errors: [
        "Couldn't find Order with ID=#{params[:id]}"
      ]
    }
  end

  # GET /cart
  def cart
    @order = @user.cart

    respond_with @order
  end
end
