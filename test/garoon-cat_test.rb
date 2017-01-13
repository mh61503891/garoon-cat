require 'test_helper'

class GaroonCat::Test < Minitest::Test

  @@garoon = GaroonCat.setup({
    uri: ENV['URI'],
    security: {
      username: ENV['USERNAME'],
      password: ENV['PASSWORD']
    }
  })

  def test_setup
    assert_no_error { @@garoon }
  end

  def test_services
    assert(@@garoon.services.kind_of?(Enumerable))
    assert(!@@garoon.services.empty?)
  end

  def test_service
    @@garoon.services.keys.each do |key|
      assert(@@garoon.service(key).instance_of?(GaroonCat::Service))
    end
  end

  def test_service_base_get_organization_versions
    assert(@@garoon.service(:base).get_organization_versions().instance_of?(Hash))
  end

  def test_service_base_get_user_versions
    assert(@@garoon.service(:base).get_user_versions().instance_of?(Hash))
  end

  def test_service_login_logout
    assert_no_error {
      garoon = GaroonCat.setup(uri:ENV['URI'])
      garoon.service(:util).login(login_name:ENV['USERNAME'], password:ENV['PASSWORD'])
      garoon.service(:base).get_user_versions()
      garoon.service(:util).logout
    }
  end

end
