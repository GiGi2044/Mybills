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
      # Fetch the latest bill number for this client
      last_bill_number = client.bills.maximum(:customer_bill_number) || 0

      # Compare with total_bills_created and take the higher number
      next_bill_number = [last_bill_number, client.total_bills_created].max + 1

      # Update total_bills_created if necessary
      client.total_bills_created = next_bill_number if client.total_bills_created < next_bill_number
      client.save

      # Set the customer_bill_number
      self.customer_bill_number = next_bill_number
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
