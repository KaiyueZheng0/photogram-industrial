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
# app/models/user.rb

class User < ApplicationRecord
  # Devise
  mount_uploader :avatar_image, ImageUploader
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Photos
  has_many :own_photos, class_name: "Photo", foreign_key: "owner_id", dependent: :destroy

  # Comments
  has_many :comments, class_name: "Comment", foreign_key: "author_id", dependent: :destroy

  # Likes
  has_many :likes, class_name: "Like", foreign_key: "fan_id", dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo

  # Follow requests (sent and received)
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy

  # Accepted relationships
  has_many :accepted_sent_follow_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: "sender_id"
  has_many :accepted_received_follow_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: "recipient_id"

  # Followers and leaders
  has_many :followers, through: :accepted_received_follow_requests, source: :sender
  has_many :leaders, through: :accepted_sent_follow_requests, source: :recipient

  # Feed and Discover
  has_many :feed, through: :leaders, source: :own_photos
  has_many :discover, through: :leaders, source: :liked_photos
end
