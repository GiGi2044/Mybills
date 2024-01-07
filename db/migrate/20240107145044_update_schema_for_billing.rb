class UpdateSchemaForBilling < ActiveRecord::Migration[7.1]
  def change
    # Remove bill_id from services
    remove_column :services, :bill_id, :bigint

    # Add rate and days_worked to bill_services
    add_column :bill_services, :rate, :float
    add_column :bill_services, :days_worked, :float

  end
end
