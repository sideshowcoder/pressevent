ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"

if ENV.keys.grep(/ZEUS/).any?
  MiniTest::Unit.class_variable_set("@@installed_at_exit", true)
end

load "#{Rails.root}/test/fixtures/seeds.rb"

class ActiveSupport::TestCase
  fixtures :all
end

