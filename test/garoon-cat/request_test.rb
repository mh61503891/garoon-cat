require 'test_helper'
require 'faker'

class GaroonCat::RequestTest < Minitest::Test

  def params
    {
      action:Faker::App.name,
      username:Faker::Internet.user_name,
      password:Faker::Internet.password,
      locale:Faker::Address.country_code.downcase,
      created_at:Time.now,
      expires_at:Time.now,
    }
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
