class UsersController < ApplicationController
  def feed
    # Use the current_user if no :username is provided
    @user = params[:username].present? ? User.find_by!(username: params[:username]) : current_user

    # Fetch photos for the user's feed
    @feed_photos = Photo.where(owner: @user) # Adjust query logic as needed
  end

  def liked
    @user = User.find_by!(username: params.fetch(:username))
  end

  def discover
    @user = User.find_by!(username: params.fetch(:username))
  end
end
