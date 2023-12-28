class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :fullname, :string
    add_column :users, :business_name, :string
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :bank_name, :string
    add_column :users, :iban, :string
    add_column :users, :bic, :string
    add_column :users, :account_number, :string
  end
end
