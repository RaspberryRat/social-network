require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:post1) { FactoryBot.create(:post) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:like1) { FactoryBot.create(:like, likeable: post1, user: user1) }


  context 'when Like associations called' do
    it 'returns 1 record' do
      # test fails unless like1 is assigned here
      like = like1

      expect(Like.count).to eq(1)
    end

    it 'includes like record' do
      expect(Like.all).to include(like1)
    end

    it 'returns like record' do
      like = like1

      expect(Like.first).to eq(like1)
    end

    it 'returns user1' do
      expect(like1.user).to eq(user1)
    end

    it 'returns post1' do
      expect(like1.likeable).to eq(post1)
    end
  end

  context 'when post is already liked' do
    it 'returns true' do
      # test fails unless like1 is assigned here
      likes = like1

      expect(Like.duplicate?(post1, user1)).to be(true)
    end
  end

  context 'when post is not already liked' do
    it 'returns false' do
      like = like1

      expect(Like.duplicate?(post1, user2)).to be(false)
    end
  end

  context 'when post is liked by a different user' do
    it 'returns false' do
      FactoryBot.create(:like, likeable: post1, user: user2)

      expect(Like.duplicate?(post1, user1)).to be(false)
    end
  end

  context 'when post is liked by a different user, and current user' do
    it 'returns false' do
      like = like1
      FactoryBot.create(:like, likeable: post1, user: user2)

      expect(Like.duplicate?(post1, user1)).to be(true)
    end
  end
end
