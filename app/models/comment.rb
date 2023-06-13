class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  include Likeable

  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  # has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :content, length: { in: 1..500 }, presence: true

  after_create_commit do
    # can broadcast_append_later_to to make a background job
    broadcast_append_to [commentable, :comments],
      target: "#{dom_id(commentable)}_comments", locals: { user: author }
  end

  after_update_commit do
    broadcast_replace_to self, locals: { user: author }
  end

  after_destroy_commit do
    broadcast_remove_to self
  end

  def self.show_comments(post)
    Comment.where(post: post)
  end
end
