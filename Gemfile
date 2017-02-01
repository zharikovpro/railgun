source 'https://rubygems.org'

ruby File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip

# Pretty print Ruby objects
gem 'awesome_print'

# Load ENV variables from .env file
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Exceptions monitoring
gem 'rollbar'

# Guess my country
gem 'russian'

# Generate security report with brakeman -o brakeman.html
gem 'brakeman', require: false

# Cron jobs manager
# gem 'whenever', require: false

# Background jobs queue
gem 'sidekiq', '~> 4.2', '>= 4.2.8'

# Track failed jobs
gem 'sidekiq-failures', '~> 0.4.5'

# Scheduled and recurrent background jobs
# gem 'sidetiq', '~> 0.6.3'

# Expiration time for jobs
# gem 'sidekiq-status', '~> 0.6.0'

# Skip duplicate jobs
# gem 'sidekiq-unique-jobs', '~> 4.0', '>= 4.0.17'

# Rate limit jobs execution
# gem 'sidekiq-throttler', '~> 0.5.1'

# Optional CORS support
# gem 'rack-cors', :require => 'rack/cors'

# Passenger has the best documentation and support
gem 'passenger', '~> 5.1'

# Rails 5 with Action Cable
gem 'rails', '~> 5.0.1'

# Redis for Action Cable, Sidekiq and cache
# gem 'redis', '~> 3.0'

# Compact logs
gem 'lograge'

# Restore original remote_ip when using CloudFlare
gem 'actionpack-cloudflare'

# Elastic logs support
# gem 'logstash-event'
# gem 'logstash-logger'

# PostgreSQL for Active Record
gem 'pg', '~> 0.18'

# Automatically creates validations basing on the database schema
gem 'schema_validations', '~> 2.2.x'

# Versioned database views in migrations
# gem 'scenic', '~> 1.3.0'

# When PostgreSQL is not an option
# gem 'mysql2'

# Group temporal data by date
# gem 'groupdate', '~> 2.5.3'

# Group count queries
# gem 'hightop', '~> 0.1.4'

# Authentication engine
gem 'devise', '~> 4.2.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Authorization helpers
# gem 'pundit', '~> 1.1'

# Slim for templates
gem 'slim', '~> 3.0.7'
gem 'slim-rails', '~> 3.1.0'

# Stylus for styles
gem 'stylus', '~> 1.0.1'

# Static pages
gem 'high_voltage'

# View helpers
gem 'flutie'

# Paging
gem 'kaminari'

# Compress JavaScript in production
gem 'uglifier', '>= 1.3.0'

# CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Optional daster navigation with some JavaScript caveats
# Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'

# Build JSON APIs with ease.
# Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# Alternative to Jbuilder
# gem 'active_model_serializers', '~> 0.10.0'

# Authorization policies
gem "pundit", '~> 1.1.0'

# Soft delete
gem "paranoia", "~> 2.2"

# Encrypted attributes
# gem 'attr_encrypted', '~> 3.0', '>= 3.0.1'

# Track versioned model changes
# gem 'paper_trail', '~> 5.2.0'

# Better counter caches
# gem 'counter_culture', '~> 0.1.33'

# Charts made easy
# gem 'chartkick'

# File uploads and attachments
# gem 'paperclip', '~> 5.1.0'
# gem 'aws-sdk', '~> 2.6.33'

# Administration area and additional gems required for it to work with Rails 5
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'

# Make network requests
# gem 'httpclient', '~> 2.8'

# Run JavaScript code on the server
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

group :development do
  # Run app in background for faster reload
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Run tests in background, too
  gem 'spring-commands-rspec'

  # Very informative error page with console
  gem 'better_errors'

  # Insert console everywhere it's required
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem "binding_of_caller"

  # Debugger for console-only environments
  gem 'byebug', platform: :mri
end

group :development, :test do
  # Eloquent specs
  gem 'rspec'
  gem 'rspec-rails'

  # Testing helpers
  gem 'shoulda-matchers'

  # Cleaner test names
  gem 'should_not'

  # Model factories
  gem 'factory_girl_rails'

  # Fake values generator
  gem 'faker'

  # Time travel
  gem 'timecop'

  # View sent letters locally
  gem 'letter_opener'

  # Acceptance testing
  gem 'capybara'

  # Faster driver with additional setup
  # gem 'capybara-webkit'

  # Screenshots for failed tests
  gem 'capybara-screenshot'
end

group :test do
  # Run tests with clean database
  gem 'database_cleaner'

  # Generate code coverate reports
  gem 'simplecov'

  # Upload coverage reports to CodeClimate
  gem 'codeclimate-test-reporter', require: nil

  # Test background jobs
  gem 'rspec-sidekiq'
end

group :production do
  # Redirect from additional hosts to original
  gem 'rack-canonical-host'

  # New Relic APM
  gem 'newrelic_rpm'

  # faster JSON serialization recommended by Rollbar
  gem 'oj', '~> 2.12.14'
end
