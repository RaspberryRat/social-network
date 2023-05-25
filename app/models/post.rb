class Post < ApplicationRecord
  validates :content, presence: true, length: { in: 0..500 }

  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :liking_users, through: :likes, source: :user

  def self.show_posts(user)
    Post.where(author: user)
  end
end
