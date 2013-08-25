# Allow users to create and see their past filled orders.
class OrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # GET /orders
  def index
    @orders = current_user.orders.filled

    respond_with @orders
  end

  # Check out the current_user's "cart" Order.
  #
  # POST /orders
  def create
    if current_user.cart.checkout params[:stripe_token]
      respond_with orders_path(id: current_user.cart.id)
    else
      render json: { errors: @cart.errors.full_messages }
    end
  end

  # GET /orders/1
  def show
    @order = current_user.orders.find params[:id]
    respond_with @order
  rescue ActiveRecord::RecordNotFound
    render json: {
      errors: [
        "Couldn't find Order with ID=#{params[:id]}"
      ]
    }
  end
end
