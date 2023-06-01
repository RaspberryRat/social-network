  require 'rails_helper'

  RSpec.describe Friendship, type: :model do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:user3) { FactoryBot.create(:user) }
    let!(:friendship) { Friendship.create(user: user1, friend: user2) }
    let!(:friendship2) { Friendship.create(user: user1, friend: user3) }


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

    context "when friendship doesn't exist" do
      it 'is valid' do
        new_user1 = FactoryBot.create(:user)
        new_user2 = FactoryBot.create(:user)
        new_friendship = Friendship.new(
          user_id: new_user1.id, friend_id: new_user2.id
        )

        expect(new_friendship).to be_valid
      end
    end

    context "when friendship already exists" do
      it 'is valid' do
        new_user1 = FactoryBot.create(:user)
        new_user2 = FactoryBot.create(:user)
        new_friendship = Friendship.create(
          user_id: new_user1.id, friend_id: new_user2.id
        )

        new_friendship2 = Friendship.new(
          user_id: new_user1.id, friend_id: new_user2.id
        )

        expect(new_friendship2).to_not be_valid
      end
    end

    context 'when #friend_list called' do
      it 'returns list of confirmed friends' do
        friendship.confirm_friend
        friends = Friendship.friend_list(user1)

        expect(friends).to include(user2)
      end

      it "doesn't include unconfirmed friends" do
        friendship.confirm_friend
        friends = Friendship.friend_list(user1)

        expect(friends).to_not include(user3)
      end
    end
  end
