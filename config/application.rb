require "bundler/setup"
Bundler.require
require "rails/all"

unless ENV["DATABASE_URL"]
  if File.exist?(PgHero.config_path)
    ENV["DATABASE_URL"] = "nulldb:///"
  else
    abort "No DATABASE_URL or config/pghero.yml"
  end
end

module PgHeroSolo
  class Application < Rails::Application
    routes.append do
      mount PgHero::Engine, at: "/"
    end

    config.cache_classes = true
    config.eager_load = true
    config.log_level = :info
    config.secret_key_base = ENV["SECRET_KEY_BASE"] || SecureRandom.hex(30)

    config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"] != "disabled"

    if ENV["RAILS_LOG_TO_STDOUT"] != "disabled"
      logger           = ActiveSupport::Logger.new(STDOUT)
      logger.formatter = config.log_formatter
      config.logger = ActiveSupport::TaggedLogging.new(logger)
    end

    PgHero.show_migrations = false
  end
end
