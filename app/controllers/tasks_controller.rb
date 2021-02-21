class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, except: [:index, :new, :create]

  def index
    @user = User.find(current_user.id)
    @task = @user.tasks.order(id: 'DESC').page(params[:page]).per(10)
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

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :goal).merge(user_id: current_user.id)
  end

  def move_to_index
    task = Task.find(params[:id])
    redirect_to task_completions_path(task.id) unless current_user.id == task.user.id
  end
end
