require "test_helper"

feature "WPInstanllationFlow Feature Test" do
  before do
    sign_in_user
  end

  scenario "add a new installation" do
    create_new_wp_installation
    page.must_have_content "Registered new Wordpress installation."
  end

  scenario "view an installation" do
    create_new_wp_installation
    visit wp_installations_path
    @wp_installation = WPInstallation.last
    page.must_have_content @wp_installation.name
    page.must_have_content @wp_installation.url
  end

  scenario "edit installation" do
    create_new_wp_installation
    change_wordpress_installation_name_to WPInstallation.last, 'changed_name'
    page.must_have_content "Updated Wordpress installation."
    page.must_have_content 'changed_name'
  end

  scenario "delete installation" do
    create_new_wp_installation
    delete_wordpress_installation(WPInstallation.last)
    page.must_have_content "Unregistered Wordpress installation."
    page.wont_have_content 'Test'
  end
end

def change_wordpress_installation_name_to(wp_installation, name)
  visit edit_wp_installation_path(wp_installation)
  within "#edit_wp_installation_#{wp_installation.id}" do
    fill_in :wp_installation_name, with: name
    click_on 'Update'
  end
end

def delete_wordpress_installation(wp_installation)
  visit wp_installations_path
  within "#wp_installation_#{wp_installation.id}" do
    click_on 'Unregister'
  end
end

