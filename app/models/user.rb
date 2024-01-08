class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :clients
  has_many :bills
  has_many :services

  validates :fullname, presence: true, if: :signed_up?
  validates :business_name, presence: true, if: :signed_up?
  validates :email, presence: true, if: :signed_up?
  validates :street, presence: true, if: :signed_up?
  validates :city, presence: true, if: :signed_up?
  validates :bank_name, presence: true, if: :signed_up?
  validates :iban, presence: true, if: :signed_up?
  validates :bic, presence: true,if: :signed_up?
  validates :account_number, presence: true, if: :signed_up?
  validates :phone_number, presence: true, if: :signed_up?

  private

  def signed_up?
    self.is_signed_up
  end
end
