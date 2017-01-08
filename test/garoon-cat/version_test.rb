require 'test_helper'

class GaroonCat::VersionTest < Minitest::Test

  def test_version
    refute_nil GaroonCat::VERSION
  end

end
