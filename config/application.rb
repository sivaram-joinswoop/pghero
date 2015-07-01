require "bundler/setup"
Bundler.require
require "rails/all"

module PgHeroSolo
  class Application < Rails::Application
    routes.append do
      mount PgHero::Engine, at: "/"
    end

    config.cache_classes = true
    config.eager_load = true
    config.secret_key_base = ENV["SECRET_KEY_BASE"] || SecureRandom.hex(30)
  end
end
