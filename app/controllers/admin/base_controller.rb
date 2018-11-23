class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check

  private
  
  def admin_check
    redirect_to tasks_path if current_user.role_check_admin? == false
  end 
end
