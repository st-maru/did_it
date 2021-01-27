Rails.application.routes.draw do
  devise_for :users
  get 'tops/index'
  root to: "tops#index"
end
