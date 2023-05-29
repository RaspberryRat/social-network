require 'rails_helper'

RSpec.describe User, type: :model do
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
end
