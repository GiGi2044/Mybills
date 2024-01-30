class Bill < ApplicationRecord
  attr_accessor :current_user

  belongs_to :user

  belongs_to :client

  has_many :bill_services, dependent: :destroy
  has_many :services, through: :bill_services

  validates :client_id, presence: true
  validates :bill_date, presence: true



  validates :customer_bill_number, presence: true, uniqueness: { scope: :client_id }

  before_validation :set_bill_numbers, on: :create

  def set_bill_numbers
    if client.present?
      self.customer_bill_number = client.bills.where(user_id: self.user_id).maximum(:customer_bill_number).to_i + 1
    end
  end




  def grand_total
    services.sum(&:total_amount)
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
