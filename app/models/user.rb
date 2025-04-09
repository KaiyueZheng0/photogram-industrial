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
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Photos
  has_many :own_photos, class_name: "Photo", foreign_key: "owner_id"

  # Comments
  has_many :comments, foreign_key: "author_id", class_name: "Comment"

  # Likes
  has_many :likes, foreign_key: "fan_id", class_name: "Like"
  has_many :liked_photos, through: :likes, source: :photo

  # Follow requests
  has_many :sent_follow_requests, foreign_key: "sender_id", class_name: "FollowRequest"
  has_many :received_follow_requests, foreign_key: "recipient_id", class_name: "FollowRequest"

  has_many :accepted_sent_follow_requests,
           -> { where(status: "accepted") },
           foreign_key: "sender_id",
           class_name: "FollowRequest"

  has_many :accepted_received_follow_requests,
           -> { where(status: "accepted") },
           foreign_key: "recipient_id",
           class_name: "FollowRequest"

  has_many :followers, through: :accepted_received_follow_requests, source: :sender
  has_many :leaders, through: :accepted_sent_follow_requests, source: :recipient

  # Feed and discover
  has_many :feed, through: :leaders, source: :own_photos
  has_many :discover, through: :leaders, source: :liked_photos
end
