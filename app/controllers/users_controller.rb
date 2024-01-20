class UsersController < ApplicationController
  def index
    @user_id = current_user.id
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)
    redirect_to root_path, notice: 'User was succesfully updated'
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :address, :fullname, :business_name, :street, :city, :bank_name, :iban, :bic, :account_number, :phone_number)
  end
end
