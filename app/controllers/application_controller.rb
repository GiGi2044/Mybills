class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?

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

  def timeout
    return super if current_user

    flash[:alert] = "Your session has timed out. Please log in again"
    redirect_to new_user_session_path
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end
end
