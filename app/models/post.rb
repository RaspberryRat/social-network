class Post < ApplicationRecord
  validates :content, presence: true, length: { in: 0..500 }

  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :liking_users, through: :likes, source: :user

  def self.show_posts(user)
    Post.where(author: user)
  end

  def display_likes
    users = self.liking_users

    if users.empty?
      'Nobody likes this'
    elsif users.length == 1
      "#{users[0].username} likes this"
    elsif users.length == 2
      "#{users[0].username} and #{users[1].username} like this"
    elsif users.length == 3
      "#{users[0].username}, #{users[1].username}, and #{users[2].username} like this"
    elsif users.length > 3
      "#{users.sample.username} and #{users.length - 1} others like this"
    else
      puts "ERROR"
    end
  end
end
