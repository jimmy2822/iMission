class Admin::UsersController < Admin::BaseController
  def index 
    @users = User.all.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: I18n.t("user.new_success")
    else
      render :new, notice: I18n.t("user.new_fail") 
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: I18n.t("user.update_success")
    else
      render :edit , notice: I18n.t("user.update_fail")
    end
  end

  def destroy
    redirect_to admin_users_path, notice: I18n.t("user.delete_success") if User.find(params[:id]).destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
