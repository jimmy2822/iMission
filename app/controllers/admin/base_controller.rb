class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check

  private
  
  def admin_check
    render file: "#{Rails.root}/public/404.html", :status => 404 if current_user.admin? == false
  end 
end
