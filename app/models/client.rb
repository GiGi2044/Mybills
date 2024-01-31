class Client < ApplicationRecord
  belongs_to :user
  has_many :bills
  validates :client_name, presence: true
  validates :client_address, presence: true
  validates :client_email, presence: true
  validates :client_city, presence: true

  validates :client_number, presence: true, uniqueness: { scope: :id}

  before_validation :set_client_number, on: :create

  def set_client_number
    max_number = Client.where(user_id: self.user_id).maximum(:client_number) || 0
    self.client_number = max_number + 1
  end

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
