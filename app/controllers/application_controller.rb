class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def current_user_email
    current_user || "default@example.com"
  end
end
