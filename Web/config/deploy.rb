# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'watch-baby'
set :repo_url, 'git@github.com:306-san/watch-baby.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5
# rbenv config
set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'
set :rbenv_prefix, "RBENV_ROOT=#{ fetch(:rbenv_path) } RBENV_VERSION=#{ fetch(:rbenv_ruby) } #{ fetch(:rbenv_path) }/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all

# set bundle option
set :bundle_jobs, 1
set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }

set :pid_file, "tmp/pids/server.pid"
set :port, '80'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_files, fetch(:linked_files, [])

 namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web) do
      execute "cd #{release_path} && kill -SIGTERM `cat #{fetch(:pid_file)}`" if File.exists?("#{release_path}/#{fetch(:pid_file)}")
      execute "cd #{release_path} && (bundle exec rails s -e #{fetch(:rails_env)} --port=#{fetch(:port)} -b 0.0.0.0 &) >& /dev/null"
    end
  end
  after :publishing, :restart
 end