require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when no username is provided' do
    it 'is not valid' do
      user = User.new(username: nil)
      expect(user).to_not be_valid
    end
  end
end
