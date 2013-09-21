# View the various versions of each Release that's distributed on this
# site.
class ProductsController < ApplicationController
  respond_to :json

  before_filter :find_release
  before_filter :find_product, only: %w(show buy)
  before_filter :find_or_set_user, only: %w(buy)

  def index
    @products = @release.products

    respond_with @products
  end

  def show
    respond_with @product
  end

  def buy
    if current_user.cart.add @product
      redirect_to cart_path
    else
      render json: { errors: current_user.cart.errors.full_messages }
    end
  end

  private
  def find_release
    @release = Release.find params[:release_id]
    render json: { errors: [ 'Release not found.' ] }, status: 404 and return \
      unless @release.present?
  end

  def find_product
    @product = @release.products.find params[:id]
    render json: { errors: [ "Version not found." ] } and return \
      unless @product.present?
  end
end
