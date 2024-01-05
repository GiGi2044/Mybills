class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.references :bill, null: false, foreign_key: true
      t.text :description
      t.float :rate
      t.float :days_worked

      t.timestamps
    end
  end
end
