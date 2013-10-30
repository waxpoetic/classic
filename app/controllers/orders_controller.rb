# API for order history and current orders. POSTing a generated stripe
# token to /orders will check out the current order ("cart") with
# Stripe. Otherwise, you can GET /orders or /orders/:order_id to view
# any past orders you've made.

class OrdersController < ApplicationController
  respond_to :json

  before_filter :authenticate_user!
  before_filter :find_or_set_user, only: %w(index show)

  # List of all orders by this User.
  #
  # GET /orders
  # GET /users/1/orders
  def index
    @orders = if current_user.is_admin?
      Order.where search_params
    else
      current_user.orders.where search_params
    end

    respond_with @orders
  end

  # Check out the current_user's "cart" Order.
  #
  # POST /orders
  def create
    @cart = current_user.cart

    if @cart.checkout params[:stripe_token]
      respond_with @cart
    else
      render json: { errors: @cart.errors.full_messages }
    end
  end

  # Show a single order's details, including products.
  #
  # GET /orders/1
  # GET /users/1/orders/1
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
    @order = current_user.cart

    respond_with @order
  end
end
