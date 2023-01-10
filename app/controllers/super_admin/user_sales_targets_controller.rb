class SuperAdmin::UserSalesTargetsController < SuperAdmin::ApplicationController
  before_action :set_user_sales_target, only: %i[ show edit update destroy ]

  # GET /user_sales_targets or /user_sales_targets.json
  def index
    @user_sales_targets = UserSalesTarget.paginate(:page => params[:page], per_page: 8)
  end

  # GET /user_sales_targets/1 or /user_sales_targets/1.json
  def show
  end

  # GET /user_sales_targets/new
  def new
    @user_sales_target = UserSalesTarget.new
  end

  # GET /user_sales_targets/1/edit
  def edit
  end

  # POST /user_sales_targets or /user_sales_targets.json
  def create
    @user_sales_target = UserSalesTarget.new(user_sales_target_params)


    respond_to do |format|
      if @user_sales_target.save
        TargetMailer.user_target(@user_sales_target).deliver_now
        format.html { redirect_to user_sales_target_url(@user_sales_target), notice: "User sales target was successfully created." }
        format.json { render :show, status: :created, location: @user_sales_target }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_sales_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_sales_targets/1 or /user_sales_targets/1.json
  def update
    respond_to do |format|
      if @user_sales_target.update(user_sales_target_params)
        format.html { redirect_to user_sales_target_url(@user_sales_target), notice: "User sales target was successfully updated." }
        format.json { render :show, status: :ok, location: @user_sales_target }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_sales_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sales_targets/1 or /user_sales_targets/1.json
  def destroy
    @user_sales_target.destroy

    respond_to do |format|
      format.html { redirect_to user_sales_targets_url, notice: "User sales target was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_sales_target
      @user_sales_target = UserSalesTarget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_sales_target_params
      params.require(:user_sales_target).permit(:user_id, :target)
    end
end
