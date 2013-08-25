# Allow users to create and see their current/past orders.
class OrdersController < ApplicationController
  respond_to :json

  # GET /orders
  def index
    @orders = current_user.orders

    respond_with @orders
  end

  # POST /orders
  def create
    @order = Order.create creatable_params

    if @order.save
      respond_with @order
    else
      render json: { errors: @order.errors.full_messages }
    end
  end

  # GET /orders/1
  def show
    @order = Order.find params[:id]
    respond_with @order
  rescue ActiveRecord::RecordNotFound
    render json: {
      errors: [
        "Couldn't find Order with ID=#{params[:id]}"
      ]
    }
  end
end
