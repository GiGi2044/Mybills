class AddBillNumberFieldToClientAndService < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :service_number, :integer
    add_column :clients, :client_number, :integer
  end
end
