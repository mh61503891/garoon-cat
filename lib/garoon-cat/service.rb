require 'garoon-cat/request'
require 'garoon-cat/response'
require 'active_support/core_ext/hash/conversions'

module GaroonCat
  class Service

    attr_accessor :cookie

    def initialize(params)
      @params = params
      @cookie = ''
    end

    def method_missing(name, *args)
      @service = get_service(prefix:@params[:prefix], name:@params[:name], action:name.to_s)
      @uri = get_uri(endpoint:@params[:endpoint], prefix:@params[:prefix], name:@params[:name])

      # request
      @service_request = @service.process_request(self, {
        created_at: @params[:created_at] || Time.now,
        expires_at: @params[:expires_at] || Time.now,
        action: @params[:name].camelcase + name.to_s.camelcase,
        locale: @params[:locale] || 'jp',
        username: @params[:username],
        password: @params[:password],
        parameters: args.empty? ? [] : args[0]
      })
      @http_request = Net::HTTP::Post.new(@uri.request_uri, {'Cookie':@cookie})
      @http_request.body = @service_request.to_s
      # http
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # @http.set_debug_output $stderr

      # response
      @http_response = @http.start{ |h| h.request(@http_request) }
      @service_response = @service.process_response(self, @http_response.body)
      return @service_response
    end

    private

    def get_uri(endpoint:, prefix:, name:)
      URI.parse("#{endpoint}/#{prefix}/#{name}/api?")
    end

    def get_service(prefix:, name:, action:)
      require(['garoon-cat', 'services', prefix, name, action.underscore].join('/'))
      ['GaroonCat', 'Services', prefix.upcase, name.upcase, action.camelcase].join('::').constantize.new
    rescue LoadError, NameError => e; $stderr.puts e
      require('garoon-cat/services/default')
      GaroonCat::Services::Default.new
    end

  end
end
