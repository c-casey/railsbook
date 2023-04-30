Rails.application.routes.draw do
  root "posts#index"

  devise_for :users
  resources :users, only: [:show, :index]

  concern :likeable do
    resources :likes, only: [:create, :destroy]
  end

  resources :posts, concerns: :likeable, shallow: true do
    resources :comments, concerns: :likeable
  end

  resources :notifications, only: [:index]

  resources :friendships, only: [:index, :create, :update, :destroy]
end
