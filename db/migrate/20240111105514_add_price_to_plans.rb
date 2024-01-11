class AddPriceToPlans < ActiveRecord::Migration[7.1]
  def change
    add_monetize :plans, :price, currency: { present: false }
  end
end
