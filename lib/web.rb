class Web
  def self.get_image http_post_request
    image_url = Parser.parse(http_post_request)[:image_url]
    Net::HTTP.get_response(URI.parse(image_url)).body
  end
end
