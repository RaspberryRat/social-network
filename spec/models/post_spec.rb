require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post1) {FactoryBot.create(:post) }
  let(:user1) {FactoryBot.create(:user) }
  let(:user2) {FactoryBot.create(:user) }
  let(:user3) {FactoryBot.create(:user) }
  let(:user4) {FactoryBot.create(:user) }



  context 'when show posts is called' do

    let!(:post) { FactoryBot.create(:post, author: user1, content: 'test')}

    it 'returns authors post' do
      expect(Post.show_posts(user1)).to include(post)
    end
  end

  context 'when a post has 0 likes' do
    it 'returns "Nobody likes this" ' do
      display = post1.display_likes
      expect(display).to eq('Nobody likes this')
    end
  end

  context 'when a post has 1 likes' do

    it 'returns "{name of user} likes this" ' do
      FactoryBot.create(:like, post: post1, user: user1)

      display = post1.display_likes
      expect(display).to eq("#{user1.username} likes this")
    end
  end

  context 'when a post has 2 likes' do

    it 'returns "{name of user1} and {name of user2}  like this" ' do
      FactoryBot.create(:like, post: post1, user: user1)
      FactoryBot.create(:like, post: post1, user: user2)


      display = post1.display_likes
      expect(display).to eq("#{user1.username} and #{user2.username} like this")
    end
  end

  context 'when a post has 3 likes' do

    it 'returns "{name of user1}, {name of user 2}, and {name of user3} like this" ' do
      FactoryBot.create(:like, post: post1, user: user1)
      FactoryBot.create(:like, post: post1, user: user2)
      FactoryBot.create(:like, post: post1, user: user3)

      display = post1.display_likes
      expect(display).to eq("#{user1.username}, #{user2.username}, and #{user3.username} like this")
    end
  end

  context 'when a post more than 3 likes' do

    it 'returns "{name of user} and 3 others like this" ' do
      FactoryBot.create(:like, post: post1, user: user1)
      FactoryBot.create(:like, post: post1, user: user2)
      FactoryBot.create(:like, post: post1, user: user3)
      FactoryBot.create(:like, post: post1, user: user4)

      return_values = [
                        "#{user1.username} and 3 others like this",
                        "#{user2.username} and 3 others like this",
                        "#{user3.username} and 3 others like this",
                        "#{user4.username} and 3 others like this"
                      ]
      display = post1.display_likes
      expect(return_values).to include(display)
    end
  end
end
