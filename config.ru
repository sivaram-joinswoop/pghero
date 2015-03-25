require "bundler/setup"
Bundler.require
require "securerandom"
require "pghero/engine"
require "rails_12factor"
require "rails/all"

class PGHeroSolo < Rails::Application
  routes.append do
    mount PgHero::Engine, at: "/"
  end

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.secret_key_base = ENV['SECRET_KEY_BASE'] || SecureRandom.hex(30)
  # config.force_ssl = Rails.env.production?
end

PGHeroSolo.initialize!
run PGHeroSolo
