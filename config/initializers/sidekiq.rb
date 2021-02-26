Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

# Sidekiq::Cron::Job.destroy_all!

schedule_path = File.join(File.dirname(__FILE__), 'schedule.yml')
hash = YAML.load_file(schedule_path)
Sidekiq::Cron::Job.load_from_hash(hash)
