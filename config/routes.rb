Rails.application.routes.draw do
  devise_for :users

  resources :photos
  resources :comments
  resources :likes
  resources :follow_requests

  # Custom user routes
  get "/:username", to: "users#show", as: :user_profile
  get "/:username/feed", to: "users#feed", as: :user_feed
  get "/:username/discover", to: "users#discover", as: :user_discover

  # Devise root handling
  devise_scope :user do
    authenticated :user do
      root to: redirect { |_, req|
        user = req.env['warden'].user
        user.present? ? "/#{user.username}/feed" : "/users/sign_in"
      }, as: :authenticated_root
    end

    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end
