class CreateBillServices < ActiveRecord::Migration[7.1]
  def change
    create_table :bill_services do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
