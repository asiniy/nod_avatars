require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env)
Bundler.require(:console) if CONSOLE_IS_LOADED rescue nil

module NodAvatars
  class Application < Rails::Application
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
  end
end
