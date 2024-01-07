class AddUserToServices < ActiveRecord::Migration[7.1]
  def change
    add_reference :services, :user, null: true, foreign_key: true
  end
end
