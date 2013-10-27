set :application, '91.231.85.175'
set :repo_url, 'git@github.com:asiniy/nod_avatars.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/asiniy/nod_avatars'
set :scm, :git
set :use_sudo, false
set :user, 'asiniy'

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :rvm_ruby_version, '2.0.0-p195@nod_avatars'

set :linked_files, %w{config/database.yml config/application.yml .ruby-version .ruby-gemset}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

#  namespace :assets do
#    task :precompile do
#      within fetch(:latest_release_directory) do
#        with rails_env: fetch(:rails_env) do
#          raise fetch(:rails_env).inspect
#          execute :rake, 'assets:precompile'
#        end
#      end
#    end
#  end
end
