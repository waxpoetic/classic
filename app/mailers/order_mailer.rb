# Sends emails when orders have reached different states of completion,
# such as "processed" (charged), "shipped", and "downloadable".
class OrderMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "orders@waxpoeticrecords.com"

  def processed order
    @order = order
    @user = @order.user

    mail \
      to: @user.email,
      subject: "Your order has been processed (##{@order.id})"
  end

  def shipped order
    @order = order
    @user = @order.user

    mail \
      to: @user.email,
      subject: "Your order has been shipped (#{@order.id})"
  end

  def downloadable order
    @order = order
    @user = @order.user

    mail \
      to: @user.email,
      subject: "Your order is ready for download (#{@order.id})"
  end
end
