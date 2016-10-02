require "bundler/setup"

require "rails/all"

Bundler.require(*Rails.groups)

module PgHeroSolo
  class Application < Rails::Application
    config.cache_classes = true
    config.eager_load = true
    config.log_level = :info
    config.secret_key_base = ENV["SECRET_KEY_BASE"] || SecureRandom.hex(30)
    config.assets.js_compressor = :uglifier

    PgHero.show_migrations = false
  end
end
