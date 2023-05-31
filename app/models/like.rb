class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true


  def self.duplicate?(likeable, user)
    like = Like.where(user_id: user)
        .where(likeable_id: likeable)

    return true unless like.empty?

    false
  end
end
