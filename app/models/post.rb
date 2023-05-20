class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, presence: true, length: { in: 1..75 }
  validates :content, length: { in: 0..500 }

  def self.show_posts(user)
    Post.where(author: user)
  end
end
