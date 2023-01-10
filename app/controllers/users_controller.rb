class UsersController < ApplicationController
    before_action :authenticate_user!

    before_action :set_user, only: %i[ edit update destroy show]

    def index    
        company = load_company    
        @users = company.employees.paginate(:page => params[:page], per_page: 8)
        
    end

    def new 
        @user = User.new
    end

    def create
        company = load_company        
        @user = company.employees.create(user_params)

        respond_to do |format|
            if @user.save
              format.html { redirect_to users_url, notice: "User sales  was successfully created." }
              format.json { render :show, status: :created, location: users_url }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
    end

    def edit

    end

    def show
        company = load_company
        @target_achieved = current_user.invoices.group_by_month(:created_at).where(status: "paid", company_id: company.id).sum(:price_cents)
        @refuned_invoice = @user.invoices.group_by_month(:created_at).where(status: "refunded").sum(:price_cents)

    end

    def update
        if @user.update(user_params)
            redirect_to users_path notice: "User was successfully updated."
        end
    end

    def destroy
        if @user.destroy
            redirect_to users_path notice: "User was successfully destroyed."
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
       params.require(:user).permit(:email, :password, :name, :role, :department)
    end

    # def set_company_params
    #    params.require(:company).permit(:name)
    # end

    # def find_company
    #     Company.find(set_company_params[:name])
    # end

end
