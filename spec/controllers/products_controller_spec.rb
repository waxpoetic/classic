require 'spec_helper'

describe ProductsController do
  fixtures :releases, :products

  let(:release) { releases :boyfriend }
  let(:product) { products :boyfriend_wav }

  context "listing all products in a release" do
    before { get :index, format: :json, release_id: release.id }

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
    before { get :show, format: :json, release_id: release.id, id: product.id }

    it "finds the release" do
      expect(assigns(:release)).to eq(release)
    end

    it "responds successfully" do
      expect(response).to be_success, "#{response.status}"
    end

    it "finds the product" do
      expect(assigns(:product)).to eq(product)
    end
  end

  context "when logged in" do
    let(:user) { users :customer }
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm!
      sign_in user
    end

    context "adds a product to the cart" do
      before do
        get :buy, {
          format: :json,
          release_id: release.id,
          id: product.id
        }
      end

      it "and uses the correct user" do
        expect(assigns(:user)).to eq(user)
      end

      it "and finds the release" do
        expect(assigns(:release)).to eq(release)
      end

      it "and finds the product" do
        expect(assigns(:product)).to eq(product)
      end

      it "and responds successfully" do
        expect(response).to be_success, "#{response.status}"
      end

      context "in the user object" do
        before { user.reload }

        it "shows up in the cart" do
          expect(user.cart.products).to include(product)
        end
      end
    end
  end
end
