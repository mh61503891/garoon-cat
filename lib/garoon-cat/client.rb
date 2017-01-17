require 'httpclient'

class GaroonCat::Client

  attr_reader :username
  attr_reader :password

  def initialize(username:, password:)
    @client = HTTPClient.new
    @username = username
    @password = password
  end

  def get(uri)
    @client.get_content(uri)
  end

  def post(uri, data)
    @client.post_content(uri, data)
  end

end
