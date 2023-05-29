require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post1) { FactoryBot.create(:post) }
  let(:user1) { FactoryBot.create(:user) }

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
end
