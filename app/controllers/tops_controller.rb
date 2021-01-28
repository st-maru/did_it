class TopsController < ApplicationController
  before_action :move_to_tasks

  def index
  end

  private
  def move_to_tasks
    redirect_to task_path(current_user.id) if user_signed_in?
  end
end
