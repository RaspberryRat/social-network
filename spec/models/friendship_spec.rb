  require 'rails_helper'

  RSpec.describe Friendship, type: :model do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let!(:friendship) { Friendship.create(user: user1, friend: user2) }

    #TODO Need to rethink this test
    # context 'friend request already existis' do

    #   it 'receive error message' do
    #     friendship.confirm_friend
    #     friendship2 = Friendship.new(user: user1, friend: user2)
    #     debugger
    #     friendship2.confirm_friend
    #     expect(friendship2.errors[:friend]).to include('Friend has already been taken')
    #   end
    # end

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

      it 'creates a mutual friend record' do
        friendship.confirm_friend
        mutual_friend = Friendship.find_by(user_id: user2, friend_id: user1)
        expect(Friendship.all.include?(mutual_friend)).to be(true)
      end
    end
  end
