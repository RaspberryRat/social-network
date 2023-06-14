class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  include Likeable

  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :content, length: { in: 1..500 }, presence: true

  after_create_commit do
    # can broadcast_append_later_to to make a background job
    broadcast_append_to [commentable, :comments], target: "#{dom_id(parent || commentable)}_comments", partial: "comments/comment_with_replies"
  end

  after_update_commit do
    broadcast_replace_to self
  end

  after_destroy_commit do
    broadcast_remove_to self
    broadcast_action_to self, action: :remove, target: "#{dom_id(self)}_with_comments"
  end

  def self.show_comments(post)
    Comment.where(post: post)
  end
end
