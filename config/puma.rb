threads 10, 10
workers 2

rails_env = ENV["RAILS_ENV"] || "development"

environment rails_env
daemonize false

quiet

pidfile "tmp/pids/puma.pid"
state_path "tmp/pids/puma.state"

if rails_env == "development"
  bind "tcp://0.0.0.0:3000"
else
  bind "unix://tmp/sockets/puma.sock"
end

on_worker_boot do
  require "active_record"

  cwd = File.dirname(__FILE__) + "/.."
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{cwd}/config/database.yml")[rails_env])
end
