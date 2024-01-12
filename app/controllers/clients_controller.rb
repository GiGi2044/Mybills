class ClientsController < ApplicationController

  def index
    @clients = current_user.clients
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
      redirect_to new_bill_path(client_id: @client.id), notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    @clients = current_user.clients

    @bill.client.update(client_params)
    redirect_to clients_path, notice: 'Client was successfully updated.'
  end

  def destroy
  end

  private

  def client_params
    params.require(:client).permit(:client_name, :client_address, :client_email, :client_phone, :city, :contact_name)
  end
end
