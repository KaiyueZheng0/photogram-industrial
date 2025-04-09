class UsersController < ApplicationController
  before_action :set_user_by_username

  def show
  end

  def feed
    @feed_photos = @user.feed.order(created_at: :desc)
  end

  def discover
    @discover_photos = @user.discover.order(created_at: :desc)
  end

  private

  def set_user_by_username
    @user = User.find_by!(username: params[:username])
  end
end
