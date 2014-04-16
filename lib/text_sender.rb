class TextSender
  def self.send_mms_notification phone_number, text
    url_encoded_text = URI::encode text
    
    url = "https://api.mogreet.com/moms/transaction.send?client_id=6170&token=1ed32013463d2e476cce7486485b05de&campaign_id=68725&to=#{phone_number}&message=#{url_encoded_text}&format=json"
    
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ssl_version = :SSLv3
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    response.body
  end
end