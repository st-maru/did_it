class TopsController < ApplicationController
  before_action :move_to_tasks

  def index
  end

  private

  def move_to_tasks
    redirect_to tasks_path if user_signed_in?
  end
end
