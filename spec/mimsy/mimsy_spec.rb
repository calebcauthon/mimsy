require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe 'receive_mms' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'exists' do
    Web.stubs(:get_image).returns :image

    Storage.expects(:save).with "body", :image
    
    post '/receive_mms'
    last_response.status.must_equal 200
  end
end