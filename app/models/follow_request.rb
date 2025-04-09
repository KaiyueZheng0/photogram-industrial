# == Schema Information
#
# Table name: follow_requests
#
#  id           :bigint           not null, primary key
#  status       :string           default("pending"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :bigint           not null
#  sender_id    :bigint           not null
#
# Indexes
#
#  index_follow_requests_on_recipient_id                (recipient_id)
#  index_follow_requests_on_sender_id                   (sender_id)
#  index_follow_requests_on_sender_id_and_recipient_id  (sender_id,recipient_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recipient_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: "User", required: true
  belongs_to :recipient, class_name: "User", required: true

  validate :cannot_follow_self

  def cannot_follow_self
  errors.add(:base, "Cannot follow yourself") if sender_id == recipient_id
  end
end
