require 'time'
require 'json'

# Compact logs
Rails.application.config.lograge.enabled = true

# Log process host, pid, timestamp and all request params by default
Rails.application.config.lograge.custom_options = lambda do |event|
  payload = event.payload.fetch(:lograge, {})

  payload[:pid] = Process.pid

  payload[:timestamp] = Time.now.utc.iso8601(3)

  payload.merge!(event.payload[:params].except('controller', 'action').transform_keys { |key| "params.#{key}" })
end

# Metal controllers require explicit Instrumentation initialization to support Lograge and New Relic
# Force instrumentation usage to never forget essential logging
ActionController::Metal.class_eval do
  include ActionController::Instrumentation
end

# Patch required to automatically log request_ip, request_uuid, user_id inside all controllers
# Original file: actionpack/lib/action_controller/metal/instrumentation.rb, line 17
ActionController::Instrumentation.class_eval do
  def process_action(*args)
    # one log line must consist of key=value pairs without line breaks
    # as values may contain special chars like space, tab, comma, line break and quotes,
    # they must be dumped in a log-friendly escaped format, surrounded with quotes
    escaped_params = request.filtered_parameters.map do |key, val|
      escaped_val = val.is_a?(String) ? val.dump : val.to_json
      [key, escaped_val]
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
        payload[:status] = response.status
        result
      ensure
        append_info_to_payload(payload)
      end
    end
  end
end
