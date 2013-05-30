require "test_helper"

feature "WordpressInstanceFlow Feature Test" do
  scenario "user adds a new instance" do
    sign_in_user
    create_new_wordpress_instance
    page.must_have_content "Registered new Wordpress installation."
  end
end

def create_new_wordpress_instance
  visit new_wordpress_instance_path
  fill_out_and_submit_register_wordpress_form
end

def fill_out_and_submit_register_wordpress_form
  within '#new_wordpress_instance' do
    fill_in :wordpress_instance_name, with: 'Test'
    fill_in :wordpress_instance_url, with: 'http://example.com'
    fill_in :wordpress_instance_api_key, with: 'somekey'
    check :wordpress_instance_auto_checking
    click_on 'Register Wordpress Installation'
  end
end
