# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params[:username])
  end

  def liked
    @user = User.find_by!(username: params[:username])
    @photos = @user.liked_photos
    render "show"
  end

  def feed
    @user = current_user
    @photos = @user.feed
    render "show"
  end

  def discover
    @user = current_user
    @photos = @user.discover
    render "show"
  end
end
