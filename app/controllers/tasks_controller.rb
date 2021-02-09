class TasksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @task = @user.tasks.order(id: "DESC").page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_completions_path(params[:id])
    else
      render :edit
    end
  end

  private
  def task_params
    params.require(:task).permit(:name, :goal).merge(user_id: current_user.id)
  end
end
