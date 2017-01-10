require 'test_helper'
require 'faker'

class GaroonCat::ServiceTest < Minitest::Test

  def params
    {
      endpoint:ENV['ENDPOINT'],
      username:ENV['USERNAME'],
      password:ENV['PASSWORD']
    }
  end

  def test_util_login_and_logout
    service = GaroonCat::Service.new({
      endpoint:ENV['ENDPOINT'],
      prefix:'util_api',
      name:'util'
    })
    service.login(login_name:ENV['USERNAME'], password:ENV['PASSWORD'])
    service.logout()
  end

  def test_base_get_application_status
    GaroonCat::Service.new(params.merge({
      prefix:'cbpapi',
      name:'base',
    })).get_application_status()
  end

  def test_base_get_users_by_id
    GaroonCat::Service.new(params.merge({
      prefix:'cbpapi',
      name:'base',
    })).get_users_by_id(user_id:[1, 2, 3])
  end

  def test_base_get_user_versions
    GaroonCat::Service.new(params.merge({
      prefix:'cbpapi',
      name:'base',
    })).get_user_versions()
  end

  def test_base_get_organization_versions
    GaroonCat::Service.new(params.merge({
      prefix:'cbpapi',
      name:'base',
    })).get_organization_versions()
  end

  # .tap{ |e| require 'awesome_print'; ap e }

end
