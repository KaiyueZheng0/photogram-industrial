Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Devise routes for users
  devise_for :users

  # Photos resource routes
  resources :photos

  # Root path
  root "photos#index"
end
