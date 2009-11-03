# CSS
get '/styles.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :styles
end

# index
get '/' do
  erb :index
end