require 'garoon-cat/version'
require 'garoon-cat/client'
require 'garoon-cat/service'
require 'rexml/document'
require 'active_support/core_ext/string/inflections'
require 'uri'

class GaroonCat

  # @return [URI]
  attr_reader :uri

  # @return [Hash<Symbol => GaroonCat::Service>]
  attr_reader :services

  # @param uri [URI, String] URI to WSDL
  # @param security [Hash] WS-Security
  # @return [GaroonCat]
  def self.setup(uri:, security:{username:nil, password:nil})
    client = GaroonCat::Client.new(security:security)
    uri = uri.kind_of?(URI) ? uri : URI.parse(uri.to_s)
    services = {}
    doc = REXML::Document.new(client.get(uri))
    REXML::XPath.match(doc, '/definitions/service').each do |service|
      name = service.attribute('name').value
      key = name.camelize.sub(/Service$/, '').underscore.to_sym
      location = URI.parse(service.elements['port/soap12:address'].attribute('location').value)
      services[key] = GaroonCat::Service.new(client:client, name:name, uri:location)
    end
    new(client:client, uri:uri, services:services)
  end

  # @param client [GaroonCat::Client]
  # @param uri [URI]
  # @param services [Hash<Symbol => GaroonCat::Service>]
  def initialize(client:, uri:, services:)
    @client = client
    @uri = uri
    @services = services
  end
  private_class_method :new

  # @param key [Symbol, String]
  # @return [GaroonCat::Service]
  def service(key)
    @services[key]
  end

end
