require 'rails_helper'

RSpec.describe 'Creating a user', type: :system do

  scenario 'valid inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Username', with: 'fakeman'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    visit root_path
    expect(page).to have_content('fakeman')
  end

  scenario 'invalid username inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Username', with: 'f'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content('Username is too short')
  end

  scenario 'non-matching password inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Username', with: 'f'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'passwrd'
    click_on 'Sign up'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'invalid password inputs' do
    visit new_user_registration_path
    fill_in 'Email', with: 'fakeemail@cool.com'
    fill_in 'Username', with: 'f'
    fill_in 'Password', with: 'pass'
    fill_in 'Password confirmation', with: 'pass'
    click_on 'Sign up'

    expect(page).to have_content("Password is too short (minimum is 6 characters)")
  end

end
