class CompletionsController < ApplicationController
  def index
    @task = Task.find(params[:task_id])
    @completions = @task.completions.order(working_day: "DESC").order(start_time: "ASC").page(params[:page]).per(5)
    tag_count
    thank_count
  end

  def new
    @task = Task.find(params[:task_id])
    @completion_tag_thank = CompletionTagThank.new
  end

  def create
    @completion_tag_thank = CompletionTagThank.new(completion_params)
    if @completion_tag_thank.save
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
     if @completion_tag_thank.save
       redirect_to task_completions_path(params[:task_id])
     else
       @task = Task.find(params[:task_id])
       render :edit
     end
   end

   def destroy
    @completion = Completion.find(params[:id])
    if @completion.destroy
      redirect_to task_completions_path(params[:task_id])
    end
  end

  private
  def completion_params
    params.require(:completion).permit(:summary, :memo, :working_day, :start_time, :ending_time, :name, :human).merge(user_id: current_user.id, task_id: params[:task_id])
  end

  def tag_count
    @tag_count = {}
    @completions.each do |completion|
      completion.tags.each do |tag|
        if @tag_count.value?(tag.name)
          @tag_count[tag.name] = 1
        else
          @tag_count[tag.name] = (@tag_count[tag.name]).to_i + 1
        end
      end
    end
  end

  def thank_count
    @thank_count = {}
    @completions.each do |completion|
      completion.thanks.each do |thank|
        if @thank_count.value?(thank.human)
          @thank_count[thank.human] = 1
        else
          @thank_count[thank.human] = (@thank_count[thank.human]).to_i + 1
        end
      end
    end
  end

end
