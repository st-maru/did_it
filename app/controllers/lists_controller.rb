class ListsController < ApplicationController
  def index
    @task = Task.includes(:user).order(id: "DESC").page(params[:page]).per(10)
  end
end
