require 'garoon-cat/action'

class GaroonCat; class Actions; class UTIL_API; class UTIL
  class Login < GaroonCat::Action
    def execute(*args)
      request = GaroonCat::Request.new(default_params.merge({
        body:{
          parameters: args[0][0]
        }
      }))
      request_body = request.to_s
      response_body = @service.client.post(@service.uri, request_body)
      response = GaroonCat::Response.new(response_body)
      return response.to_params
    end
  end
end; end; end; end
