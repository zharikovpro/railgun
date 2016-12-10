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

# Log process host, pid, timestamp and all request params by default
Rails.application.config.lograge.custom_options = lambda do |event|
  payload = event.payload.fetch(:lograge, {})

  payload[:pid] = Process.pid

  payload[:timestamp] = Time.now.utc.iso8601(3)

  payload.merge!(event.payload[:params].except('controller', 'action').transform_keys { |key| "params.#{key}" })
end

# Metal controllers require explicit Instrumentation to support Lograge and New Relic
# https://github.com/zharikovpro/railgun/issues/13
# TODO: Code below could force instrumentation usage to never forget essential logging,
# but coupled with inherited_resources gem which is required by ActiveAdmin this hack outputs logs twice
# ActionController::Metal.class_eval do
#   include ActionController::Instrumentation
# end

# Patch required to automatically log request_ip, request_uuid, user_id inside all controllers
# It also escapes special chars in values to make output compatible with KVP format used by LogEntries
# Original file: actionpack/lib/action_controller/metal/instrumentation.rb, line 17
ActionController::Instrumentation.class_eval do
  def process_action(*args)
    # one log line must consist of key=value pairs without line breaks
    # as values may contain special chars like space, tab, comma, line break and quotes,
    # they must be dumped in a log-friendly escaped format, surrounded with quotes
    escaped_params = request.filtered_parameters.map do |key, val|
      escaped_val = val.is_a?(String) ? val : val.to_json
      [key, escaped_val.dump]
    end.to_h

    raw_payload = {
      :controller => self.class.name,
      :action     => self.action_name,
      :params     => escaped_params,
      :headers    => request.headers,
      :format     => request.format.ref,
      :method     => request.request_method,
      :path       => request.fullpath
    }

    raw_payload[:lograge] = {} # railgun
    raw_payload[:lograge][:host] = request.host # railgun
    raw_payload[:lograge][:request_uuid] = request.uuid # railgun
    raw_payload[:lograge][:request_ip] = request.remote_ip # railgun
    raw_payload[:lograge][:user_id] = current_user.try(:id) if defined?(current_user) # railgun

    ActiveSupport::Notifications.instrument("start_processing.action_controller", raw_payload.dup)

    ActiveSupport::Notifications.instrument("process_action.action_controller", raw_payload) do |payload|
      begin
        result = super
        # try used to avoid exception from failed devise authentication
        # https://github.com/roidrage/lograge/issues/67
        payload[:status] = response.try(:status) # railgun
        result
      ensure
        append_info_to_payload(payload)
      end
    end
  end
end
