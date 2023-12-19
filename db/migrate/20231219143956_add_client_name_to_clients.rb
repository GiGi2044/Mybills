class AddClientNameToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :client_name, :string
  end
end
