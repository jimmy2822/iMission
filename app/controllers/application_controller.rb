class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def authenticate_user!
    redirect_to login_path if current_user.blank?
  end

  def current_user
    return if session[:user_id].blank?
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
