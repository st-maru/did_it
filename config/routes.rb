Rails.application.routes.draw do
  devise_for :users
  get 'tops/index'
  root to: "tops#index"
  resources :users, only: :show
  resources :tasks, only: [:index, :new, :create] do
    resources :completions, only: [:index, :new, :create]
  end
end
