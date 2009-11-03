require 'rubygems'
require 'rack'
require 'sinatra'
require 'haml'
require 'erb'
require 'app.rb'

root_dir = File.dirname(__FILE__)

disable :run
# set :run, false
set :environment, :production
set :raise_errors, true
set :views, root_dir + '/views'
set :public, root_dir + '/public'
set :app_file, __FILE__

log = File.new("log/sinatra.log", "a+")
STDOUT.reopen(log)
STDERR.reopen(log)

run Sinatra::Application