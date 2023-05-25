require 'rails_helper'

RSpec.describe 'Submitting a friend request', type: :system do
  before do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Username', with: 'fakeman'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    visit root_path
    click_on 'Logout'

    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail2@cool.com'
    fill_in 'Username', with: 'fakeman2'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
  end

  scenario 'send a friend request' do
    visit user_session_path
    fill_in 'Email', with: 'fakeemail2@cool.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'fakeman'
    click_on 'Send Friend Request'
    click_on 'Logout'

    visit user_session_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'fakeman'
    click_on 'See Friend Requests'

    expect(page).to have_content 'Friend Request # 1'
    expect(page).to have_content 'Name: fakeman2'
    expect(page).to have_content 'Email: fakeemail2@cool.com'
    click_on 'Logout'
  end

  # scenario 'acccept a friend request' do
  #   visit user_session_path
  #   fill_in 'Email', with: 'fakeemail2@cool.com'
  #   fill_in 'Password', with: 'password'
  #   click_on 'Log in'
  #   click_on 'fakeman'
  #   click_on 'Send Friend Request'
  #   click_on 'Logout'

  #   visit user_session_path
  #   fill_in 'Email', with: 'fakeemail@cool.com'
  #   fill_in 'Password', with: 'password'
  #   click_on 'Log in'
  #   click_on 'fakeman'
  #   click_on 'See Friend Requests'
  #   click_on 'Confirm Friend Request'

  #   expect(page).to have_content("Friend's name: fakeman2")
  #   expect(page).to have_content("Friend's email: fakeemail2@cool.com")
  #   click_on 'Logout'
  # end

  # scenario 'deny a friend request' do
  #   visit user_session_path
  #   fill_in 'Email', with: 'fakeemail2@cool.com'
  #   fill_in 'Password', with: 'password'
  #   click_on 'Log in'
  #   click_on 'fakeman'
  #   click_on 'Send Friend Request'
  #   click_on 'Logout'

  #   visit user_session_path
  #   fill_in 'Email', with: 'fakeemail@cool.com'
  #   fill_in 'Password', with: 'password'
  #   click_on 'Log in'
  #   click_on 'fakeman'
  #   click_on 'See Friend Requests'
  #   click_on 'Confirm Friend Request'

  #   expect(page).to_not have_content("Friend's name: fakeman2")
  #   expect(page).to_not have_content("Friend's email: fakeemail2@cool.com")
  #   click_on 'Logout'
  # end
end
