class ServicesController < ApplicationController

  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
  end

  def create
    @service = current_user.services.build(service_params)
    if @service.save
      redirect_to new_bill_path(:service_id, @service.id), notice: 'Service was succesfully created.'
    else
      render 'bills/add_services'
    end
  end

  private

  def service_params
    params.require(:service).permit(:description, :rate, :days_worked,)
  end
end
