class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_tasks = @user.tasks.page(params[:page]).per(5)
    @favorite_tasks = @user.favorite_tasks.page(params[:page]).per(5)
  end
end
