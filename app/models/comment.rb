class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, length: { in: 1..500 }


  def self.show_comments(post)
    Comment.where(post: post)
  end
end
