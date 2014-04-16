require 'sinatra'
require 'base64'
require 'pstore'

require 'json'

require 'net/http'
require 'uri'
require './lib/storage.rb'
require './lib/web.rb'

set :bind, '0.0.0.0'

post '/receive_mms' do
  Storage.save "body", Web.get_image(request.body)
end

get '/mms' do
  erb :mms
end

get '/last_mms.jpg' do
  headers 'Content-Type' => "image/jpeg", 'Strict-Transport-Security' => "1"
  last_mms_received
end

def last_mms_received
  Storage.retrieve "body"
end