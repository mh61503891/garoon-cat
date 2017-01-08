require 'test_helper'

class GaroonCat::RequestTest < Minitest::Test

  def params
    {action:'Test', username:'testuser', password:'testpassword'}
  end

  def request
    GaroonCat::Request.new(params)
  end

  def test_to_s
    $stderr.puts request.to_s
  end

  def test_parse
    require 'rexml/document'
    assert_no_error {
      REXML::Document.new(request.to_s)
    }
  end

end
