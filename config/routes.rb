Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'posts#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:show, :create, :index] do
    patch 'update_profile_picture', on: :member
    resources :friendships, only: [:index, :new, :create, :update, :destroy]
    resources :posts, except: [:index] do
      resources :likes, only: [:new, :create, :destroy]
      resources :comments
    end
  end
  resources :comments do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end
  resources :posts, only: [:index]
end
