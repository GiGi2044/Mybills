class AddCustomerBillNumberToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :customer_bill_number, :integer
  end
end
