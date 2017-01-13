require 'test_helper'
require 'uri'

class GaroonCat::ServiceTest < Minitest::Test

  def test_service_new_with_error
    assert_raises(ArgumentError) {
      GaroonCat::Client.new
    }
  end

  def test_service_new_with_no_error
    assert_no_error {
      GaroonCat::Client.new(security:{})
    }
  end


end
