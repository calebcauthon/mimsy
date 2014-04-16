ENV['RACK_ENV'] = 'test'

require 'sinatra.rb'  # <-- your sinatra app
require 'rspec'
require 'rack/test'
require 'storage.rb'

describe 'storage' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "exists" do
    Storage
  end

  [{ key: "food", value: "applesauce" }, { key: "animal", value: "cat" }].each do |hash|
    it "saves stuff" do
      Storage.save hash[:key], hash[:value]
      expect(Storage.retrieve(hash[:key])).to eql(hash[:value])
    end
  end
end