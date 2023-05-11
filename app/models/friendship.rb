class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_save :add_mutual_friend

  validates :friend_id, uniqueness: { scope: :user_id }
  validate :not_own_friend

  # private

  def not_own_friend
    if user_id == friend_id
      errors.add(:friend, "can't be your own friend")
    end
  end

  def add_mutual_friend
    mutual_friend = Friendship.find_by(user_id: friend_id, friend_id: user_id)

    if mutual_friend.nil?
      Friendship.create(user: friend, friend: user)
    else
      errors.add(:friend, 'mutual friend already exists')
    end
  end

  def confirm_friend
    user_friend_record = Friendship.find_by(
      user_id: user_id, friend_id: friend_id
      )
    mutual_friend_record = Friendship.find_by(
      user_id: friend_id, friend_id: user_id
      )

    Friendship.find(user_friend_record.id).update(confirmed?: true)
    Friendship.find(mutual_friend_record.id).update(confirmed?: true)
  end

  def deny_friend_request
    user_friend_record = Friendship.find_by(
      user_id: user_id, friend_id: friend_id
      )
    mutual_friend_record = Friendship.find_by(
      user_id: friend_id, friend_id: user_id
      )

    Friendship.find(user_friend_record.id).destroy
    Friendship.find(mutual_friend_record.id).destroy
  end

  def self.show_friend_requests(user_id)
    Friendship.where(friend_id: user_id)
              .where(confirmed?: false)
  end
end

