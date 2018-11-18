class TasksController < ApplicationController
  #從Task Model 撈出所有任務資料存入變數提供給index view用
  def index 
    #搜尋任務標題或狀態時進行處理
    @tasks = Task.all
    @tasks = @tasks.where("title LIKE ?", "%#{sort_params[:title]}%") if sort_params[:title].present?
    @tasks = @tasks.where(state: sort_params[:search_state]) if sort_params[:search_state].present?
    @tasks = sorting_by(@tasks, :priority)
    @tasks = sorting_by(@tasks, :state)
    @tasks = @tasks.page(params[:page])
  end

  #在新增的頁面提供 @task 給 form 使用
  def new
    @task = Task.new
  end

  #實際創建的處理
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: I18n.t("task.add_success") 
    else
      #新增失敗時借用 new 的頁面，不會讓使用者輸入的資料消失
      render :new , notice: I18n.t("task.add_fail") 
    end
  end

  def show 
    @task = Task.find_by(id: params[:id])
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      @task.save 
      redirect_to tasks_path, notice: I18n.t("task.update_success") 
    else
      render :edit, notice: I18n.t("task.update_fail") 
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
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
    params.require(:task).permit(:title, :description, :priority, :state, :deadline)
  end

  def sort_params
    params.permit(:id, :state, :title, :priority ,:created_at, :deadline, :search, :search_state)
  end
end
