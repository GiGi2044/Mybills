class ChangeCityNameForClients < ActiveRecord::Migration[7.1]
  def change
    rename_column :clients, :city, :client_city
  end
end
