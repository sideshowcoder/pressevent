ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"

require "launchy"
load "#{Rails.root}/test/test_seeds.rb"

class ActiveSupport::TestCase
  fixtures :all
end

