require 'test_helper'
require 'faker'

class GaroonCat::RequestTest < Minitest::Test

  def params
    {
      header: {
        action: 'Test',
        security: {
          username_token: {
            username: Faker::Internet.user_name,
            password: Faker::Internet.password
          }
        },
        timestamp: {
          created: Time.now,
          expires: Time.now,
        },
        locale: Faker::Address.country_code.downcase
      },
      body: {
        parameters: nil
      }
    }
  end

  def request
    GaroonCat::Request.new(params)
  end

  def test_new
    assert_no_error {
      assert(request)
    }
  end

  def test_to_s
    assert_no_error {
      require 'rexml/document'
      REXML::Document.new(request.to_s)
    }
  end

end
