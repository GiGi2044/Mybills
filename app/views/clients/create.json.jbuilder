if @client.persisted?
  json.inserted_item render(partial: 'clients/client_list', locals: { client: @client }, formats: [:html])
  json.form render(partial: 'clients/form', locals: { client: Client.new }, formats: [:html])
else
  json.form render(partial: 'clients/form', locals: { client: @client }, formats: [:html])
end
