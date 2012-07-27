# require 'rubygems'
# require 'rack'
# require 'sinatra'
# require 'haml'
# require 'erb'

# CSS
get '/styles.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :styles
end

# index
get '/' do
  erb :index
end

# contact page
get '/contact' do
  erb :contact
end

helpers do
  def render(*args)
    if args.first.is_a?(Hash) && args.first.keys.include?(:partial)
      return erb "_#{args.first[:partial]}".to_sym, :layout => false
    else
      super
    end
  end
end