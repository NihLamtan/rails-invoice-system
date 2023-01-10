class ClientsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_client, only: %i[ show edit update destroy ]

  # GET /clients or /clients.json
  def index

    
    company = load_company
    @clients = company.clients.paginate(page: params[:page], per_page: 10)

    # # @clients = Client.all
    # @q = Client.ransack(params[:q])
    # @clientsss = @q.result(distinct: true)
    @items = Client.order('created_at DESC')
    
    respond_to do |format|
      format.html
      format.xlsx
    end

  end
  

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
   
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    company = load_company
    @client = Client.new(client_params)
    @client.company_id = company.id
    stripe_customer = Stripe::Customer.create({
      description: 'My First Test Customer (created for API docs)',
      email: @client.email
    })

    @client.stripe_customer_id = stripe_customer.id

      if @client.save
        flash[:notice] = "Client was successfully create."
        redirect_to clients_path
      end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    authorize! :destroy, @client

    delete_client = @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, danger: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:name, :email, :phone, :currency, :stripe_customer_id)
    end
end
