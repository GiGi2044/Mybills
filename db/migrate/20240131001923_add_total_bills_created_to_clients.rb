class AddTotalBillsCreatedToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :total_bills_created, :integer, default: 0
  end
end
