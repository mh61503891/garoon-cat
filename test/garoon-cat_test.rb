require 'test_helper'

class GaroonCatTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GaroonCat::VERSION
  end
end
