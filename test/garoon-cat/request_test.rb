require 'test_helper'

class GaroonCat::RequestTest < Minitest::Test

  def test_to_s
    s = GaroonCat::Request.new.to_s
    puts s
    # require 'pry'
    # binding.pry
  end

  def test_parse
    require 'rexml/document'
    assert_no_error {
      REXML::Document.new(GaroonCat::Request.new.to_s)
    }
  end

end
