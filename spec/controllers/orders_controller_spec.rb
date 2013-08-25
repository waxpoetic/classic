require 'spec_helper'

describe OrdersController do
  before { sign_in! }
  fixtures :orders
  let(:past_order) { orders :wonderbars_discography }

  context "viewing all order history" do
    before { get :index }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "includes the past order in the results" do
      expect(assigns(:orders)).to include(past_order)
    end
  end

  context "viewing a past order" do
    before { get :show, id: past_order.id }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "responds with the past order" do
      expect(assigns(:order)).to eq(past_order)
    end
  end

  context "viewing the current order" do
    it "shows your cart" do
      get :cart

      response.should be_success
    end
  end
end
