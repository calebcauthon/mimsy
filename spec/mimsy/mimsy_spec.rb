require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe 'receive_mms' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'exists' do
    Web.stubs(:get_image).returns :image
    Web.stubs(:get_phone_number).returns :number

    Storage.expects(:save).with :number, :image
    TextSender.stubs(:send_mms_notification)
    
    post '/receive_mms'

    last_response.status.must_equal 200
  end
end