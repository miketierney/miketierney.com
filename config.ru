gem 'sinatra-content-for'
gem 'emk-sinatra-url-for'
gem 'sinatra-static-assets'

require 'rubygems'
require 'rack'
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/url_for'
require 'sinatra/static_assets'
require 'haml'
require 'erb'
require 'app.rb'

root_dir = File.dirname(__FILE__)

disable :run
# set :run, false
set :environment, :production
set :raise_errors, true
set :views, root_dir + '/views'
set :public_folder, root_dir + '/public'
set :app_file, __FILE__

log = File.new("log/sinatra.log", "a+")
STDOUT.reopen(log)
STDERR.reopen(log)

run Sinatra::Application