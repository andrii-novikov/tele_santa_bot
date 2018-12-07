lock '3.8.2'

set :application, 'tele_santa_bot'
set :repo_url, 'git@github.com:andy1341/tele_santa_bot.git'

set :deploy_to, '/home/deployer/www/tele_santa_bot'
set :deploy_via, :copy

set :log_level, :debug
set :pty, true

set :rvm1_map_bins, %w[gem bundle ruby]
set :rvm1_ruby_version, 'ruby-2.5.3'

set :rvm_type, :user
set :default_env, rvm_bin_path: '~/.rvm/bin'

# Default value for :linked_files is []
append :linked_files, 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/sockets'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

namespace :deploy do
  desc 'Uploads required sekrets decrypt key'
  task :upload_key do
    on roles(:all) do
      upload!("config/master.key", "#{deploy_to}/shared/config/master.key")
    end
  end

  desc 'Seeds database'
  task :seed do
    on roles(:app) do
      invoke 'rvm1:hook'
      within release_path do
        execute :bundle, :exec, :"rake db:seed RAILS_ENV=#{fetch(:stage)}"
      end
    end
  end

  after :finished, 'deploy:seed'
  after :finished, 'app:restart'
end


namespace :app do
  desc 'Start application'
  task :start do
    on roles(:app) do
      invoke 'rvm1:hook'
      within "#{fetch(:deploy_to)}/current/" do
        execute :bundle, :exec, :"puma -C config/puma.rb -e #{fetch(:stage)}"
      end
    end
  end

  desc 'Set webhook'
  task :start do
    on roles(:app) do
      invoke 'rvm1:hook'
      within "#{fetch(:deploy_to)}/current/" do
        execute :bundle, :exec, :"RAILS_ENV=#{fetch(:stage)} rails telegram:bot:set_webhook"
      end
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app) do
      invoke 'rvm1:hook'
      within "#{fetch(:deploy_to)}/current/" do
        execute :bundle, :exec, :'pumactl -F config/puma.rb stop'
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      invoke 'rvm1:hook'
      within "#{fetch(:deploy_to)}/current/" do
        if test("[ -f #{deploy_to}/current/tmp/pids/puma.pid ]")
          execute :bundle, :exec, :'pumactl -F config/puma.rb stop'
        end

        execute :bundle, :exec, :"puma -C config/puma.rb -e #{fetch(:stage)}"
      end
    end
  end
end
