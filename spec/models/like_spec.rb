require 'rails_helper'

RSpec.describe Like, type: :model do


  let(:post1) {FactoryBot.create(:post) }
  let(:user1) {FactoryBot.create(:user) }
  let(:user2) {FactoryBot.create(:user) }

  context 'when post is already liked' do
    it 'returns true' do
      like = FactoryBot.create(:like, post: post1, user: user1)

      expect(Like.duplicate?(post1, user1)).to be(true)
    end
  end

  context 'when post is not already liked' do
    it 'returns false' do
      expect(Like.duplicate?(post1, user1)).to be(false)
    end
  end

  context 'when post is liked by a different user' do
    it 'returns false' do
      like = FactoryBot.create(:like, post: post1, user: user2)

      expect(Like.duplicate?(post1, user1)).to be(false)
    end
  end

  context 'when post is liked by a different user, and current user' do
    it 'returns false' do
      like1 = FactoryBot.create(:like, post: post1, user: user1)
      like2 = FactoryBot.create(:like, post: post1, user: user2)


      expect(Like.duplicate?(post1, user1)).to be(true)
    end
  end
end
