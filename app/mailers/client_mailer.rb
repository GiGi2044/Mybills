class ClientMailer < ApplicationMailer
  def bill_created_email(bill, current_user)
    @bill = bill
    @client = bill.client
    @current_user = current_user
    mail(to: @client.client_email, from: current_user_email, subject: 'New Bill Created')
  end
end
