class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :friend_id, uniqueness: { scope: :user_id }
  validate :not_own_friend


  def not_own_friend
    if user_id == friend_id
      errors.add(:friend, "can't be your own friend")
    end
  end
end

