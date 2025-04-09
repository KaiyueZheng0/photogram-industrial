class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by!(username: params[:username])
  end

  def feed
    @user = User.find_by!(username: params[:username])
    @photos = @user.feed
  end

  def discover
    @user = User.find_by!(username: params[:username])
    @photos = @user.discover
  end
end
