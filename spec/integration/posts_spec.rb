require 'rails_helper'

RSpec.describe 'Using Posts', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
  end

  scenario 'new post' do
    visit user_path(user.id)
    fill_in 'Post Content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)

    expect(page).to have_content("This is what's on my mind!")
  end

  scenario 'edit post' do
    visit user_path(user.id)
    fill_in 'Post Content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)

    click_on 'Edit Post'
    second_post_content = find('#posts #post_content', match: :first)
    second_post_content.set('Changed my mind')
    click_on 'Update Post'
    expect(page).to have_content('Changed my mind')
  end

  scenario 'delete post' do
    visit user_path(user.id)
    fill_in 'Post Content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)

    expect(page).to have_content("This is what's on my mind!")

    click_on 'Delete Post'
    expect(page).to_not have_content("This is what's on my mind!")
  end
end
