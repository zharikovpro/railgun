require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Railgun
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Benefits of explicit DDL in migrations and structure:
    # + don't fight with migration generator that forgets about important stuff like null: false, indexes, checks, etc
    # + can generate DDL using DBA tools like DataGrip / DbSchema / whatever
    # + support advanced PostgreSQL features like deferred constraints, etc
    # + dump complete structure in SQL format for better integration with SQL utilities
    config.active_record.schema_format = :sql

    config.autoload_paths << Rails.root.join('lib')

    config.middleware.use Rack::Attack
  end
end

Rails.application.routes.default_url_options[:host] = ENV.fetch('CANONICAL_HOST', 'localhost:5000')
