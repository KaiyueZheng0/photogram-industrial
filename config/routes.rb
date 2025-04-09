Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for user authentication
  devise_for :users

  # Photos resource routes
  resources :photos do
    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
  end

  # Follow requests
  resources :follow_requests, only: [:create, :destroy, :update]

  # User-specific routes
  get ":username" => "users#show", as: :user
  get ":username/feed" => "users#feed", as: :feed
  get ":username/discover" => "users#discover", as: :discover

  # Root path
  root "photos#index"
end
