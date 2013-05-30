require "test_helper"

feature "UserFlow Feature Test" do
  scenario "user sign up" do
    register_user
    page.must_have_content 'You have signed up successfully.'
  end

  scenario "user sign in" do
    sign_in_user
    page.must_have_content 'Signed in successfully.'
  end

  scenario "user log out" do
    sign_in_user
    sign_out_user
    page.must_have_content 'Signed out successfully.'
  end
end

def sign_out_user
  click_on 'Log out'
end

def register_user
  visit new_user_registration_path
  fill_out_and_submit_registration_form
end

def fill_out_and_submit_registration_form
  within '#new_user' do
    fill_in :user_email, with: 'me@example.com'
    fill_in :user_password, with: 'a_great_password'
    fill_in :user_password_confirmation, with: 'a_great_password'
    click_on 'Sign up'
  end
end
