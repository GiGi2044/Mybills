class Service < ApplicationRecord
  belongs_to :user
  has_many :bill_services
  has_many :bills, through: :bill_services

  validates :service_number, presence: true, uniqueness: { scope: :id}

  before_validation :set_service_number, on: :create

  def total_amount
    days_worked * rate
  end

  def set_service_number
    max_number = Service.where(user_id: self.user_id).maximum(:service_number) || 0
    self.service_number = max_number + 1
  end

  include PgSearch::Model
  pg_search_scope :search_by_description,
    against: [ :description ],
    using: {
      tsearch: { prefix: true }
    }

  # Scope for active services
  scope :active, -> { where(deleted_at: nil) }
  # Scope for deleted services
  scope :deleted, -> { where.not(deleted_at: nil) }

end
