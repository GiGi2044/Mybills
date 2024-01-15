class Client < ApplicationRecord
  belongs_to :user
  has_many :bills
  validates :client_name, presence: true
  validates :client_address, presence: true
  validates :client_email, presence: true
  validates :city, presence: true

  include PgSearch::Model
pg_search_scope :search_by_client_name,
  against: [ :client_name ],
  using: {
    tsearch: { prefix: true }
  }
end
