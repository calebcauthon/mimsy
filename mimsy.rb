require 'sinatra'
require 'base64'
require 'pstore'

require 'json'

require "net/http"
require "uri"

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

get '/last_mms_att.jpg' do
  attachments_boundary = last_mms_received.match(/boundary="(.+)"/)[1]

  attachment_body = last_mms_received.match(/--#{attachments_boundary}(.+)--#{attachments_boundary}/m)[1]
  attachment_body += "--#{attachments_boundary}\r\n"

  next_index = attachment_body.index "--#{attachments_boundary}"

  attachments = []

  last_index = 0
  while next_index do
    this_attachment = attachment_body[last_index, next_index-last_index]

    content_type_pieces = this_attachment.match(/Content-Type: (.+); Name=(.+)/)
    
    body = this_attachment.match(/Content-Transfer-Encoding: BASE64\r\n(.+)\r\n/m)[1]
    
    attachments << { type: content_type_pieces[1], filename: content_type_pieces[2], body: body }

    last_index = next_index  + "--#{attachments_boundary}".length
    next_index = attachment_body.index "--#{attachments_boundary}", last_index
  end

  images = attachments.select { |this_attachment| this_attachment[:type] == 'image/jpeg' }

  headers 'Content-Type' => "image/jpeg", 'Strict-Transport-Security' => "1"
  Base64.decode64 images[0][:body]
end

def last_mms_received
  Storage.retrieve "body", body
end