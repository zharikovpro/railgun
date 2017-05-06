ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
=begin
require 'rails/commands/server'

module DefaultOptions
  def default_options
    super.merge!(Port: 5000) # default for `heroku local`
  end
end

Rails::Server.prepend(DefaultOptions)
=end
