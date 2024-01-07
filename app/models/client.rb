class Client < ApplicationRecord
  belongs_to :user
  has_many :bills
  validates :client_name, presence: true
  validates :client_address, presence: true
  validates :client_email, presence: true
  validates :city, presence: true
end
