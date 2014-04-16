ENV['RACK_ENV'] = 'test'

require './mimsy.rb'  # <-- your sinatra app
require 'rspec'
require 'rack/test'
require './lib/storage.rb'
require 'mocha/api'
require 'pry'


describe 'receive_mms' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "exists" do
    Web = double()
    Web.stubs(:get_image).returns :image

    Storage.stubs(:save).expects :image
    
    post '/receive_mms'
    expect(last_response).to be_ok
  end
end