Rails.application.routes.draw do
  root "posts#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users, only: %i[show index edit update]

  concern :likeable do
    resources :likes, only: %i[create destroy]
  end

  resources :posts, concerns: :likeable, shallow: true do
    resources :comments, concerns: :likeable
  end

  resources :notifications, only: %i[index]

  resources :friendships, only: %i[index create update destroy]
end
