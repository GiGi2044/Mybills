class AddCcToBillTable < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :cc, :string
  end
end
