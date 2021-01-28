class CategoriesController < ApplicationController
  def index
    @task = Task.find(params[:task_id])
    @categories = @task.categories.order(id: "DESC").page(params[:page]).per(5)
  end

  def new
    @task = Task.find(params[:task_id])
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to task_categories_path(params[:task_id])
    else
      @task = Task.find(params[:task_id])
      render :new
    end
  end

  def category_params
    params.require(:category).permit(:name, :item).merge(user_id: current_user.id, task_id: params[:task_id])
  end
end
