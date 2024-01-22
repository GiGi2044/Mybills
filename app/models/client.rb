class Client < ApplicationRecord
  belongs_to :user
  has_many :bills
  validates :client_name, presence: true
  validates :client_address, presence: true
  validates :client_email, presence: true
  validates :client_city, presence: true

  include PgSearch::Model
pg_search_scope :search_by_client_name,
  against: [ :client_name ],
  using: {
    tsearch: { prefix: true }
  }

  # Scope for active services
  scope :active, -> { where(deleted_at: nil) }
  # Scope for deleted services
  scope :deleted, -> { where.not(deleted_at: nil) }

end
