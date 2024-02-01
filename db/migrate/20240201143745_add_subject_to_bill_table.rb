class AddSubjectToBillTable < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :subject, :string
  end
end
