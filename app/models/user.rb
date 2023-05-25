class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :posts, foreign_key: 'author_id', class_name: 'Post'
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
end
