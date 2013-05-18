require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(:default, Rails.env)

module Pressevent
  class Application < Rails::Application
    config.generators do |g|
      # Don't create fixtures by default and use the minitest spec syntax
      g.test_framework :mini_test, :spec => true, :fixture => false
    end

    config.assets.initialize_on_precompile = false
  end
end
