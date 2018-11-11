class TasksController < ApplicationController
  #從Task Model 撈出所有任務資料存入變數提供給index view用
  def index 
    @tasks = Task.all
  end

  #在新增的頁面提供 @task 給 form 使用
  def new
    @task = Task.new
  end

  #實際創建的處理
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "新增成功"
    else
      #新增失敗時借用 new 的頁面，不會讓使用者輸入的資料消失
      render :new , notice: "創建失敗"
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
      redirect_to tasks_path, notice: "更新任務成功"
    else
      render :edit, notice: "更新失敗"
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy if @task
    redirect_to tasks_path, notice: "刪除任務成功"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :priority, :state, :deadline)
  end
end
