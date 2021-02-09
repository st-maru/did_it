class CompletionsController < ApplicationController
  def index
    @task = Task.find(params[:task_id])
    @completions = @task.completions.order(working_day: "DESC").order(start_time: "ASC").page(params[:page]).per(5)
  end

  def new
    @task = Task.find(params[:task_id])
    @completion_tag_thank = CompletionTagThank.new
  end

  def create
    @completion_tag_thank = CompletionTagThank.new(completion_params)
    tag_list = params[:completion][:name].split(",")
    thank_list = params[:completion][:human].split(",")
    if @completion_tag_thank.valid?
      @completion_tag_thank.save(tag_list, thank_list)
      redirect_to task_completions_path(params[:task_id])
    else
      @task = Task.find(params[:task_id])
      render :new
    end
  end

  def edit
    @task = Task.find(params[:task_id])
    @completion = Completion.find(params[:id])
    @completion_tag_thank = CompletionTagThank.new(completion: @completion)
  end

  def update
    @completion = Completion.find(params[:id])
    @completion_tag_thank = CompletionTagThank.new(completion_params, completion: @completion)
    tag_list = params[:completion][:name].split(",")
    thank_list = params[:completion][:human].split(",")
     if @completion_tag_thank.valid?
       @completion_tag_thank.save(tag_list, thank_list)
       redirect_to task_completions_path(params[:task_id])
     else
       @task = Task.find(params[:task_id])
       render :edit
     end
   end

  private
  def completion_params
    params.require(:completion).permit(:summary, :memo, :working_day, :start_time, :ending_time, :name, :human).merge(user_id: current_user.id, task_id: params[:task_id])
  end
end
