class AddUserBillNumberToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :user_bill_number, :integer
  end
end
