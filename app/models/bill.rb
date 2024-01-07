class Bill < ApplicationRecord
  attr_accessor :current_user

  belongs_to :user

  belongs_to :client

  has_many :bill_services
  has_many :services, through: :bill_services

  validates :client_id, presence: true
  validates :bill_date, presence: true

  def total
    days_worked.to_f * rate.to_f
  end

  include PgSearch::Model
  pg_search_scope :search_by_bill_date_and_status,
    against: [:status, :bill_date],
    associated_against: {
      client: [:client_name]
    },
    using: {
      tsearch: { prefix: true }
    }
end
