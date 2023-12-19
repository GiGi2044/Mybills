class ApplicationMailer < ActionMailer::Base
  default from: -> { current_user_email }
  layout "mailer"
end
