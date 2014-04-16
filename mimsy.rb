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
require './lib/text_sender.rb'


set :bind, '0.0.0.0'

post '/ask' do
  phone_number = params[:phone_number].gsub(/[^0-9]/, '')
  phone_number = "1#{phone_number}" if phone_number[0] != "1"
    

  TextSender.send_mms_notification phone_number, "Reply with word \"testmimsy\" and an image to upload your image."
  {
    filename: "#{phone_number}.jpg",
    image_url: "http://#{request.host}/#{phone_number}.jpg"
  }.to_json
end

post '/receive_mms' do
  input = request.body.read

  body = Web.get_image input
  phone_number = Web.get_phone_number input
  
  Storage.save phone_number, body

  TextSender.send_mms_notification phone_number, "Your image has been saved at http://#{request.host}/#{phone_number}.jpg"
end

get '/mms' do
  erb :mms
end

get '/last_mms.jpg' do
  headers 'Content-Type' => "image/jpeg", 'Strict-Transport-Security' => "1"
  last_mms_received
end

get %r{/([\d]+)\.jpg} do
  result = Storage.retrieve params[:captures][0]

  if result
    headers 'Content-Type' => "image/jpeg", 'Strict-Transport-Security' => "1"
    result
  else
    "0"
  end
end

def last_mms_received
  Storage.retrieve "body"
end