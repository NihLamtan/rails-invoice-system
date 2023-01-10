class ApplicationController < ActionController::Base
  add_flash_types :info, :danger, :warning, :notice
  helper_method :load_company
  

  

    before_action :configure_permitted_parameters, if: :devise_controller?
    after_action do |controller|
      if controller.controller_name == "sessions" && controller.action_name == "create"
        set_company_identification_after_login
      end
    end

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to root_path, danger: "this action is not allowed, contact admin for authorization" }
      end
    end
    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :department, :role])
  end

  def after_sign_in_path_for(resrouce)
    if current_user.super_admin?
      super_admin_dashboard_path
    else
      dashboard_index_path
    end
  end

  private
  def set_company_identification_after_login
    unless current_user.super_admin?
      unless cookies.signed[:company_id]
        cookies.signed[:company_id] = current_user.companies.first.id
      end
    end
  end

  def load_company
    @company = Company.find(cookies.signed[:company_id]) || current_user.companies.first
  end
   
end
