class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  def after_sign_in_path_for(_resource)
    tasks_path
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  def search
    @results = @q.result.page(params[:page]).per(10)
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image])
  end

  def set_q
    @q = Task.ransack(params[:q])
  end
end
