class OrderMailer < ApplicationMailer
  default from: "noreply@ekaart.com"

  def order_confirmed_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Order Confirmation")
  end
end
