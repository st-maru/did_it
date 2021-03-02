class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index, :search]

  def index
    @task = Task.includes(:user).order(id: 'DESC').page(params[:page]).per(10)
  end

  def search
    @results = @q.result.page(params[:page]).per(10)
  end

  private

  def set_q
    @q = Task.ransack(params[:q])
  end
end
