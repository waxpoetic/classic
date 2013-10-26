require 'spec_helper'

describe OrdersController do
  fixtures :orders

  let(:past_order) { orders :wonderbars_discography }

  context "when logged in" do
    let(:user) { users :customer }
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm!
      sign_in user
    end

    context "viewing all order history" do
      before { get :index, user_id: user.id, format: :json }

      it "responds successfully" do
        expect(response).to be_success, "#{response.status}"
      end

      it "finds the user" do
        expect(assigns(:user)).to eq(user)
      end

      it "includes the past order in the results" do
        expect(assigns(:orders)).to include(past_order)
      end
    end

    context "viewing a past order" do
      before { get :show, user_id: user.id, id: past_order.id, format: :json }

      it "responds successfully" do
        expect(response).to be_success, "#{response.status}"
      end

      it "responds with the past order" do
        expect(assigns(:order)).to eq(past_order)
      end
    end

    context "viewing the current order" do
      it "shows your cart" do
        get :cart, user_id: user.id, format: :json

        response.should be_success, "#{response.status}"
      end
    end
  end
end
