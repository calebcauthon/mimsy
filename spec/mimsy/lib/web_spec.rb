require File.expand_path(File.dirname(__FILE__) + '/../../../spec/spec_helper.rb')

describe 'web' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "uses the parser to get an image url" do
    class Web
      module Parser
        def self.parse json
          { image_url: "https://www.google.com/images/srpr/logo11w.png" }
        end
      end
    end
    
    mock_net_response = Object.new
    mock_net_response.stubs(:body).returns true

    URI.expects(:parse).with "https://www.google.com/images/srpr/logo11w.png"
    Net::HTTP.stubs(:get_response).returns mock_net_response

    image = Web.get_image "mock input"
  end
end