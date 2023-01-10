class CompanySalesTargetsController < ApplicationController
  before_action :set_company_sales_target, only: %i[ show edit update destroy ]

  # GET /company_sales_targets or /company_sales_targets.json
  def index
    @company_sales_targets = CompanySalesTarget.paginate(:page => params[:page], per_page: 8)
  end

  # GET /company_sales_targets/1 or /company_sales_targets/1.json
  def show
  end

  # GET /company_sales_targets/new
  def new
    @company_sales_target = CompanySalesTarget.new
  end

  # GET /company_sales_targets/1/edit
  def edit
  end

  # POST /company_sales_targets or /company_sales_targets.json
  def create
    @company_sales_target = CompanySalesTarget.new(company_sales_target_params)

    respond_to do |format|
      if @company_sales_target.save
        format.html { redirect_to company_sales_targets_url, notice: "Company sales target was successfully created." }
        format.json { render :show, status: :created, location: @company_sales_target }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company_sales_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_sales_targets/1 or /company_sales_targets/1.json
  def update
    respond_to do |format|
      if @company_sales_target.update(company_sales_target_params)
        format.html { redirect_to company_sales_target_url(@company_sales_target), notice: "Company sales target was successfully updated." }
        format.json { render :show, status: :ok, location: @company_sales_target }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company_sales_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_sales_targets/1 or /company_sales_targets/1.json
  def destroy
    @company_sales_target.destroy

    respond_to do |format|
      format.html { redirect_to company_sales_targets_url, notice: "Company sales target was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_sales_target
      @company_sales_target = CompanySalesTarget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_sales_target_params
      params.require(:company_sales_target).permit(:company_id, :target)
    end
end
