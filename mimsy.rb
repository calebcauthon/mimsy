require 'sinatra'
require 'base64'
require 'pstore'

require 'json'

require 'pry'
require 'pry-remote'

require 'net/http'
require 'uri'
require './lib/storage.rb'
require './lib/web.rb'
require './lib/mogreet_parser.rb'


set :bind, '0.0.0.0'

post '/receive_mms' do
  input = request.body.read

  body = Web.get_image input
  phone_number = Web.get_phone_number input
  
  Storage.save phone_number, body
end

get '/mms' do
  erb :mms
end

get '/last_mms.jpg' do
  headers 'Content-Type' => "image/jpeg", 'Strict-Transport-Security' => "1"
  last_mms_received
end

get %r{/([\d]+)\.jpg} do
  headers 'Content-Type' => "image/jpeg", 'Strict-Transport-Security' => "1"
  Storage.retrieve params[:captures][0]
end

def last_mms_received
  Storage.retrieve "body"
end