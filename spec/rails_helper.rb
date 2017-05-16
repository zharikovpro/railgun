# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'fileutils'
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'
require 'paper_trail/frameworks/rspec'
require 'paperclip/matchers'
require 'pundit/rspec'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
require 'capybara/email/rspec'
require 'capybara/poltergeist'

require 'aws-sdk'
Aws.config[:s3] = { stub_responses: true }

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers
  config.include Rails.application.routes.url_helpers
  config.include AcceptanceSupport, type: :feature
  config.include ActiveSupport::Testing::TimeHelpers
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :view

  config.after(:each) { Warden.test_reset! }
  config.after(:suite) { FileUtils.rm_rf("#{Rails.root}/tmp/paperclip") }

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # http://www.virtuouscode.com/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  config.use_transactional_fixtures = false

  # https://relishapp.com/rspec/rspec-rails/docs/controller-specs/anonymous-controller
  config.infer_base_class_for_anonymous_controllers = false
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app, {
    timeout: 60,
    window_size: [1280, 720],
    js_errors: true
  }
end

Capybara.app_host = 'http://localhost:5050'
Capybara.server_host = 'localhost'
Capybara.server_port = '5050'
Capybara.default_max_wait_time = 10

Capybara.javascript_driver = :poltergeist
Capybara.ignore_hidden_elements = true
Capybara::Screenshot.prune_strategy = :keep_last_run

# Values listed are the default values
RspecApiDocumentation.configure do |config|
  # Set the application that Rack::Test uses
  config.app = Rails.application

  # Output folder
  config.docs_dir = Rails.root.join("doc", "api")

  # An array of output format(s).
  # Possible values are :json, :html, :combined_text, :combined_json,
  #   :json_iodocs, :textile, :markdown, :append_json, :slate
  config.format = [:json]

  # Location of templates
  config.template_path = "inside of the gem"

  # Filter by example document type
  config.filter = :all

  # Filter by example document type
  config.exclusion_filter = nil

  # Used when adding a cURL output to the docs
  config.curl_host = nil

  # Used when adding a cURL output to the docs
  # Allows you to filter out headers that are not needed in the cURL request,
  # such as "Host" and "Cookie". Set as an array.
  config.curl_headers_to_filter = nil

  # By default, when these settings are nil, all headers are shown,
  # which is sometimes too chatty. Setting the parameters to an
  # array of headers will render *only* those headers.
  config.request_headers_to_include = nil
  config.response_headers_to_include = nil

  # By default examples and resources are ordered by description. Set to true keep
  # the source order.
  config.keep_source_order = false

  # Change the name of the API on index pages
  config.api_name = "API Documentation"

  # Redefine what method the DSL thinks is the client
  # This is useful if you need to `let` your own client, most likely a model.
  config.client_method = :client

  # Change the IODocs writer protocol
  config.io_docs_protocol = "http"

  # You can define documentation groups as well. A group allows you generate multiple
  # sets of documentation.
  config.define_group :public do |config|
    # By default the group's doc_dir is a subfolder under the parent group, based
    # on the group's name.
    config.docs_dir = Rails.root.join("doc", "api", "public")

    # Change the filter to only include :public examples
    config.filter = :public
  end

  # Change how the post body is formatted by default, you can still override by `raw_post`
  # Can be :json, :xml, or a proc that will be passed the params
  config.request_body_formatter = Proc.new { |params| params }

  # Change how the response body is formatted by default
  # Is proc that will be called with the response_content_type & response_body
  # by default response_content_type of `application/json` are pretty formated.
  config.response_body_formatter = Proc.new { |response_content_type, response_body| response_body }

  # Change the embedded style for HTML output. This file will not be processed by
  # RspecApiDocumentation and should be plain CSS.
  config.html_embedded_css_file = nil

  # Removes the DSL method `status`, this is required if you have a parameter named status
  config.disable_dsl_status!

  # Removes the DSL method `method`, this is required if you have a parameter named method
  config.disable_dsl_method!
end
