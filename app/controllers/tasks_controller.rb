class TasksController < ApplicationController
  def show
    @user = User.find(params[:id])
    @task = @user.tasks.order(id: "DESC").page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(current_user.id)
    else
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:name, :goal).merge(user_id: current_user.id)
  end
end
