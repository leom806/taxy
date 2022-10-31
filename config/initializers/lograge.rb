require "json"

Rails.application.configure do
  if !Rails.env.development? || ENV["LOGRAGE_IN_DEVELOPMENT"] == "true"
    config.lograge.ignore_actions = ["StaticController#healthcheck"]
    config.lograge.custom_options =
      lambda do |event|
        params = event.payload[:params]
        exceptions = %w[controller action format id]

        {
          time: event.time,
          params: JSON.dump(params.except(*exceptions))
        }
      end
    config.lograge.enabled = true
  else
    config.lograge.enabled = false
  end
end
