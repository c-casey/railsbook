Rails.application.routes.draw do
  root "posts#index"

  devise_for :users
  resources :users, only: [:show, :index]

  resources :posts, shallow: true do
    resources :comments
    resources :likes
  end

  resources :notifications, only: [:index]

  resources :friendships, only: [:index, :create, :update, :destroy]
end
