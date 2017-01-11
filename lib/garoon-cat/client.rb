require 'httpclient'
require 'uri'
require 'active_support/core_ext/string/inflections'
require 'garoon-cat/service'

class GaroonCat::Client

  def self.setup(uri:)
    services = {}
    doc = REXML::Document.new(HTTPClient.get(uri).body)
    REXML::XPath.match(doc, '/definitions/service').each do |service|
      name = service.attribute('name').value
      key = name.camelize.sub(/Service$/, '').underscore.to_sym
      uri = service.elements['port/soap12:address'].attribute('location').value
      services[key.to_sym] = GaroonCat::Service.new(name:name, uri:URI.parse(uri))
    end
    new(uri:uri, services:services)
  end

  def initialize(uri:, services:)
    @uri = uri
    @services = services
  end

  def services
    @services.keys
  end

  def service(key)
    @services[key]
  end

end
