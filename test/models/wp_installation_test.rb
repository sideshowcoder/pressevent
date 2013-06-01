require "test_helper"

describe WPInstallation do
  before do
    user = users(:john_doe)
    @attributes = { name: 'name', url: 'http://example.com',
      api_key: 'an_api_key', user: user, auto_checking: true }
    @wp_installation = WPInstallation.new(@attributes)
  end

  it "allows name, url, api_key, user, and auto_checking" do
    WPInstallation.new(@attributes).valid?.must_equal true
  end

  it "must have an url" do
    @wp_installation.url = nil
    @wp_installation.valid?.must_equal false
  end

  it "must have an user" do
    @wp_installation.user = nil
    @wp_installation.valid?.must_equal false
  end

  it "must have an api_key" do
    @wp_installation.api_key = nil
    @wp_installation.valid?.must_equal false
  end
end
