class CurrencyToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :currency, :string
  end
end
