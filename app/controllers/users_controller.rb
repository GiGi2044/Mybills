class UsersController < ApplicationController
  before_action :authenticate_user!
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

    if @user.update(user_params)
      redirect_to root_path, notice: 'User was successfully updated'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :address, :fullname, :business_name, :street, :city, :bank_name, :iban, :bic, :account_number, :phone_number)
  end
end
