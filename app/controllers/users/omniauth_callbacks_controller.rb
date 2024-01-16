class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_google(from_google_params)

    Rails.logger.debug "User found: #{user.inspect}" # Debug output

    if user.present?
      sign_out_all_scopes
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'

      redirect_path = user.last_sign_in_at.nil? ? first_time_sign_in_path : subsequent_sign_in_path
      Rails.logger.debug "Redirect path: #{redirect_path}" # Debug output

      sign_in_and_redirect user, event: :authentication, location: redirect_path
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  private

  def first_time_sign_in_path
    # Define the path for first-time sign in
    welcome_path
  end

  def subsequent_sign_in_path
    # Define the path for subsequent sign ins
    bills_path
  end

   def from_google_params
     @from_google_params ||= {
       uid: auth.uid,
       email: auth.info.email
     }
   end

   def auth
     @auth ||= request.env['omniauth.auth']
   end
end
