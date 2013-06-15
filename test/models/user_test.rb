require "test_helper"

describe User do
  before do
    @wp_attributes = { url: 'http://example.com', api_key: 'abc' }
  end

  it "returns user who enabled autochecking on a wp installation" do
    doe = users(:john_doe)
    smith = users(:smith)
    WPInstallation.create!(@wp_attributes.merge(user: doe, auto_checking: true))
    WPInstallation.create!(@wp_attributes.merge(user: smith, auto_checking: false))
    User.with_autochecking_installations.must_include doe
    User.with_autochecking_installations.wont_include smith
  end

  it "return wp installations to check" do
    doe = users(:john_doe)
    wp = WPInstallation.create!(@wp_attributes.merge(user: doe, auto_checking: true))
    doe.installations_need_checking.must_include wp
  end
end
