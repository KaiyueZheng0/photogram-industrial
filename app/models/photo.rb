# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer          default(0)
#  image          :string
#  likes_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :bigint           not null
#
# Indexes
#
#  index_photos_on_created_at  (created_at)
#  index_photos_on_owner_id    (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Photo < ApplicationRecord
  # Associations
  belongs_to :owner, class_name: "User", required: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :fans, through: :likes, source: :fan

  # Method to get the full URL of the photo
  def image_url
    "/photos/#{image}" # Constructs the path to the image stored in public/photos
  end

  # Example validation to ensure an image filename is provided
  validates :image, presence: true
end
