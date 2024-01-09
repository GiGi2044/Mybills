class Service < ApplicationRecord
  belongs_to :user
  has_many :bill_services
  has_many :bills, through: :bill_services

  def total_amount
    days_worked * rate
  end
end
