class ClientMailer < ApplicationMailer
  def bill_created_email(client)
    @client = client
    mail(to: @client.client_email, subject: 'New Bill Created')
  end
end
