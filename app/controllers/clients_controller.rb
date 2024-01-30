class ClientsController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:query].present?
      @clients = current_user.clients.active.search_by_client_name(params[:query])
    else
    @clients = current_user.clients.where(deleted_at: nil)
    end
    @bills = current_user.bills
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = current_user.clients.build(client_params)

    if @client.save
      # Check where the request came from
      if request.referer.include?(new_bill_path)
        redirect_back(fallback_location: new_bill_path, notice: 'Client was successfully created')
      else
        redirect_to clients_path, notice: 'Client was successfully created'
      end
    else
      render :new
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    original_client = Client.find(params[:id])

    # Clone the original client and apply updates
    new_client = original_client.dup
    new_client.assign_attributes(client_params)
    new_client.deleted_at = nil # Reset soft delete flag for the new record

    Client.transaction do
      new_client.save!
      original_client.update!(deleted_at: Time.current) # Soft delete the original
    end
    if request.referer.include?(new_bill_path)
      redirect_back(fallback_location: new_bill_path, notice: 'Client was successfully updated')
    else
      redirect_to clients_path, notice: 'Client was successfully updated'
    end
  rescue ActiveRecord::RecordInvalid => e
    @services = current_user.services
    render :edit
  end

  def destroy
    @client = Client.find(params[:id])
    @client.update(deleted_at: Time.current) # Soft delete
    redirect_to clients_path, notice: 'Client was successfully destroyed'
  end

  private

  def client_params
    params.require(:client).permit(:client_name, :client_address, :client_email, :client_phone, :client_city, :contact_name)
  end
end
