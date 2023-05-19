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
end
