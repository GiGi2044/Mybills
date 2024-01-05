class ServicesController < ApplicationController

  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
    @bill_id = params[:bill_id]
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      # Redirect to the bill form with a notice
      redirect_to new_bill_path(bill_id: @bill_id), notice: 'Service was successfully created.'
    else
      render :new
    end
  end

  private

  def service_params
    params.require(:service).permit(:description, :rate, :days_worked, :bill_id)
  end
end
