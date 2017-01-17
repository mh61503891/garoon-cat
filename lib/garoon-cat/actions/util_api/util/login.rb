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
      # puts request_body
      response_body = @service.client.post(@service.uri, request_body)
      response = GaroonCat::Response.new(response_body)
      return response.to_params
    end
  end
end; end; end; end



# def process_response(service, xml)
#   response = GaroonCat::Response.parse(xml)
#   service.cookie = response['cookie'][0].strip
# end
#
# end; end; end; end; end

# アクションのキャッシュが必要?

# require 'active_support/core_ext/hash/conversions'
    # # request
    # @service_request = @service.process_request(self, {
    #   parameters: args.empty? ? [] : args[0]
    # })
    # define_method('hoge'){}

#   def initialize(uri)
#     c = GaroonCat::Client.create(uri:uri)
#     # c.services()
#     # @uri = uri
#     # @cookie = nil
#     # get_hoho()

#     attr_accessor :cookie
#
#       @http_request = Net::HTTP::Post.new(@uri.request_uri, {'Cookie':@cookie})
#       @http_request.body = @service_request.to_s
#       # http
#       @http = Net::HTTP.new(@uri.host, @uri.port)
#       @http.use_ssl = true
#       @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
#       # @http.set_debug_output $stderr
