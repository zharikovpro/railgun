source 'https://rubygems.org'

ruby File.read(File.join(File.dirname(__FILE__), '.ruby-version'))[/(\d\.){2}\d/]

# Pretty print Ruby objects
gem 'awesome_print', '~> 1.8.0'

# Load ENV variables from .env file
gem 'dotenv-rails', '~> 2.2.1', require: 'dotenv/rails-now'

# Exceptions monitoring
gem 'rollbar', '~> 2.15.5'

# Guess my country
gem 'russian', '~> 0.6.0'

# Generate security report with brakeman -o brakeman.html
gem 'brakeman', '~> 4.1.1', require: false

# Cron jobs manager
# gem 'whenever', require: false

# Background jobs queue
gem 'sidekiq', '~> 5.0.4'

# Track failed jobs
gem 'sidekiq-failures', '~> 1.0.0'

# Scheduled and recurrent background jobs
# gem 'sidetiq', '~> 0.6.3'

# Expiration time for jobs
# gem 'sidekiq-status', '~> 0.6.0'

# Skip duplicate jobs
# gem 'sidekiq-unique-jobs', '~> 4.0', '>= 4.0.17'

# Rate limit jobs execution
# gem 'sidekiq-throttler', '~> 0.5.1'

# Passenger has the best documentation and support
gem 'passenger', '~> 5.1.12'

# Rails 5 with Action Cable
gem 'rails', '~> 5.1.3'

# Redis for Action Cable, Sidekiq and cache
# gem 'redis', '~> 3.0'

# Compact logs
gem 'lograge', '~> 0.9.0'

# Restore original remote_ip when using CloudFlare
gem 'actionpack-cloudflare', '~> 1.1.0'

# Elastic logs support
# gem 'logstash-event'
# gem 'logstash-logger'

# PostgreSQL for Active Record
gem 'pg', '~> 0.21'

# Validates emails
gem 'email_validator', '~> 1.6.0'

# Validate and normalize phone numbers
gem 'phony_rails', '~> 0.14.6'

# Versioned database views in migrations
# gem 'scenic', '~> 1.3.0'

# When PostgreSQL is not an option
# gem 'mysql2'

# Group temporal data by date
# gem 'groupdate', '~> 2.5.3'

# Group count queries
# gem 'hightop', '~> 0.1.4'

# Authentication engine
gem 'devise', '~> 4.4.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Slim for templates
gem 'slim', '~> 3.0.9'
gem 'slim-rails', '~> 3.1.0'

# Stylus for styles
gem 'stylus', '~> 1.0.1'

# Markdown rendering
gem 'redcarpet', '~> 3.4.0'

# View helpers
gem 'flutie', '~> 2.0.0'

# Paging
gem 'kaminari', '~> 1.0.1'

# Compress JavaScript in production
gem 'uglifier', '>= 1.3.0'

# CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'

# Optional daster navigation with some JavaScript caveats
# Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'

# Build JSON APIs with ease.
# Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# Alternative to Jbuilder
# gem 'active_model_serializers', '~> 0.10.0'

# Authorization policies
gem 'pundit', '~> 1.1.0'

# Soft delete
gem 'paranoia', '~> 2.4.0'

# Encrypted attributes
# gem 'attr_encrypted', '~> 3.0', '>= 3.0.1'

# Better counter caches
# gem 'counter_culture', '~> 0.1.33'

# Charts made easy
# gem 'chartkick'

# File uploads and attachments
gem 'aws-sdk', '~> 3.0.x'
gem 'paperclip', '~> 5.1.0'

# Administration area and additional gems required for it to work with Rails 5
gem 'activeadmin', '~> 1.2.1'
gem 'inherited_resources', '~> 1.8.0'

# Clone records with a click
# gem 'active_admin-duplicatable'

# Batch import from CSV
# gem 'active_admin_import'

# Batch archive and batch restore
# gem 'active_admin_paranoia'

# advanced UI controls:
# enums, booleans, tags, lists, colors, images
# datepickers, ajax search, nested selects
# gem 'activeadmin_addons'

# Form builder
gem 'formtastic', '~> 3.1'

# HTML/XML parser
gem 'nokogiri', '~> 1.8.1'

# Model factories in all environments
gem 'factory_girl_rails', '~> 4.9.0'

# Fake values generator
gem 'faker', '~> 1.8.7'

# Changes audit
gem 'paper_trail', '~> 8.1.2'

# Make network requests
# gem 'httpclient', '~> 2.8'

# Run JavaScript code on the server
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# API authentication
gem 'graphql', '~> 1.7.8'
gem 'jwt', '~> 1.5.6'
gem 'knock', '~> 2.1.1'

# enable cross-origin resource sharing
gem 'rack-cors', '~> 1.0.1', require: 'rack/cors'

group :development do
  # Run app in background for faster reload
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Run tests in background, too
  gem 'spring-commands-rspec', '~> 1.0.4'

  # Very informative error pages with console
  gem 'better_errors', '~> 2.4.0'

  # Insert console everywhere it's required
  gem 'binding_of_caller', '~> 0.8.0'
  gem 'listen', '~> 3.1.5'
  gem 'web-console', '~> 3.5.1'

  # Debugger for console-only environments
  gem 'byebug', '~> 9.1.0', platform: :mri
end

group :development, :test do
  # Eloquent specs
  gem 'rspec-rails', '~> 3.6.1'

  # Testing helpers
  gem 'shoulda-matchers', '~> 3.1.2'

  # Cleaner test names
  gem 'should_not', '~> 1.1.0'

  # Time travel
  gem 'timecop', '~> 0.9.1'

  # View sent letters locally
  gem 'letter_opener', '~> 1.6.0'

  # Acceptance testing
  gem 'capybara', '~> 2.17.0'

  # Screenshot all failures
  gem 'capybara-screenshot', '~> 1.0.18'

  # Email utilities
  gem 'capybara-email', '~> 2.5.0'

  # Test with real Chrome
  gem 'chromedriver-helper', '~> 1.1.0'
  gem 'selenium-webdriver', '~> 3.8.0'

  # Testing Rack::Attack
  gem 'rack-test', '~> 0.8.2'

  # Documentation
  gem 'raddocs', '~> 2.2.0'
  gem 'rspec_api_documentation', '~> 5.0.0'

  # Automatically launches by Guard

  # Code style checker
  gem 'guard-rubocop', '~> 1.3.0'
  gem 'rubocop', '~> 0.52.1', require: false
  gem 'rubocop-rspec', '~> 1.22.0'

  # Automagically launches tests for changed files
  gem 'guard', '~> 2.14.2'
  gem 'guard-rspec', '~> 4.7.3', require: false

  # And updates gems when needed
  gem 'guard-bundler', '~> 2.1.0', require: false

  # And auto starts rails server
  gem 'guard-rails', '~> 0.8.1'

  # And auto runs migrations
  gem 'guard-migrate', '~> 2.0.0'
end

group :test do
  # Instafailing formatter
  gem 'fuubar', '~> 2.3.1'

  # Generate code coverate reports
  gem 'simplecov', '~> 0.13.0'

  # Upload coverage reports to CodeClimate
  gem 'codeclimate-test-reporter', '~> 1.0.8', require: nil

  # Test background jobs
  gem 'rspec-sidekiq', '~> 3.0.3'

  # Mutation testing
  gem 'mutant-rspec', '~> 0.8.14'
end

group :production do
  # Redirect from additional hosts to original
  gem 'rack-canonical-host', '~> 0.2.3'

  # New Relic APM
  gem 'newrelic_rpm', '~> 4.7.1.340'
end
