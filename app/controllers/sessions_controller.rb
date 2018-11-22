class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_path, notice: I18n.t("login.error")
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t("logout.success")
  end
end
