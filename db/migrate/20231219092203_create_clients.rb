class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.references :user, null: false, foreign_key: true
      t.string :client_name
      t.string :client_address
      t.string :client_email
      t.string :client_phone

      t.timestamps
    end
  end
end
