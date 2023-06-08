require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }
  let(:user4) { FactoryBot.create(:user) }
  let(:user5) { FactoryBot.create(:user) }
  let!(:friendship) { Friendship.create(user: user1, friend: user2) }
  let!(:friendship2) { Friendship.create(user: user1, friend: user3) }
  let!(:friendship3) { Friendship.create(user: user4, friend: user1) }
  let!(:post1) { FactoryBot.create(:post, author: user1) }
  let(:comment1) { FactoryBot.create(:comment, author: user1) }
  let(:like1) { FactoryBot.create(:like, likeable: post1, user: user1) }



  context 'when User associations called' do
    it 'returns 4 record' do
      expect(User.count).to eq(4)
    end

    it 'includes user records' do
      expect(User.all).to include(user1)
      expect(User.all).to include(user2)
      expect(User.all).to include(user3)
      expect(User.all).to include(user4)
    end

    it 'returns user1 record' do
      expect(User.first).to eq(user1)
    end

    it 'includes post1' do
      expect(user1.posts).to include(post1)
    end

    it 'includes comment1' do
      expect(user1.comments).to include(comment1)
    end

    it 'includes like1' do
      expect(user1.likes).to include(like1)
    end

    it 'includes user2' do
      expect(user1.friends).to include(user2)
      expect(user1.friends).to include(user3)
    end
  end


  context 'when firstname, lastname, email, and password is provided' do
    it 'is valid' do
      user = User.new(
        first_name: 'user',
        last_name: 'userlast',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to be_valid
    end
  end

  context 'when firstname is nil' do
    it 'is not valid' do
      user = User.new(
        first_name: nil,
        last_name: 'userlast',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when lastname is nil' do
    it 'is not valid' do
      user = User.new(
        first_name: 'user',
        last_name: nil,
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when email is nil' do
    it 'is not valid' do
      user = User.new(
        first_name: 'user',
        last_name: 'userlast',
        email: nil,
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when password is nil' do
    it 'is not valid' do
      user = User.new(
        first_name: 'user',
        last_name: 'userlast',
        email: 'test@test.com',
        password: nil
      )
      expect(user).to_not be_valid
    end
  end

  context 'when email format is incorrect' do
    it 'is not valid' do
      user = User.new(
        first_name: 'user',
        last_name: 'userlast',
        email: 'test@',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when email already exists in database' do
    it 'is not valid' do
      user1 = User.create(
        first_name: 'user',
        last_name: 'userlast',
        email: 'test@test.com',
        password: 'password'
      )
      user2 = User.new(
        first_name: 'user',
        last_name: 'userlast',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user2).to_not be_valid
    end
  end

  context 'when firstname is too short' do
    it 'is not valid' do
      user = User.new(
        first_name: 'u',
        last_name: 'userlast',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when lastname is too short' do
    it 'is not valid' do
      user = User.new(
        first_name: 'user',
        last_name: 'u',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when firstname is too long' do
    it 'is not valid' do
      user = User.new(
        first_name: 'thisusernamethatistoolong',
        last_name: 'user',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when lastname is too long' do
    it 'is not valid' do
      user = User.new(
        last_name: 'thisusernamethatistoolong',
        first_name: 'user',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when #friend_list called' do
      it 'returns list of confirmed friends' do
        friendship.confirm_friend
        friends = user1.friend_list

        expect(friends).to include(user2)
      end

      it "doesn't include unconfirmed friends" do
        friendship.confirm_friend
        friends = user1.friend_list

        expect(friends).to_not include(user3)
      end
    end

  context 'when #unconfirmed_friends_list is called' do
    it 'returns list of unconfirmed friends' do
      unconfirmed = user1.unconfirmed_friends_list

      expect(unconfirmed).to include(user2)
      expect(unconfirmed).to include(user4)
    end
  end

  context 'when user has pending friend requests' do
    it 'returns true' do
      expect(user1.friend_requests?).to be(true)
    end
  end

  context 'when user has no pending friend requests' do
    it 'returns false' do
      expect(user5.friend_requests?).to be(false)
    end
  end

  context 'when a user is destroyed' do
    it 'destroys all records where user is a friend' do
      friendship.confirm_friend

      expect(Friendship.where(friend: user1)).to exist
      user1.destroy

      expect(Friendship.where(friend: user1)).to_not exist
    end
  end

end
