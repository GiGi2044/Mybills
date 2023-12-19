class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :client
  validates :client_id, presence: true

  after_create :send_email_to_client

  def send_email_to_client
    ClientMailer.bill_created_email(client).deliver_now
  end
end
