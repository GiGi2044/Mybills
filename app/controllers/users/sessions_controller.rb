class Users::SessionsController < Devise::SessionsController
  def destroy
    super
  end

  protected

  # This method is called when a user is automatically signed out due to timeout
  def auto_sign_out
    flash[:notice] = "Your session has timed out. Please sign in again to continue."
    redirect_to root_path
  end
end
