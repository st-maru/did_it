Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  get 'tops/index'
  root to: "tops#index"
  resources :users, only: :show
    resources :lists, only: :index do
     collection do
     get 'search'
  end
  end
  resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :completions, only: [:index, :new, :create, :edit, :update, :destroy] do
    end
  end
end
