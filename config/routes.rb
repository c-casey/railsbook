Rails.application.routes.draw do
  devise_for :users

  root "posts#index"

  resources :posts, shallow: true do
    resources :comments
    resources :likes
  end
end
