class TasksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @task = @user.tasks.order(id: "DESC").page(params[:page]).per(5)
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

  private
  def task_params
    params.require(:task).permit(:name, :goal).merge(user_id: current_user.id)
  end
end
