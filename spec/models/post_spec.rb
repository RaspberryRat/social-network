require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post1) {FactoryBot.create(:post) }
  let(:user1) {FactoryBot.create(:user) }
  let(:user2) {FactoryBot.create(:user) }
  let(:user3) {FactoryBot.create(:user) }
  let(:user4) {FactoryBot.create(:user) }
  let!(:post2) {FactoryBot.create(:post, author: user1, content: 'test') }

  context 'when Post associations called' do
    it 'returns 2 record' do
      expect(Post.count).to eq(2)
    end

    it 'includes post record' do
      expect(Post.all).to include(post1)
      expect(Post.all).to include(post2)

    end

    it 'returns post record' do
      expect(Post.first).to eq(post1)
    end

    it 'returns user1' do
      expect(post2.author).to eq(user1)
    end

    it 'returns post1' do
      post_message = 'test'
      expect(post2.content).to eq(post_message)
    end
  end

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
      FactoryBot.create(:like, likeable: post1, user: user1)

      display = post1.display_likes
      expect(display).to eq("#{user1.fullname} likes this")
    end
  end

  context 'when a post has 2 likes' do

    it 'returns "{name of user1} and {name of user2}  like this" ' do
      FactoryBot.create(:like, likeable: post1, user: user1)
      FactoryBot.create(:like, likeable: post1, user: user2)

      display = post1.display_likes
      expect(display).to eq("#{user1.fullname} and #{user2.fullname} like this")
    end
  end

  context 'when a post has 3 likes' do

    it 'returns "{name of user1}, {name of user 2}, and {name of user3} like this" ' do
      FactoryBot.create(:like, likeable: post1, user: user1)
      FactoryBot.create(:like, likeable: post1, user: user2)
      FactoryBot.create(:like, likeable: post1, user: user3)

      display = post1.display_likes
      expect(display).to eq("#{user1.fullname}, #{user2.fullname}, and #{user3.fullname} like this")
    end
  end

  context 'when a post more than 3 likes' do

    it 'returns "{name of user} and 3 others like this" ' do
      FactoryBot.create(:like, likeable: post1, user: user1)
      FactoryBot.create(:like, likeable: post1, user: user2)
      FactoryBot.create(:like, likeable: post1, user: user3)
      FactoryBot.create(:like, likeable: post1, user: user4)

      return_values = [
                        "#{user1.fullname} and 3 others like this",
                        "#{user2.fullname} and 3 others like this",
                        "#{user3.fullname} and 3 others like this",
                        "#{user4.fullname} and 3 others like this"
                      ]
      display = post1.display_likes
      expect(return_values).to include(display)
    end
  end

  context 'when a post is correct' do
    it 'is valid' do
      post = Post.new(content: 'Test', author: user1)

      expect(post).to be_valid
    end
  end

  context 'when a post is missing author' do
    it 'is not valid' do
      post = Post.new(content: 'Test', author: nil)

      expect(post).to_not be_valid
    end
  end

  context 'when a post is missing content' do
    it 'is not valid' do
      post = Post.new(content: nil, author: user1)

      expect(post).to_not be_valid
    end
  end

  context 'when a content of post is 0 characters' do
    it 'is not valid' do
      post = Post.new(content: '', author: user1)

      expect(post).to_not be_valid
    end
  end

  context 'when a content of post is over 500 characters' do
    it 'is not valid' do

      too_long_content = 'gxyuyncbsjotlvyojxueymgrilijplnvpldzsqjdiqdrimgdvtoeawgguamevpclboazzsrxptdywksdzfwfjeuuzklweqzzwkzaxkhymrdonhpavrxrgwazkyhnplqvhalvjbselqgvkqwrycjfhfieabjanopaljhujdqghzejntmraxkkyapjswbnudflftffvzckwgdoltbxpofeaxgrsqolhxqakehloxdlgtlqvqzbghjqfuzeeqkvdcunaufzkxjpsifqjwogioxyevupzpjjronxbcicwzuiyqqroawkrrtokscqbbpfxczwvvmtfqagjjxzpghkszvxnnhtefiunadnqtblyitmlljoqeffyugtzowiizhlmfmqyianrrzopbajxydmxyuzlbtwwbrjhjnvvhfpenkbhweomswnbucmnzjhhhtytidresisyyjuunnibvuqerxeztzfmpejefqgqahtvebpvyhpiuuiiyqkj'

      post = Post.new(content: too_long_content, author: user1)

      expect(post).to_not be_valid
    end
  end

  # been superseded by stimuls controller
  # context 'when formatted date is used' do
  #   it 'returns current date and time' do
  #     month = Date::MONTHNAMES[Time.now.utc.month]
  #     day = Time.now.utc.day
  #     hour = Time.now.utc.hour
  #     meridian = hour > 12 ? 'PM' : 'AM'
  #     hour = hour - 12 if hour > 12
  #     minute = Time.now.utc.min


  #     readable_date = post1.formatted_date
  #     expect(readable_date).to eq("#{month} #{day} at #{hour}:#{minute} #{meridian}")
  #   end
  # end
end
