# Consolidate general guidelines, default settings, various tweaks and patches
require 'time'
require 'json'

# Compact logs
Rails.application.config.lograge.enabled = true

# Use plain logging formatter without Rails clutter
Rails.application.config.log_formatter = ::Logger::Formatter.new

# Detect 12F app environment, compatible with Heroku
if ENV["RAILS_LOG_TO_STDOUT"].present?
  Rails.application.config.logger = ActiveSupport::Logger.new(STDOUT)
end

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]
