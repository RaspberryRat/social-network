class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true, length: { in: 3..20 }
  validates :last_name, presence: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :posts, foreign_key: 'author_id', class_name: 'Post', dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment', dependent: :destroy

  before_destroy :destroy_friendships


  # returns a list of all Users that are confirmed friends
  def friend_list
    friends_id = Friendship.where(user: self).where(confirmed?: true).pluck(:friend_id)
     User.where(id: friends_id)
  end

  def friend_requests?
    return false if unconfirmed_friends_list.empty?

    true
  end

  def unconfirmed_friends_list
    friends_id = Friendship.where(user: self).where(confirmed?: false).pluck(:friend_id)
    users_id = Friendship.where(friend: self).where(confirmed?: false).pluck(:user_id)
    unconfirmed_ids = friends_id + users_id
    User.where(id: unconfirmed_ids)
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  private

  def destroy_friendships
    Friendship.where(friend: self).destroy_all
  end
end
