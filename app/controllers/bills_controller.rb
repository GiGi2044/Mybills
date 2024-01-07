class BillsController < ApplicationController
  def index
    if params[:query].present?
      @bills = Bill.search_by_bill_date_and_status(params[:query])
    else
      @bills = Bill.all
    end
    @client = Client.new
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def new
    @bill = Bill.new
    @clients = current_user.clients
    @services = Service.all
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
        puts @bill.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @bill = Bill.find(params[:id])
    @clients = current_user.clients
  end

  def update
    @bill = Bill.find(params[:id])
    @clients = current_user.clients


    @bill.update(bill_params)
    redirect_to bills_path, notice: 'Bill was successfully updated.'
  end

  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy
    redirect_to bill_path, notice: 'Bill was successfully destroyed.'
  end

  def update_status
    @bill = Bill.find(params[:id])
    if @bill.update(status: params[:bill][:status])
      redirect_to bills_path, notice: 'Status updated successfully.'
    else
      flash[:alert] = 'Failed to update status.'
      render :index
    end
  end

  def download
    pdf = Prawn::Document.new
    pdf.text "Hello World"
    send_data(pdf.render,
        filename: "hello.pdf",
        type: "application/pdf")
  end

  def send_email
    @bill = Bill.find(params[:id])
    @bill.update(status: 'sent') if @bill.status == 'unsent'
    pdf_document = generate_pdf(@bill, current_user)
    UserMailer.send_bill_email(@bill, current_user, pdf_document).deliver_now

    respond_to do |format|
      format.html { redirect_to bills_path, notice: 'Email sent successfully' }
      format.js
    end
  end

  def pdf
    @bill = Bill.find(params[:id])
    pdf_document = generate_pdf(@bill, current_user)
    send_data(pdf_document.render, filename: "bill.pdf", type: "application/pdf", disposition: "inline")
  end

  private

  def generate_pdf(bill, user)
    client = bill.client

    Prawn::Document.new do |pdf|

    initial_y = pdf.cursor
    initialmove_y = 5
    address_x = 5
    invoice_header_x = 325
    lineheight_y = 12
    font_size = 9

    business_name = user.business_name
    business_address = user.street
    business_location = user.city

    invoice_number = bill.id
    invoice_date = bill.bill_date

    bank_details1_x = 50
    bank_details2_x_title = 280
    bank_details2_x = 340
    bank_name = user.bank_name
    bank_iban = user.iban
    bank_bic = user.bic
    bank_account_number = user.account_number

    client_name = client.client_name
    client_contact_name = client.contact_name
    client_address = client.client_address
    client_city = client.city

    customer_id = client.id
    customer_terms = "30"

    bill_description = bill.description
    bill_days = bill.days_worked
    bill_rate = bill.rate
    bill_amount = bill.total

    contact_text = "If you have any questions about this invoice, please contact"
    contact_text_start_position = 120
    contact_details = "#{user.fullname}, #{user.phone_number}, #{user.email}"
    contact_details_start_position = 120


    pdf.move_down initialmove_y
    # user details
    pdf.text_box business_name, :at => [address_x,  pdf.cursor]
    pdf.move_down lineheight_y
    pdf.text_box business_address, :at => [address_x,  pdf.cursor]
    pdf.move_down lineheight_y
    pdf.text_box business_location, :at => [address_x,  pdf.cursor]
    pdf.move_down lineheight_y

    last_measured_y = pdf.cursor

    pdf.move_up 40

    invoice_header_data = [
      ["INVOICE"],
    ]

    pdf.table(invoice_header_data, :position => invoice_header_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(0), :border_color => 'dddddd', :font_style => :bold, :text_color => '1C6DD0', :size => 30, :align => :right) # Increase the font size to 30 and align to the right
      style(column(1), :align => :right)
    end

    pdf.move_cursor_to pdf.bounds.height

    # pdf.text_box logopath, :width => 215, :position => :right
    pdf.move_cursor_to last_measured_y
    pdf.move_down 10

    invoice_header_data = [
      ["Invoice #", "Date"],
      [invoice_number, invoice_date],
    ]

    pdf.table(invoice_header_data, :position => invoice_header_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(0), :background_color => '1C6DD0', :border_color => 'dddddd', :font_style => :bold, :text_color => 'ffffff')
      style(column(1), :align => :right)
      style(row(0..1).columns(0..1), :align => :center) # Center the second row horizontally
    end

    pdf.move_down lineheight_y
    pdf.text_box "Bank", at: [address_x, pdf.cursor]
    pdf.text_box bank_name, at: [bank_details1_x, pdf.cursor]
    pdf.text_box "IBAN", at: [bank_details2_x_title, pdf.cursor]
    pdf.text_box bank_iban, at: [bank_details2_x, pdf.cursor]
    pdf.move_down 20
    pdf.text_box "BIC :  #{bank_bic}", at: [bank_details1_x, pdf.cursor]
    pdf.text_box "ACCT Nr.", at: [bank_details2_x_title, pdf.cursor]
    pdf.text_box bank_account_number, at: [bank_details2_x, pdf.cursor]
    pdf.move_down 45
    last_measured_y = pdf.cursor

    invoice_header_data = [
      ["Bill To"],
    ]

    pdf.table(invoice_header_data, :position => address_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(0), :background_color => '1C6DD0', :border_color => 'dddddd', :font_style => :bold, :text_color => 'ffffff')
      style(column(1), :align => :right)
      style(row(0..1).columns(0..1), :align => :left)
    end

    description_style = { size: 10 }
    pdf.move_down 5
    pdf.text_box client_name, at: [address_x, pdf.cursor], **description_style
    pdf.move_down lineheight_y
    pdf.text_box client_contact_name, at: [address_x, pdf.cursor], **description_style
    pdf.move_down lineheight_y
    pdf.text_box client_address, at: [address_x, pdf.cursor], **description_style
    pdf.move_down lineheight_y
    pdf.text_box client_city, at: [address_x, pdf.cursor], **description_style

    pdf.move_cursor_to last_measured_y

    invoice_header_data = [
      ["Customer ID", "TERMS"],
      [customer_id, customer_terms],
    ]

      pdf.table(invoice_header_data, :position => invoice_header_x, :width => 215) do
      style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(row(0), :background_color => '1C6DD0', :border_color => 'dddddd', :font_style => :bold, :text_color => 'ffffff')
      style(column(1), :align => :right)
      style(row(0..1).columns(0..1), :align => :center) # Center the second row horizontally
    end

    pdf.move_down 85

    invoice_services_data = [
      ["Description", "Days", "Daily rate", "Amount"],
      [bill_description, bill_days, bill_rate, bill_amount]
    ]

    # Add 10 empty rows
    12.times { invoice_services_data << ["", "", "", ""] }

    pdf.table(invoice_services_data, :width => pdf.bounds.width) do
      style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
      style(row(0), :background_color => '1C6DD0', :border_color => 'dddddd', :font_style => :bold, :text_color => 'ffffff') # Set text_color to white
      style(row(0).columns(0..-1), :borders => [:top, :bottom])
      style(row(0).columns(0), :borders => [:top, :left, :bottom])
      style(row(0).columns(-1), :borders => [:top, :right, :bottom])
      style(row(-1), :border_width => 2)
      style(column(2..-1), :align => :right)
      style(columns(0), :width => 275)
      style(columns(1), :width => 75)

      # Calculate the height of a single row based on the content in the first row
      single_row_height = row(1).height

      # Apply the same height to all rows (including empty ones)
      (1..12).each do |i|
        style(row(i), :height => single_row_height)
      end
    end

    pdf.move_down 10
    pdf.text_box "Thank you for your business!", at: [address_x, pdf.cursor]
    pdf.move_up 10
    invoice_services_totals_data = [
      ["Subtotal", bill_amount],
      ["Tax rate", "0.000%"],
      ["Tax", "-"],
      ["Total", bill_amount]
    ]

    pdf.table(invoice_services_totals_data, :position => invoice_header_x, :width => 215) do
      style(row(0..3).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
      style(column(0), :background_color => 'C2D9FF', :border_color => 'dddddd', )
      style(column(1), :background_color => 'E0F4FF', :border_color => 'dddddd', :align => :right)
      style(column(1), :align => :right)
      style(row(3), font_style: :bold)
    end

    pdf.move_down 35

    pdf.text_box contact_text, at: [contact_text_start_position, pdf.cursor]
    pdf.move_down lineheight_y
    pdf.text_box contact_details, at: [contact_details_start_position, pdf.cursor]
    end
  end


  def bill_params
    params.require(:bill).permit(:user_id, :client_id, :bill_date, :amount, :description, :days_worked, :rate, :status)
  end
end
