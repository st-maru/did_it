Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'tops/index'
  root to: "tops#index"
  resources :users, only: :show
  resources :lists, only: :index
  resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :completions, only: [:index, :new, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
    end
  end
end
