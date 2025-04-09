# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :bigint           not null
#  photo_id   :bigint           not null
#
# Indexes
#
#  index_likes_on_fan_id               (fan_id)
#  index_likes_on_fan_id_and_photo_id  (fan_id,photo_id) UNIQUE
#  index_likes_on_photo_id             (photo_id)
#
# Foreign Keys
#
#  fk_rails_...  (fan_id => users.id)
#  fk_rails_...  (photo_id => photos.id)
#
class Like < ApplicationRecord
  belongs_to :fan, class_name: "User", required: true
  belongs_to :photo, required: true
end
