def sign_in_user
  visit new_user_session_path
  fill_out_and_submit_login_form_with_user_credentials
end

def fill_out_and_submit_login_form_with_user_credentials
  within '#new_user' do
    fill_in :user_email, with: 'john@example.com'
    fill_in :user_password, with: 'password'
    click_on 'Sign in'
  end
end

