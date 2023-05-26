class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.duplicate?(post, user)
    like = Like.where(user_id: user)
        .where(post_id: post)

    return true unless like.empty?

    false
  end
end
