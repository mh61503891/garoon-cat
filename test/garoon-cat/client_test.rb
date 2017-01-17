require 'test_helper'

class GaroonCat::ClientTest < Minitest::Test

  def uri
    'http://example.net'
  end

  def setup
    WebMock.enable!
    stub_request(:get, uri).
    to_return(body:'bar')
    stub_request(:post, uri).
    to_return(body:'bazz')
  end

  def teardown
    WebMock.disable!
  end

  def test_get
    GaroonCat::Client.new.get(uri)
    assert(!GaroonCat::Client.new.get(uri).empty?)
  end

  def test_post
    assert(!GaroonCat::Client.new.post(uri, 'foo').empty?)
  end

end
