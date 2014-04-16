require File.expand_path(File.dirname(__FILE__) + '/../../../spec/spec_helper.rb')

describe 'storage' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "parses mogreet input and gets the phone number and image url" do
    json_input = "{\n\t\"event\": \"message-in\",\n\t\"type\": \"command_mms\",\n\t\"campaign_id\": \"68788\",\n\t\"msisdn\": \"19133758105\",\n\t\"shortcode\": \"343434\",\n\t\"carrier\": \"AT&T\",\n\t\"carrier_id\": \"3\",\n\t\"message\": \"Testmimsy\",\n\t\"subject\": \"\",\n\t\"images\": [\n\t\t{\n\t\t\t\"image\": \"http://d2c.bandcon.mogreet.com/mo-mms/images/25ce0c006c525526fb92cd686f8e458d.jpeg\"\n\t\t}\n\t]\n}"
    hash = MogreetParser.parse json_input
    
    hash[:phone].must_equal "19133758105"
    hash[:image_url].must_equal "http://d2c.bandcon.mogreet.com/mo-mms/images/25ce0c006c525526fb92cd686f8e458d.jpeg"
  end
end