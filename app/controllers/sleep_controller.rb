class SleepController < ActionController::Metal
  # Metal controllers require explicit Instrumentation to support Lograge and New Relic
  include ActionController::Instrumentation

  def show
    options = /^(?<from>\d+)(-(?<to>\d+))?(?<scale>ms|s|m)/.match(params[:period])

    period = options[:from].to_i

    if options[:to]
      from, to = [period, options[:to].to_i].sort
      period = rand(from..to)
    end

    period_in_seconds =
      case options[:scale]
      when 'm' then period * 60.0
      when 'ms' then period / 1000.0
      else period
      end

    sleep period_in_seconds

    response.body = "#{period}#{options[:scale]}"
  end
end
