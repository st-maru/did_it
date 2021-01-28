Rails.application.routes.draw do
  devise_for :users
  get 'tops/index'
  root to: "tops#index"
  resources :users, only: :show
  resources :tasks, only: [:show, :new, :create] do
    resources :categories, only: [:index, :new, :create] do
      resources :completions, only: :index
    end
  end
end
