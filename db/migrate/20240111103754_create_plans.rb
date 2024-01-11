class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
