require 'test_helper'

class GaroonCat::ClientTest < Minitest::Test

  def client
    @client ||= GaroonCat::Client.setup(uri:ENV['URI'])
  end

  def test_setup
    assert_no_error { client }
  end

  def test_services
    assert(client.services.kind_of?(Enumerable))
    assert(!client.services.empty?)
  end

  def test_service
    client.services.each do |key|
      assert(client.service(key).instance_of?(GaroonCat::Service))
    end
  end

end
