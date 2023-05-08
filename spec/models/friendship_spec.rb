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


end
