class HomeController < ApplicationController
  def index
    @plans = Plan.all
    if user_signed_in?
      @plans = Plan.all
      @bills = current_user.bills
      @bills_count = @bills.count
      @unsent_bills_count = @bills.where(status: 'unsent').count
      @sent_bills_count = @bills.where(status: 'sent').count
      @paid_bills_count = @bills.where(status: 'paid').count
    else
      @plans = Plan.all
    end
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def about
  end

  def welcome
  end
end
