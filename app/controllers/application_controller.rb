class ApplicationController < ActionController::Base

  private

  def current_user_email
    current_user || "default@example.com"
  end
end
