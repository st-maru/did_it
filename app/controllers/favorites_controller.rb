class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.find(params[:task_id])
    favorite = current_user.favorites.build(task_id: params[:task_id])
    favorite.save
  end

  def destroy
    @task = Task.find(params[:task_id])
    favorite = Favorite.find_by(task_id: params[:task_id], user_id: current_user.id)
    favorite.destroy
  end
end
