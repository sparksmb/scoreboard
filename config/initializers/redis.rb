require "redis"

REDIS_URL = ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" }

$redis = Redis.new(url: REDIS_URL, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
