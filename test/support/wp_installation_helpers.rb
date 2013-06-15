def create_new_wp_installation_with_automatic_check
  visit new_wp_installation_path
  fill_out_and_submit_register_wordpress_form(autocheck: true)
  WPInstallation.last
end

def create_new_wp_installation
  visit new_wp_installation_path
  fill_out_and_submit_register_wordpress_form
  WPInstallation.last
end

def fill_out_and_submit_register_wordpress_form(options = {})
  within '#new_wp_installation' do
    fill_in :wp_installation_name, with: 'WPDev'
    fill_in :wp_installation_url, with: 'http://wp-test.dev'
    fill_in :wp_installation_api_key, with: 'U3sMgZPcClgFkvR486dIQZ6cDynhHYlk'
    check :wp_installation_auto_checking if options[:autocheck]
    click_on 'Register'
  end
end
