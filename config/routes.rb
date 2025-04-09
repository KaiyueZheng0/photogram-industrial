Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "users#feed"

  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  resources :users, only: [:index]

  get ":username" => "users#show", as: :user
  get ":username/liked" => "users#liked", as: :liked
  get ":username/feed" => "users#feed", as: :feed
  get ":username/discover" => "users#discover", as: :discover
end
