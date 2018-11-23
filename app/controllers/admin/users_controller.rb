class Admin::UsersController < Admin::BaseController
  def index 
    @users = User.all.page(params[:page])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, flash[:notice] = "新增使用者成功"
    else
      render :new, flash[:notice].now = "新增使用者失敗"
    end
  end

  private

  def user_params
    require(:user).permit(:email, :password, :role)
  end
end
