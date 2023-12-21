class ApplicationMailer < ActionMailer::Base
  before_action :set_mailer_defaults
  layout "mailer"

  private

  def set_mailer_defaults
    ActionMailer::Base.default from: current_user_email
  end

  def current_user_email
    @current_user&.email || "default@example.com"
  end
end
