class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :content, presence: true, length: { in: 0..500 }

  def self.show_posts(user)
    Post.where(author: user)
  end
end
