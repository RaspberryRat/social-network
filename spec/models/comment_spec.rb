require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post1) {FactoryBot.create(:post) }
  let(:user1) {FactoryBot.create(:user) }
  context 'when comment is valid' do
    it 'is valid' do

    end
  end
end
