require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'slings_uploader', url: 'redis://localhost:6379/2' }
end

Sidekiq.configure_server do |config|
  config.redis = { namespace: 'slings_uploader', url: 'redis://localhost:6379/2' }
end
