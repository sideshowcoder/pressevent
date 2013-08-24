def create_new_wp_installation(options = {})
  visit new_wp_installation_path
  fill_out_and_submit_register_wordpress_form(options)
  WPInstallation.last
end

def create_new_invalid_wp_installation(options = {})
  visit new_wp_installation_path
  options.merge!(api_key: "invalid_key")
  fill_out_and_submit_register_wordpress_form(options)
  WPInstallation.last
end

def fill_out_and_submit_register_wordpress_form(options = {})
  key = options.fetch(:api_key, 'U3sMgZPcClgFkvR486dIQZ6cDynhHYlk')
  autocheck = options.fetch(:autocheck, false)

  within '#new_wp_installation' do
    fill_in :wp_installation_name, with: 'WPDev'
    fill_in :wp_installation_url, with: 'http://wp-test.dev'
    fill_in :wp_installation_api_key, with: key
    check :wp_installation_auto_checking if autocheck
    click_on 'Register'
  end
end
