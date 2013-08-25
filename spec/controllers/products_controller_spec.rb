require 'spec_helper'

describe ProductsController do
  fixtures :releases, :products
  let(:release) { releases :boyfriend }
  let(:product) { products :boyfriend_wav }
  before { sign_in! }

  context "listing all products in a release" do
    before { get :index, release_id: release.id }

    it "finds the release" do
      expect(assigns(:release)).to_not be_nil
      expect(assigns(:release)).to eq(release)
    end

    it "responds successfully" do
      expect(response).to be_success
    end

    it "lists all products in a release" do
      expect(assigns(:products)).to_not be_nil
      expect(assigns(:products)).to_not be_empty
      expect(assigns(:products)).to include(product)
    end
  end

  context "showing a single product of a release" do
    before { get :show, release_id: release.id, id: product.id }

    it "finds the release" do
      expect(assigns(:release)).to eq(release)
    end

    it "responds successfully" do
      expect(response).to be_success
    end

    it "finds the product" do
      expect(assigns(:product)).to eq(product)
    end
  end

  context "adding a product to the cart" do
    before { get :buy, release_id: release.id, id: product.id }

    it "finds the release" do
      expect(assigns(:release)).to eq(release)
    end

    it "finds the product" do
      expect(assigns(:product)).to eq(product)
    end

    it "responds successfully" do
      expect(response).to be_success
    end

    it "shows up in the current_user's cart" do
      expect(@user.reload).to be_true
      expect(@user.cart.products).to include(product)
    end
  end
end
