require "spec_helper"

describe OrderMailer do
  context "with a merchandise order" do
    let(:order) { orders :subatomica_shirt }

    context "when the order has been processed" do
      let(:email) { OrderMailer.processed(order).deliver }

      it "sends an email when the order has been processed" do
        expect(email).to have_subject(/\AYour order has been processed/)
      end

      it "is delivered to the email attached to the order" do
        expect(email).to be_delivered_to(order.user.email)
      end
    end

    context "when the order has been shipped" do
      let(:email) { OrderMailer.shipped(order).deliver }

      it "sends an email when the order has shipped" do
        expect(email).to have_subject(/\AYour order has been shipped/)
      end

      it "is delivered to the email attached to the order" do
        expect(email).to be_delivered_to(order.user.email)
      end
    end
  end

  context "with a virtual order" do
    let(:order) { orders :wonderbars_discography }

    context "when the order has been processed" do
      let(:email) { OrderMailer.downloadable(order).deliver }

      it "sends an email when an order is ready for download" do
        expect(email).to have_subject(/\AYour order is ready for download/)
      end

      it "is delivered to the email attached to the order" do
        expect(email).to be_delivered_to(order.user.email)
      end

      it "notifies user of their unique download location" do
        expect(email).to have_body_text(/Download:/)
      end
    end
  end
end
