class AddContactDetailsToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :contact_name, :string
    add_column :clients, :city, :string
  end
end
