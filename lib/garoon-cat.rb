require 'garoon-cat/version'
require 'garoon-cat/service'
require 'httpclient'
require 'rexml/document'
require 'active_support/core_ext/string/inflections'
require 'uri'

class GaroonCat

  def self.setup(uri:)
    client = HTTPClient.new
    services = {}
    doc = REXML::Document.new(client.get(uri).body)
    REXML::XPath.match(doc, '/definitions/service').each do |service|
      name = service.attribute('name').value
      key = name.camelize.sub(/Service$/, '').underscore.to_sym
      uri = URI.parse(service.elements['port/soap12:address'].attribute('location').value)
      services[key] = GaroonCat::Service.new(client:client, name:name, uri:uri)
    end
    new(client:client, uri:uri, services:services)
  end

  def initialize(client:, uri:, services:)
    @client = client
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
