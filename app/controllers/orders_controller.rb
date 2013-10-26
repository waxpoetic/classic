# API for order history and current orders. POSTing a generated stripe
# token to /orders will check out the current order ("cart") with
# Stripe. Otherwise, you can GET /orders or /orders/:order_id to view
# any past orders you've made.

class OrdersController < ApplicationController
  respond_to :json

  before_filter :authenticate_user!
  before_filter :find_or_set_user

  # List of all orders by this User.
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

  # The unfulfilled order for the current user. If no such order exists,
  # it is created.
  #
  # GET /cart
  def cart
    @order = @user.cart

    respond_with @order
  end
end
