class ClientsController < ApplicationController

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
        redirect_back(fallback_location: new_bill_path, notice: 'Client was successfully created.')
      else
        redirect_to clients_path, notice: 'Client was successfully created.'
      end
    else
      render :new
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    @clients = current_user.clients

    @client.update(client_params)
    redirect_to clients_path, notice: 'Client was successfully updated.'
  end

  def destroy
    @client = Client.find(params[:id])
    @client.update(deleted_at: Time.current) # Soft delete
    redirect_to clients_path, notice: 'Client was successfully destroyed.'
  end

  private

  def client_params
    params.require(:client).permit(:client_name, :client_address, :client_email, :client_phone, :city, :contact_name)
  end
end
