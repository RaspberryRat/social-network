require 'rails_helper'

RSpec.describe 'Creating a user', type: :system do

  scenario 'valid inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'First name', with: 'fakeman'
    fill_in 'Last name', with: 'fakelast'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    sleep(0.1)

    visit users_path

    expect(page).to have_content('fakeman fakelast')
  end

  scenario 'invalid first name inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'First name', with: 'f'
    fill_in 'Last name', with: 'fakelast'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content('First name is too short')
  end

  scenario 'invalid last name inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'First name', with: 'fakelast'
    fill_in 'Last name', with: 'f'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content('Last name is too short')
  end

  scenario 'non-matching password inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'First name', with: 'fakelast'
    fill_in 'Last name', with: 'f'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'passwrd'
    click_on 'Sign up'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'invalid password inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'First name', with: 'fakelast'
    fill_in 'Last name', with: 'f'
    fill_in 'Password', with: 'pass'
    fill_in 'Password confirmation', with: 'pass'
    click_on 'Sign up'

    expect(page).to have_content('Password is too short (minimum is 6 characters)')
  end
end

RSpec.describe 'Logging in a user', type: :system do
  before do
    destroy_user_session_path
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'First name', with: 'fakeman'
    fill_in 'Last name', with: 'fakelast'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    visit root_path
    click_on 'Logout'
  end

  scenario 'valid inputs' do
    visit user_session_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    expect(page).to have_current_path(root_path)
  end

  scenario 'invalid email inputs' do
    visit user_session_path
    fill_in 'Email', with: 'wrongemail@c.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'invalid email inputs' do
    visit user_session_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Password', with: 'password1'
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
