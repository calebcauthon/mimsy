require File.expand_path(File.dirname(__FILE__) + '/../../../spec/spec_helper.rb')

describe 'storage' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  [{ key: "food", value: "applesauce" }, { key: "animal", value: "cat" }].each do |hash|
    it "saves stuff" do
      Storage.save hash[:key], hash[:value]
      Storage.retrieve(hash[:key]).must_equal hash[:value]
    end
  end

  it "returns nil if nothing is saved there" do
    Storage.retrieve("whatever").must_equal nil
  end
end