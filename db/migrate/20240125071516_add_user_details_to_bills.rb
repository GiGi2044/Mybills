class AddUserDetailsToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :user_email, :string
    add_column :bills, :user_fullname, :string
    add_column :bills, :user_business_name, :string
    add_column :bills, :user_street, :string
    add_column :bills, :user_city, :string
    add_column :bills, :user_bank_name, :string
    add_column :bills, :user_iban, :string
    add_column :bills, :user_bic, :string
    add_column :bills, :user_account_number, :string
    add_column :bills, :user_phone_number, :string
  end
end
