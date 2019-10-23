# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MiditoneServer
  class Application < Rails::Application
    # API mode
    config.api_only = true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.paths.add 'lib', eager_load: true
    config.paths.add 'config/routes/concerns', eager_load: true

    config.paths['config/routes.rb'].concat Dir['config/routes/**/*.rb']

    config.generators do |g|
      g.test_framework = 'rspec'
      g.helper_specs = false
      g.view_specs = false
      g.model_specs = false
      g.integration_spec = false
      g.factory_bot = false
    end

    # Timezone
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end
