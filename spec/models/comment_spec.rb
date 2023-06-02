require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post1) { FactoryBot.create(:post) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) {FactoryBot.create(:user) }
  let(:user3) {FactoryBot.create(:user) }
  let(:user4) {FactoryBot.create(:user) }
  let(:comment1) { FactoryBot.create(:comment) }
  let(:comment2) { FactoryBot.create(:comment) }


  context 'when Comment associations called' do
    it 'returns comment1' do
      expect(Comment.all).to include(comment1)
      expect(Comment.first).to eq(comment1)
    end
    it 'returns 2' do
      # have to assign comments to variables or test doesn't pass
      c = comment1
      c2 = comment2
      expect(Comment.count).to be(2)
    end
  end
  context 'when comment is valid' do
    it 'is valid' do
      comment = Comment.new(
        author: user1, post: post1, content: 'Test'
      )

      expect(comment).to be_valid
    end
  end

  context 'when comment is missing' do
    it 'is not valid' do
      comment = Comment.new(
        author: user1, post: post1, content: nil
      )

      expect(comment).to_not be_valid
    end
  end

  context 'when post is missing' do
    it 'is not valid' do
      comment = Comment.new(
        author: user1, post: nil, content: 'test'
      )

      expect(comment).to_not be_valid
    end
  end

  context 'when author is missing' do
    it 'is not valid' do
      comment = Comment.new(
        author: nil, post: post1, content: 'test'
      )

      expect(comment).to_not be_valid
    end
  end

  context 'when comment is 0 characters' do
    it 'is not valid' do
      comment = Comment.new(
        author: user1, post: post1, content: ''
      )

      expect(comment).to_not be_valid
    end
  end

  context 'when comment is over 500 characters' do
    it 'is not valid' do
      too_long_content = 'gxyuyncbsjotlvyojxueymgrilijplnvpldzsqjdiqdrimgdvtoeawgguamevpclboazzsrxptdywksdzfwfjeuuzklweqzzwkzaxkhymrdonhpavrxrgwazkyhnplqvhalvjbselqgvkqwrycjfhfieabjanopaljhujdqghzejntmraxkkyapjswbnudflftffvzckwgdoltbxpofeaxgrsqolhxqakehloxdlgtlqvqzbghjqfuzeeqkvdcunaufzkxjpsifqjwogioxyevupzpjjronxbcicwzuiyqqroawkrrtokscqbbpfxczwvvmtfqagjjxzpghkszvxnnhtefiunadnqtblyitmlljoqeffyugtzowiizhlmfmqyianrrzopbajxydmxyuzlbtwwbrjhjnvvhfpenkbhweomswnbucmnzjhhhtytidresisyyjuunnibvuqerxeztzfmpejefqgqahtvebpvyhpiuuiiyqkj'
      comment = Comment.new(
        author: user1, post: post1, content: too_long_content
      )

      expect(comment).to_not be_valid
    end
  end

  context 'when a comment has 0 likes' do
    it 'returns "Nobody likes this" ' do
      display = comment1.display_likes
      expect(display).to eq('Nobody likes this')
    end
  end

  context 'when a comment has 1 likes' do

    it 'returns "{name of user} likes this" ' do
      FactoryBot.create(:like, likeable: comment1, user: user1)

      display = comment1.display_likes
      expect(display).to eq("#{user1.fullname} likes this")
    end
  end

  context 'when a comment has 2 likes' do

    it 'returns "{name of user1} and {name of user2}  like this" ' do
      FactoryBot.create(:like, likeable: comment1, user: user1)
      FactoryBot.create(:like, likeable: comment1, user: user2)


      display = comment1.display_likes
      expect(display).to eq("#{user1.fullname} and #{user2.fullname} like this")
    end
  end

  context 'when a comment has 3 likes' do

    it 'returns "{name of user1}, {name of user 2}, and {name of user3} like this" ' do
      FactoryBot.create(:like, likeable: comment1, user: user1)
      FactoryBot.create(:like, likeable: comment1, user: user2)
      FactoryBot.create(:like, likeable: comment1, user: user3)

      display = comment1.display_likes
      expect(display).to eq("#{user1.fullname}, #{user2.fullname}, and #{user3.fullname} like this")
    end
  end

  context 'when a comment more than 3 likes' do

    it 'returns "{name of user} and 3 others like this" ' do
      FactoryBot.create(:like, likeable: comment1, user: user1)
      FactoryBot.create(:like, likeable: comment1, user: user2)
      FactoryBot.create(:like, likeable: comment1, user: user3)
      FactoryBot.create(:like, likeable: comment1, user: user4)

      return_values = [
                        "#{user1.fullname} and 3 others like this",
                        "#{user2.fullname} and 3 others like this",
                        "#{user3.fullname} and 3 others like this",
                        "#{user4.fullname} and 3 others like this"
                      ]
      display = comment1.display_likes
      expect(return_values).to include(display)
    end
  end
end
