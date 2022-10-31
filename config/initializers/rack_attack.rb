# typed: strict
enabled =
  if Rails.env.production?
    true
  elsif Rails.env.test?
    false
  else
    ENV["ENABLE_RACK_ATTACK"] == "true"
  end

Rack::Attack.enabled = enabled
Rack::Attack.throttled_response_retry_after_header = true

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

Rack::Attack.throttle("req/ip", limit: 60, period: 1.minute) do |req|
  req.ip unless req.path.include?("/assets")
end
