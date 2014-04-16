require './mimsy'
run Sinatra::Application

class Web
  module Parser
    def self.parse json
      MogreetParser.parse json
    end
  end
end