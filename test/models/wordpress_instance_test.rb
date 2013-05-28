require "test_helper"

describe WordpressInstance do
  before do
    user = User.find_for_authentication(email: 'nobody@example.com')
    @attributes = { name: 'name', url: 'http://example.com',
      api_key: 'an_api_key', user: user, auto_checking: true }
    @wordpress_instance = WordpressInstance.new(@attributes)
  end

  it "allows name, url, api_key, user, and auto_checking" do
    WordpressInstance.new(@attributes).valid?.must_equal true
  end

  it "must have an url" do
    @wordpress_instance.url = nil
    @wordpress_instance.valid?.must_equal false
  end

  it "must have an user" do
    @wordpress_instance.user = nil
    @wordpress_instance.valid?.must_equal false
  end

  it "must have an api_key" do
    @wordpress_instance.api_key = nil
    @wordpress_instance.valid?.must_equal false
  end
end
