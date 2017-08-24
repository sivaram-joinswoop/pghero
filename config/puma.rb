workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

rackup DefaultRackup
if ENV['BIND']
  bind ENV['BIND']
else
  port ENV['PORT'] || 3000
end
environment ENV['RACK_ENV'] || 'development'

unless ENV['DATABASE_URL']
  if File.exist?('config/pghero.yml')
    ENV['DATABASE_URL'] = 'nulldb:///'
  else
    abort "No DATABASE_URL or config/pghero.yml"
  end
end

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end
