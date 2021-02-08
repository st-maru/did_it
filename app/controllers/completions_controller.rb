class CompletionsController < ApplicationController
  def index
    @task = Task.find(params[:task_id])
    @completions = @task.completions.order(working_day: "DESC").order(start_time: "ASC").page(params[:page]).per(5)
  end

  def new
    @task = Task.find(params[:task_id])
    @completion = CompletionTagThank.new
  end

  def create
    @completion = CompletionTagThank.new(completion_params)
    if @completion.valid?
      @completion.save
      redirect_to task_completions_path(params[:task_id])
    else
      @task = Task.find(params[:task_id])
      render :new
    end
  end

  private
  def completion_params
    params.require(:completion_tag_thank).permit(:summary, :memo, :working_day, :start_time, :ending_time, :name, :human).merge(user_id: current_user.id, task_id: params[:task_id])
  end
end
