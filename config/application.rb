require_relative 'boot'

require 'rails/all'

# Pick the frameworks you want:
# require 'active_model/railtie'
# require 'active_job/railtie'
# require 'active_record/railtie'
# require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_view/railtie'
# require 'action_cable/engine'
# # require "sprockets/railtie"
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Kontaktliste
  # Define all application default settings
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec, fixtures: true, view_specs: false, helper_specs: false, routing_specs: true, controller_specs: true, request_specs: true
      g.stylesheets false
      g.javascripts false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.time_zone = 'Brasilia'
    config.i18n.locale = 'en'
    I18n.default_locale = 'en'

    config.autoload_paths += %w(lib/ldap)
    config.autoload_paths += %w(app/services)

    config.active_job.queue_adapter = :shoryuken
    config.active_job.queue_name_prefix = Rails.env

    config.middleware.insert_before 0, 'Rack::Cors', logger: (-> { Rails.logger }) do
      allow do
        # origins 'localhost:3000'
        origins '*'

        resource '*',
                 headers: :any,
                 methods: [:get, :post, :delete, :put, :patch, :options, :head],
                 max_age: 0
      end
    end
  end
end
