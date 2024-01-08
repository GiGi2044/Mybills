class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :clients
  has_many :bills
  has_many :services

  validates :fullname, presence: true
  validates :business_name, presence: true
  validates :email, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :bank_name, presence: true
  validates :iban, presence: true
  validates :bic, presence: true
  validates :account_number, presence: true
  validates :phone_number, presence: true
end
