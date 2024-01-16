class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_google(from_google_params)

    if user.present?
      sign_out_all_scopes
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'

      # Check if it's the user's first sign in
      if user.last_sign_in_at.nil?
        # Redirect to a specific path on first sign in
        redirect_path = first_time_sign_in_path
      else
        # Redirect to a different path on subsequent sign ins
        redirect_path = subsequent_sign_in_path
      end

      sign_in_and_redirect user, event: :authentication, location: redirect_path
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  private

  def first_time_sign_in_path
    # Define the path for first-time sign in
    your_first_time_sign_in_path
  end

  def subsequent_sign_in_path
    # Define the path for subsequent sign ins
    your_subsequent_sign_in_path
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
