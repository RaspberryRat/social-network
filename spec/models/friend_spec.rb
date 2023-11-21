require 'rails_helper'

RSpec.describe Friend, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:friendship) { Friendship.create(user: user1, friend: user2) }

  context "when a friendship is deleted" do
    it 'jd' do

      friendship.confirm_friend
        user_friend_record = Friendship.find_by(
          user_id: user1, friend_id: user2
          )
        mutual_friend_record = Friendship.find_by(
          user_id: user2, friend_id: user1
          )

        expect(user_friend_record.confirmed?).to be(true)
        expect(mutual_friend_record.confirmed?).to be(true)

        Friend.friendship_over
        user_friend_record = Friendship.find_by(
          user_id: user1, friend_id: user2
          )
        mutual_friend_record = Friendship.find_by(
          user_id: user2, friend_id: user1
          )

        expect(user_friend_record).to be(nil)
        expect(mutual_friend_record).to be(nil)
    end
  end
end
