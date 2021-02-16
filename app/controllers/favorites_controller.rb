class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(task_id: params[:task_id])
    favorite.save
    redirect_to task_completions_path(params[:task_id])
  end

  def destroy
    favorite = Favorite.find_by(task_id: params[:task_id], user_id: current_user.id)
    favorite.destroy
    redirect_to task_completions_path(params[:task_id])
  end
end
