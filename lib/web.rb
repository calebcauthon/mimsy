class Web
  def parse http_post_request
    JSON.parse(http_post_request.string)["images"][0]["image"]
  end

  def self.get_image http_post_request
    image_url = parse http_post_request
    Net::HTTP.get_response(URI.parse(image_url)).body
  end
end
