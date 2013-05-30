ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"

require "#{Rails.root}/test/fixtures/seeds.rb"

Dir["#{Rails.root}/test/support/*.rb"].each {|file| require file }

class ActiveSupport::TestCase
  fixtures :all
end

class Capybara::Rails::TestCase
  before do
    Capybara.reset_sessions!
  end
end

