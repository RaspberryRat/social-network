Rails.application.routes.draw do
  devise_for :users

  get 'users/index'
  root 'users#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:show] do
    resources :friendships, only: [:index, :update]
  end
end
