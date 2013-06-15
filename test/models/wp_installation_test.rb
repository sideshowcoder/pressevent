require "test_helper"

describe WPInstallation do
  before do
    @user = users(:john_doe)
    @attributes = { name: 'name', url: 'http://example.com',
      api_key: 'an_api_key', user: @user, auto_checking: true }
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

  describe "instances by autochecking" do
    before do
      @attributes = { url: 'http://example.com', api_key: 'an_api_key', user: @user }
    end

    it "returns instances with enabled autochecking" do
      wp = WPInstallation.create!(@attributes.merge(auto_checking: true))
      WPInstallation.with_autochecking.must_include wp
    end

    it "does not return instances with disabled autochecking" do
      wp = WPInstallation.create!(@attributes.merge(auto_checking: false))
      WPInstallation.with_autochecking.wont_include wp
    end
  end
end
