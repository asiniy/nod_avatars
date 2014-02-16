require File.expand_path('../boot', __FILE__)
require 'rails/all'

Bundler.require(:default, Rails.env)
Bundler.require(:console) if CONSOLE_IS_LOADED rescue nil

module NodAvatars
  class Application < Rails::Application
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
  end
end
