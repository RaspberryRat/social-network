require 'rails_helper'

RSpec.describe TextPost, type: :model do

  context 'when textpost has corret attributes' do
    it 'is valid' do
      textpost = TextPost.new(content: 'hello')
      expect(textpost).to be_valid
    end
  end

  context 'when textpost has 0 characters' do
    it 'is not valid' do
      textpost = TextPost.new(content: '')
      expect(textpost).to_not be_valid
    end
  end

  context 'when a content of post is over 500 characters' do
    it 'is not valid' do

      too_long_content = 'gxyuyncbsjotlvyojxueymgrilijplnvpldzsqjdiqdrimgdvtoeawgguamevpclboazzsrxptdywksdzfwfjeuuzklweqzzwkzaxkhymrdonhpavrxrgwazkyhnplqvhalvjbselqgvkqwrycjfhfieabjanopaljhujdqghzejntmraxkkyapjswbnudflftffvzckwgdoltbxpofeaxgrsqolhxqakehloxdlgtlqvqzbghjqfuzeeqkvdcunaufzkxjpsifqjwogioxyevupzpjjronxbcicwzuiyqqroawkrrtokscqbbpfxczwvvmtfqagjjxzpghkszvxnnhtefiunadnqtblyitmlljoqeffyugtzowiizhlmfmqyianrrzopbajxydmxyuzlbtwwbrjhjnvvhfpenkbhweomswnbucmnzjhhhtytidresisyyjuunnibvuqerxeztzfmpejefqgqahtvebpvyhpiuuiiyqkj'
      textpost = TextPost.new(content: too_long_content)

      expect(textpost).to_not be_valid
    end
  end
end
