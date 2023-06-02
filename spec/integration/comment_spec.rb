require 'rails_helper'

RSpec.describe 'Using Comments', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
  end
  scenario 'new comment' do
    visit user_path(user.id)
    fill_in 'post_content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)

    fill_in 'comment_content', with: 'I know what you are thinking!'
    find('#comment_content').send_keys(:enter)


    expect(page).to have_content("This is what's on my mind!")
    expect(page).to have_content('I know what you are thinking!')
  end

  scenario 'edit comment' do
    visit user_path(user.id)
    fill_in 'post_content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)
    fill_in 'comment_content', with: 'I know what you are thinking!'
    find('#comment_content').send_keys(:enter)


    click_on 'Edit Comment'
    comment = user.comments.last
    comment_box = find("#comment_#{comment.id} #comment_content", match: :first)
    comment_box.set('Changed what I was thinking')
    click_on 'Update Comment'

    expect(page).to have_content('Changed what I was thinking')
  end

  scenario 'delete comment' do
    visit user_path(user.id)
    fill_in 'post_content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)
    fill_in 'comment_content', with: 'I know what you are thinking!'
    find('#comment_content').send_keys(:enter)

    expect(page).to have_content('I know what you are thinking!')

    click_on 'Delete Comment'
    expect(page).to have_content("This is what's on my mind!")
    expect(page).to_not have_content('I know what you are thinking!')
  end

  scenario 'like comment' do
    visit user_path(user.id)
    fill_in 'post_content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)
    fill_in 'comment_content', with: 'I know what you are thinking!'
    find('#comment_content').send_keys(:enter)

    click_on 'Like'
    expect(page).to have_content("Nobody likes this")
    expect(page).to have_content("#{user.fullname} likes this")
    click_on 'Like'
    expect(page).to have_content("#{user.fullname} likes this")
    expect(page).to_not have_content("Nobody likes this")
  end

  scenario 'unlike comment' do
    visit user_path(user.id)
    fill_in 'post_content', with: "This is what's on my mind!"
    find('#post_content').send_keys(:enter)
    fill_in 'comment_content', with: 'I know what you are thinking!'
    find('#comment_content').send_keys(:enter)

    post_like_btn = find("#likes input[name='commit']", match: :first)
    post_like_btn.click
    expect(page).to have_content("#{user.fullname} likes this")
    expect(page).to have_content("Nobody likes this")

    comment = user.comments.last
    comment_like_btn = find("#comment_#{comment.id} input[name='commit']", match: :first)
    comment_like_btn.click
    expect(page).to have_content("#{user.fullname} likes this")
    expect(page).to_not have_content("Nobody likes this")

    post_unlike_btn = find("#likes .unlike-btn", match: :first)
    post_unlike_btn.click
    expect(page).to have_content("Nobody likes this")
    expect(page).to have_content("#{user.fullname} likes this")

    comment = user.comments.last
    comment_unlike_btn = find("#comment_#{comment.id} .unlike-btn", match: :first)
    comment_unlike_btn.click
    expect(page).to have_content("Nobody likes this")
    expect(page).to_not have_content("#{user.fullname} likes this")
  end
end
