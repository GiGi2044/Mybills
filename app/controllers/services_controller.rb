class ServicesController < ApplicationController

  def index
    if params[:query].present?
      @services = current_user.services.active.search_by_description(params[:query])
    else
      @services = current_user.services.where(deleted_at: nil)
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
      # Check where the request came from
      if request.referer.include?(new_bill_path)
        redirect_back(fallback_location: new_bill_path, notice: 'Client was successfully created.')
      else
        redirect_to services_path, notice: 'Client was successfully created.'
      end
    else
      render 'bills/add_services'
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    original_service = Service.find(params[:id])

    # Clone the original service and apply updates
    new_service = original_service.dup
    new_service.assign_attributes(service_params)
    new_service.deleted_at = nil # Assuming you have a deleted_at column for soft delete

    Service.transaction do
      new_service.save!
      original_service.update!(deleted_at: Time.current) # Soft delete the original
    end

    redirect_to services_path, notice: 'Service was successfully updated.'
  rescue ActiveRecord::RecordInvalid => e
    @services = current_user.services
    render :edit
  end

  def destroy
    @service = Service.find(params[:id])
    @service.update(deleted_at: Time.current) # Soft delete
    redirect_to services_path, notice: 'Service was successfully deleted.'
  end

  private

  def service_params
    params.require(:service).permit(:description, :rate, :days_worked,)
  end
end
