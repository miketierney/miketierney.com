# Play nice with Bundler and RVM
require 'bundler/capistrano'
# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# require 'rvm/capistrano'

set :default_environment, {
  'PATH' => '/var/www/sites/u/apps/.rvm/gems/ruby-1.8.7-p302@miketierney-com/bin:/var/www/sites/u/apps/.rvm/gems/ruby-1.8.7-p302@global/bin:/var/www/sites/u/apps/.rvm/rubies/ruby-1.8.7-p302/bin:/var/www/sites/u/apps/.rvm/bin:$PATH',
  'GEM_HOME' => '/var/www/sites/u/apps/.rvm/gems/ruby-1.8.7-p302@miketierney-com',
  'GEM_PATH' => '/var/www/sites/u/apps/.rvm/gems/ruby-1.8.7-p302@miketierney-com:/var/www/sites/u/apps/.rvm/gems/ruby-1.8.7-p302@global',
  'BUNDLE_PATH' => '/var/www/sites/u/apps/.rvm/gems/ruby-1.8.7-p302@global'
}

# Who are we?
set :application, 'miketierney'
set :repository, "git@panpainter.com:miketierney.com.git"
set :scm, "git"
set :deploy_via, :remote_cache
set :branch, "master"

set :ssh_options, {
  :forward_agent => true,
  :user => 'greyzenith'
}

# Where to deploy to?
server "miketierney.com", :web, :app, :db
# role :web, "74.207.247.99"
# role :app, "74.207.247.99"
# role :db,  "74.207.247.99", :primary => true

# Deploy details
set :user, "deploy"
set :deploy_to, "/var/www/sites/u/apps/#{application}"
set :use_sudo, false
set :checkout, 'export'

set :rvm_ruby_string, '1.8.7-p302@miketierney-com'
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

after "deploy", "rvm:trust_rvmrc"
namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end