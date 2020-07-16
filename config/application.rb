require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module PortalSolarDevTest
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = :"pt-BR"
    config.i18n.available_locales = %w(pt-BR)
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  end
end
