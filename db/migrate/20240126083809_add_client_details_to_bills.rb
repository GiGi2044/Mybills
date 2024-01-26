class AddClientDetailsToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :client_name, :string
    add_column :bills, :client_address, :string
    add_column :bills, :client_phone, :string
    add_column :bills, :client_email, :string
    add_column :bills, :client_city, :string
    add_column :bills, :contact_name, :string
  end
end
