class ApplicationController < ActionController::Base

  def default_url_options
  { host: ENV["justinvoice.it"] || "localhost:3000" }
  end

  private
  def after_sign_in_path_for(resource)
    # Check if it's the user's first sign in
    if resource.sign_in_count == 1
      # Redirect to the welcome path on first sign in
      welcome_path(resource)
    else
      # Redirect to the root path on subsequent sign ins
      root_path
    end
  end

  def current_user_email
    current_user || "default@example.com"
  end

  def verify_signed_out_user
    if all_signed_out?
      auto_sign_out
    else
      super
    end
  end

  def all_signed_out?
    !user_signed_in?
  end
end
