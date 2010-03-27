require File.dirname(__FILE__) + '/spec_helper'

set :environment, :test

describe "Application" do
  include Rack::Test::Methods
  
  def app
    @app ||= Sinatra::Application
  end
  
  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
  
  # it "should return the correct content-type when viewing root" do
  #   get '/'
  #   last_response.headers["Content-Type"].should == "text/html"
  # end
  # 
  # it "should return 404 when page cannot be found" do
  #   get '/404'
  #   last_response.status.should == 404
  # end
  # 
  # it "should return who what now when viewing root" do
  #   get '/'
  #   last_response.body == 'who what now when'
  # end
end