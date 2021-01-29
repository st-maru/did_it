class CompletionsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @completions = @category.completions.order(id: "DESC").page(params[:page]).per(5)
  end

  def new
    @task = Task.find(params[:task_id])
    @category = Category.find(params[:category_id])
    @thank = Thank.where(user_id: current_user.id)
    @completion = Completion.new
  end

  def create
    @completion = Completion.new(completion_params)
    binding.pry
    if @completion.save
      redirect_to task_category_completions_path(params[:task_id], params[:category_id])
    else
      @task = Task.find(params[:task_id])
      @category = Category.find(params[:category_id])
      render :new
    end
  end

  private
  def completion_params
    params.require(:completion).permit(:summary, :memo, :working_day, :start_time, :ending_time, :thank_ids).merge(user_id: current_user.id, category_id: params[:category_id])
  end
end
