class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  validates :first_name, presence: true, length: { in: 3..20 }
  validates :last_name, presence: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one_attached :profile_picture
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
    return false if pending_incoming_requests_list.empty?

    true
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = omni_firstname(auth.info.name)
      user.last_name = omni_lastname(auth.info.name)
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.omni_firstname(name)
    name.split(' ')[0]
  end

  def self.omni_lastname(name)
    name.split(' ')[1]
  end

  private

  def destroy_friendships
    Friendship.where(friend: self).destroy_all
  end

  def unconfirmed_friends_list
    friends_id = pending_outgoing_requests_list
    users_id = pending_incoming_requests_list
    unconfirmed_ids = friends_id + users_id

    User.where(id: unconfirmed_ids)
  end

  def pending_outgoing_requests_list
    Friendship.where(user: self).where(confirmed?: false)
  end

  def pending_incoming_requests_list
    Friendship.where(friend: self).where(confirmed?: false)
  end
end
