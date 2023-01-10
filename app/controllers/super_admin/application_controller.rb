class SuperAdmin::ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :authorize_super_admin
    layout "application"

    def authorize_super_admin
        redirect_to new_user_session_path, notice: "you are not allowed to access it" unless current_user.super_admin?
    end
end