Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise authentication
  devise_for :users

  # Core resources
  resources :photos
  resources :comments
  resources :likes
  resources :follow_requests

  # User custom pages (must come last to avoid conflict)
  get "/:username/feed" => "users#feed", as: :user_feed
  get "/:username/discover" => "users#discover", as: :user_discover
  get "/:username" => "users#show", as: :user_profile

  # Root
  root "photos#index"
end
