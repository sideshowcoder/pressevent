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

def create_wp_installation_without_updates(options = {})
  visit new_wp_installation_path
  options.merge!(name: "Without Updates",
                 url: "http://localhost:9292",
                 api_key: "ijX9nOdkfdjKvuXzqS3bzqL5jAMYkFwe")
  fill_out_and_submit_register_wordpress_form(options)
  WPInstallation.last
end

def fill_out_and_submit_register_wordpress_form(options = {})
  name = options.fetch(:name, "Wordpress")
  url = options.fetch(:url, "http://localhost:9292")
  key = options.fetch(:api_key, 'ijX9nOdkfdjKvuXzqS3bzqL5jAMYkFwe')
  autocheck = options.fetch(:autocheck, false)

  within '#new_wp_installation' do
    fill_in :wp_installation_name, with: name
    fill_in :wp_installation_url, with: url
    fill_in :wp_installation_api_key, with: key
    check :wp_installation_auto_checking if autocheck
    click_on 'Register'
  end
end
