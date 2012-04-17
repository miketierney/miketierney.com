require 'bundler/capistrano'
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
#require 'rvm/capistrano'

set :default_environment, {
  'PATH' => '/home/deploy/.rvm/gems/ruby-1.8.7-p302@miketierney-com/bin:/home/deploy/.rvm/gems/ruby-1.8.7-p302@global/bin:/home/deploy/.rvm/rubies/ruby-1.8.7-p302/bin:/home/deploy/.rvm/bin:$PATH',
  'GEM_HOME' => '/home/deploy/.rvm/gems/ruby-1.8.7-p302@miketierney-com',
  'GEM_PATH' => '/home/deploy/.rvm/gems/ruby-1.8.7-p302@miketierney-com:/home/deploy/.rvm/gems/ruby-1.8.7-p302@global',
  'BUNDLE_PATH' => '/home/deploy/.rvm/gems/ruby-1.8.7-p302@global'
}

# Who are we?
set :application, 'miketierney'
set :repository, "git@panpainter.com:miketierney.com.git"
set :scm, "git"
set :deploy_via, :remote_cache
set :branch, "master"

set :ssh_options, {
  :forward_agent => true,
  :user => 'deploy',
  :keys => [File.join(ENV["HOME"], ".ec2", "mtierneyawskey.pem")]
}

# Where to deploy to?
server "ec2-107-20-223-50.compute-1.amazonaws.com", :web, :app, :db
#role :web, "107.20.223.50"
#role :app, "107.20.223.50"
#role :db,  "107.20.223.50", :primary => true

# Deploy details
set :user, "deploy"
set :deploy_to, "/var/www/sites/u/apps/#{application}"
set :use_sudo, false
set :checkout, 'export'

set :rvm_ruby_string, '1.8.7-p302@miketierney-com'
#set :rvm_type, :system
set :bundle_flags, "--deployment"

namespace :deploy do

  task :restart do
    run "test -d #{current_path}/tmp || mkdir #{current_path}/tmp"
    run "test -d #{current_path}/log || mkdir #{current_path}/log"
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy:symlink", "mike_symlinks"
task :mike_symlinks, :roles => :app, :except => {:no_release => true, :no_symlink => true} do
  # ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml
  run <<-CMD
  cd #{release_path} &&
  ln -s /var/www/sites/u/apps/shared/miketierney/mini #{release_path}/public/mini &&
  ln -s /var/www/sites/u/apps/shared/miketierney/nonsense #{release_path}/public/nonsense &&
  ln -s /var/www/sites/u/apps/shared/miketierney/resume #{release_path}/public/resume &&
  ln -s /var/www/sites/u/apps/shared/miketierney/ruby #{release_path}/public/ruby &&
  ln -s /var/www/sites/u/apps/shared/miketierney/seattle #{release_path}/public/seattle &&
  ln -s /var/www/sites/u/apps/shared/miketierney/skitch #{release_path}/public/skitch
  CMD
end

after "deploy", "rvm:rvmrc_trust"
namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end
