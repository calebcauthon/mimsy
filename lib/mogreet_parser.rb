class MogreetParser
  def self.parse json
    image_url = JSON.parse(json)["images"][0]["image"]
    phone = JSON.parse(json)["msisdn"]

    { phone: phone, image_url: image_url }
  end
end