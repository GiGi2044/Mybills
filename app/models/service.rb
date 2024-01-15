class Service < ApplicationRecord
  belongs_to :user
  has_many :bill_services
  has_many :bills, through: :bill_services

  def total_amount
    days_worked * rate
  end

  include PgSearch::Model
  pg_search_scope :search_by_description,
    against: [ :description ],
    using: {
      tsearch: { prefix: true }
    }
end
