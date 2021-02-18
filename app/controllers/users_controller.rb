class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorite_tasks = @user.favorite_tasks.page(params[:page]).per(5)
  end
end
