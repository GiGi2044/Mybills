class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def new
    @bill = Bill.new
    @clients = current_user.clients
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.user = current_user
    @clients = current_user.clients

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bills_path, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_path, notice: 'Bill was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@bill) }
    end
  end

  def update_status
    @bill = Bill.find(params[:id])
    if @bill.update(status: params[:bill][:status])
      redirect_to bills_path, notice: 'Status updated successfully.'
    else
      # Handle the case where the update fails, e.g., validation errors
      flash[:alert] = 'Failed to update status.'
      render :index
    end
  end

  def generate_pdf
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.pdf do
        render pdf: 'bill',
              template: 'bills/bill_template',
              layout: 'pdf.html',
              encoding: 'UTF-8'
      end
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:user_id, :client_id, :bill_date, :amount, :description, :days_worked, :rate, :status)
  end
end
