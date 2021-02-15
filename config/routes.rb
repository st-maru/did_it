Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'tops/index'
  root to: "tops#index"
  resources :users, only: :show
  resources :lists, only: :index
  resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :completions, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
