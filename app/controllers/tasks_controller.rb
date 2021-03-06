class TasksController < ApplicationController
  before_action :find_task_id, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  #從Task Model 撈出所有任務資料存入變數提供給index view用
  def index 
    #搜尋任務標題或狀態時進行處理
    @tasks = current_user.tasks.all
    @tasks = @tasks.where("title LIKE ?", "%#{sort_params[:title]}%") if sort_params[:title].present?
    @tasks = @tasks.tagged_with(sort_params[:title]) if sort_params[:title].present? && @tasks.tagged_with(sort_params[:title]).present?
    @tasks = @tasks.where(state: sort_params[:search_state]) if sort_params[:search_state].present?
    @tasks = sorting_by(@tasks, :priority)
    @tasks = sorting_by(@tasks, :state)
    @tasks = sorting_by(@tasks, :deadline)
    @tasks = sorting_by(@tasks, :created_at)
    @tasks = @tasks.page(params[:page])
  end

  #在新增的頁面提供 @task 給 form 使用
  def new
    @task = Task.new
  end

  #實際創建的處理
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user[:id]

    if @task.save
      redirect_to tasks_path, notice: I18n.t("task.add_success") 
    else
      #新增失敗時借用 new 的頁面，不會讓使用者輸入的資料消失
      render :new , notice: I18n.t("task.add_fail") 
    end
  end

  def show 
  end

  def edit
  end

  def update
    if @task.update(task_params)
      @task.save 
      redirect_to tasks_path, notice: I18n.t("task.update_success") 
    else
      render :edit, notice: I18n.t("task.update_fail") 
    end
  end

  def destroy
    @task.destroy if @task
    redirect_to tasks_path, notice: I18n.t("task.delete_success")
  end

  private
  
  def sorting_by(tasks, column)
    return tasks if sort_params[column].blank?
    case sort_params[column].to_s
    when 'asc' then tasks.order(column => 'asc') # { 'priority' => 'asc' }, { priority: 'asc' }
    when 'desc' then tasks.order(column => 'desc')
    else tasks
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :state, :deadline, :tag_list)
  end

  def sort_params
    params.permit(:id, :state, :title, :priority ,:created_at, :deadline, :search, :search_state)
  end

  def find_task_id
    @task = Task.find_by(id: params[:id])
  end
end
