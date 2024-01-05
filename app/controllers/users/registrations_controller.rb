class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    edit_user_path(resource) # Redirects to the user's edit path
  end
end
