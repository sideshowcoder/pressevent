require "test_helper"

feature "WordpressInstanceFlow Feature Test" do
  scenario "user adds a new instance" do
    # TODO make sure the user is authenticated
    create_new_wordpress_instance
    page.must_have_content "Added new Wordpress installation."
  end
end

def create_new_wordpress_instance
  # TODO fill out the form
  # TODO submit
  visit new_wordpress_instance_path
end
