class Post < ApplicationRecord
  include Likeable

  belongs_to :postable, polymorphic: true
  belongs_to :author, class_name: 'User'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  after_destroy :destroy_associated_post

  def self.show_posts(user)
    Post.where(author: user)
  end

  # changes the created at date of the post to be human readable
  def formatted_date
    created_at.strftime('%B %e at %-l:%M %p')
  end

  def self.reverse_chronological
    order("created_at DESC")
  end

  def remove_associated_post
    postable.destroy
  end
end
