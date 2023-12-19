class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.date :bill_date
      t.float :amount
      t.text :description
      t.float :days_worked
      t.float :rate
      t.text :status


      t.timestamps
    end
  end
end
