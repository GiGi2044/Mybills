class ServicesController < ApplicationController

  def index
    if params[:query].present?
      @services = Service.search_by_service_name(params[:query])
    else
      @services = current_user.services
    end
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

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @services = current_user.services
    @service = Service.find(params[:id])
    @service.update(service_params)
    redirect_to services_path, notice: 'Service was successfully updated.'
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to services_path, notice: 'Service was successfully deleted.'
  end

  private

  def service_params
    params.require(:service).permit(:description, :rate, :days_worked,)
  end
end
