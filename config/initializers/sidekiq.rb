# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDISCLOUD_URL"] }
end
ENV['REDIS_PROVIDER'] = ENV['REDISCLOUD_URL']

ENV['REDIS_PROVIDER'] = if Rails.env.development?
                          '127.0.0.1:6379'
                        else
                          ENV['REDISCLOUD_URL']
                        end

require 'sidekiq'
require 'sidekiq/web'
Sidekiq::Extensions.enable_delay!