class Post < ApplicationRecord
  validates :content, presence: true, length: { in: 0..500 }

  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  def self.show_posts(user)
    Post.where(author: user)
  end

  def display_likes
    users = self.liking_users

    case users.length
    when 0
      'Nobody likes this'
    when 1
      "#{users[0].username} likes this"
    when 2
      "#{users[0].username} and #{users[1].username} like this"
    when 3
      "#{users[0].username}, #{users[1].username}, and #{users[2].username} like this"
    else
      "#{users.sample.username} and #{users.length - 1} others like this"
    end
  end

  # changes the created at date of the post to be human readable
  def formatted_date
    created_at.strftime('%B %e at %-l:%M %p')
  end
end
