  require 'rails_helper'

  RSpec.describe Friendship, type: :model do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let!(:friendship) { Friendship.create(user: user1, friend: user2) }


    context 'mutual friend created' do
      it 'creates a mutual friend record' do
        friendship.add_mutual_friend
        mutual_friend = Friendship.find_by(user_id: user2, friend_id: user1)
        expect(Friendship.all.include?(mutual_friend)).to be(true)
      end
    end

    context 'mutual friend not created' do
      it 'receive error message' do
        friendship.add_mutual_friend
        expect(friendship.errors[:friend]).to include('mutual friend already exists')
      end
    end

    context 'when friend confirms friendship' do
      it 'changes confirmed? to true on mutual friend records' do
        friendship.confirm_friend
        user_friend_record = Friendship.find_by(
          user_id: user1, friend_id: user2
          )
        mutual_friend_record = Friendship.find_by(
          user_id: user2, friend_id: user1
          )

        expect(user_friend_record.confirmed?).to be(true)
        expect(mutual_friend_record.confirmed?).to be(true)
      end
    end

    context 'when friend denies friendship' do
      it 'deletes both friendship records' do
        user_friend_record = Friendship.find_by(
          user_id: user1, friend_id: user2
          )
        mutual_friend_record = Friendship.find_by(
          user_id: user2, friend_id: user1
          )

        friendship.deny_friend_request

        expect(Friendship.find_by(id: user_friend_record)).to be(nil)
        expect(Friendship.find_by(id: mutual_friend_record)).to be(nil)
      end
    end
  end
