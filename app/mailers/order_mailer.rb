class OrderMailer < ActionMailer::Base
  default from: "orders@waxpoeticrecords.com"

  def processed order
    @order = order

    mail \
      to: @order.user.email,
      subject: "Your order has been processed (##{@order.id})"
  end

  def shipped order
    @order = order

    mail \
      to: @order.user.email,
      subject: "Your order has been shipped (#{@order.id})"
  end

  def downloadable order
    @order = order

    mail \
      to: @order.user.email,
      subject: "Your order is ready for download (#{@order.id})"
  end
end
