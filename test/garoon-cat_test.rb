require 'test_helper'

class GaroonCat::Test < Minitest::Test

  @@garoon = GaroonCat.setup({
    uri: ENV['URI'],
    username: ENV['USERNAME'],
    password: ENV['PASSWORD']
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

  def organization_ids
    @@org_versions ||= @@garoon.service(:base).get_organization_versions()['organization_item'].map{ |e| e['id'] }
  end

  def user_ids
    @@user_versions ||= @@garoon.service(:base).get_user_versions()['user_item'].map{ |e| e['id'] }
  end

  def organizations
    @@organizations ||= @@garoon.service(:base).get_organizations_by_id(organization_id:organization_ids)
  end

  def users
    @@users ||= @@garoon.service(:base).get_users_by_id(user_id:organization_ids)
  end

  def test_organization_ids
    assert_instance_of(Array, organization_ids)
  end

  def test_user_ids
    assert_instance_of(Array, user_ids)
  end

  def test_organizations
    assert_instance_of(Hash, organizations)
  end

  def test_users
    assert_instance_of(Hash, users)
  end

end
