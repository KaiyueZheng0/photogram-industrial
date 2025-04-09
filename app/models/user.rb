# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_image           :string
#  bio                    :string
#  comments_count         :integer          default(0)
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer          default(0)
#  name                   :string
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :citext
#  website                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Devise Configuration
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :own_photos, class_name: "Photo", foreign_key: "owner_id"
  has_many :comments, class_name: "Comment", foreign_key: "author_id"
  has_many :likes, class_name: "Like", foreign_key: "fan_id"
  has_many :liked_photos, through: :likes, source: :photo

  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id"
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id"

  has_many :accepted_sent_follow_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: "sender_id"
  has_many :accepted_received_follow_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: "recipient_id"

  has_many :leaders, through: :accepted_sent_follow_requests, source: :recipient
  has_many :followers, through: :accepted_received_follow_requests, source: :sender

  has_many :feed, through: :leaders, source: :own_photos
  has_many :discover, through: :leaders, source: :liked_photos

  mount_uploader :avatar_image, ImageUploader

  # Validations
  validates :username, 
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    length: { minimum: 3, maximum: 30 }

  # Instance Methods
  def feed
    Photo.where(owner_id: following_ids + [id])
         .includes(:owner, :comments, :likes)
         .order(created_at: :desc)
  end

  def discover
    Photo.where.not(owner_id: following_ids + [id])
         .order(created_at: :desc)
         .limit(50)
  end

  # Returns the URL for the user's avatar
  def avatar_url
    if avatar_image.present?
      avatar_image.url # CarrierWave's method to get the URL
    else
      # Use the asset pipeline helper with the correct path
      ActionController::Base.helpers.asset_path("default-avatar.png", type: :image)
    end
  end

  # Helper method to check if user has an avatar
  def has_avatar?
    avatar_image.present?
  end
end
