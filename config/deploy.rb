# bundler
require 'bundler/capistrano'
before 'bundle:install' do
  # Install the pg gem
  run "cd #{fetch(:latest_release)} && bundle config build.pg --with-pg-config=/usr/pgsql-9.1/bin/pg_config"
end

set :application, "91.231.85.175"
set :repository,  "git@github.com:asiniy/nod_avatars.git"
set :scm, :git
set :deploy_to, "/home/asiniy/nod_avatars"
set :use_sudo, false
set :rails_env, "production"
set :user, "asiniy"  # The server's user for deploys

#default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV['HOME'], '.ssh', 'id_rsa')]

# rvm/capistrano
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-2.0.0-p195@nod_avatars'
set :rvm_type, :user

role :web, "91.231.85.175"                   # Your HTTP server, Apache/etc
role :app, "91.231.85.175"                   # This may be the same as your `Web` server
role :db,  "91.231.85.175", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
#after "deploy:restart", "deploy:cleanup"
after 'deploy:assets:symlink', 'deploy:symlinks_shared'
after 'deploy:assets:symlink', 'carrierwave:symlink'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "Restarting the app"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlinks the needed files"
  task :symlinks_shared, roles: :app do
    %w(config/database.yml config/application.yml .ruby-version .ruby-gemset).each do |symlink|
      run "ln -nfs #{shared_path}/#{symlink} #{release_path}/#{symlink}"
    end
  end
end

namespace :carrierwave do
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/public/uploads/ #{release_path}/public/uploads"
  end
end

desc "Returns last lines of log file. Usage: cap log [-s lines=100] [-s rails_env=production]"
task :log do
  lines = 100
  rails_env = 'production'
  run "tail -n #{lines} #{deploy_to}/current/log/#{rails_env}.log" do |ch, stream, out|
    puts out
  end
end
