ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"
require 'mocha/setup'
require 'vcr'

Dir["#{Rails.root}/test/support/*.rb"].each {|file| require file }

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class Capybara::Rails::TestCase
  before do
    Capybara.reset_sessions!
  end
end

