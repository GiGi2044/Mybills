class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    bills_path # Or any other path you wish to redirect to
  end
end
