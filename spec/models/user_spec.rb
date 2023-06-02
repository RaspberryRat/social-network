require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }
  let(:user4) { FactoryBot.create(:user) }
  let!(:friendship) { Friendship.create(user: user1, friend: user2) }
  let!(:friendship2) { Friendship.create(user: user1, friend: user3) }
  let!(:friendship3) { Friendship.create(user: user4, friend: user1) }



  context 'when username, email, and password is provided' do
    it 'is valid' do
      user = User.new(
        username: 'user',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to be_valid
    end
  end

  context 'when username is nil' do
    it 'is not valid' do
      user = User.new(
        username: nil,
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when email is nil' do
    it 'is not valid' do
      user = User.new(
        username: 'user',
        email: nil,
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when password is nil' do
    it 'is not valid' do
      user = User.new(
        username: 'user',
        email: 'test@test.com',
        password: nil
      )
      expect(user).to_not be_valid
    end
  end

  context 'when email format is incorrect' do
    it 'is not valid' do
      user = User.new(
        username: 'user',
        email: 'test@',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when user already exisits' do
    it 'is not valid' do
      user1 = User.create(
        username: 'user',
        email: 'test@test.com',
        password: 'password'
      )
      user2 = User.new(
        username: 'user',
        email: 'test@newtest.com',
        password: 'password'
      )
      expect(user2).to_not be_valid
    end
  end

  context 'when email already exisits in database' do
    it 'is not valid' do
      user1 = User.create(
        username: 'user1',
        email: 'test@test.com',
        password: 'password'
      )
      user2 = User.new(
        username: 'user2',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user2).to_not be_valid
    end
  end

  context 'when username is too short' do
    it 'is not valid' do
      user = User.new(
        username: 'us',
        email: 'test@test.com',
        password: 'password'
      )
      expect(user).to_not be_valid
    end
  end

  context 'when username is too short' do
    it 'is not valid' do
      user = User.new(
        username: 'thisusernamethatistoolong',
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

  context 'when a user is destroyed' do
    it 'destroys all records where user is a friend' do
      friendship.confirm_friend

      expect(Friendship.where(friend: user1)).to exist
      user1.destroy

      expect(Friendship.where(friend: user1)).to_not exist
    end
  end

end
