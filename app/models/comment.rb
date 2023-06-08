class Comment < ApplicationRecord
  include Likeable

  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :content, length: { in: 1..500 }

  def self.show_comments(post)
    Comment.where(post: post)
  end
end
