if ENV['RAILS_ENV'] == 'development'
  port 3000
else
  app_path = '/home/deployer/www/tele_santa_bot'

  directory "#{app_path}/current"

  rackup "#{app_path}/current/config.ru"

  daemonize true

  pidfile "#{app_path}/shared/tmp/pids/puma.pid"

  state_path "#{app_path}/shared/tmp/puma.state"

  workers 2

  threads 6, 6

  bind "unix:#{app_path}/shared/tmp/sockets/puma.sock"

  preload_app!
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
