class HomeController < ApplicationController
  def index
    @plans = Plan.all
    @bills = current_user.bills
    @bills_count = @bills.count
    @unsent_bills_count = @bills.where(status: 'unsent').count
    @sent_bills_count = @bills.where(status: 'sent').count
    @paid_bills_count = @bills.where(status: 'paid').count
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def about
  end

  def welcome
  end
end
