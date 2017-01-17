require 'active_support/core_ext/string/inflections'
require 'garoon-cat/request'
require 'garoon-cat/response'

class GaroonCat::Action

  # @param service [GaroonCat::Service]
  # @param key [Symbol]
  # @return [GaroonCat::Action]
  def self.create(service:, key:)
    segments = {
      prefix:service.uri.path.split('/')[-3],
      service:service.uri.path.split('/')[-2],
      action:key.to_s,
    }
    require(class_path(segments))
    class_name(segments).constantize.new(service:service, key:key)
  rescue LoadError => e
    $stderr.puts e if $DEBUG
    $stderr.puts 'default fallback file -- garoon-cat/action' if $DEBUG
    self.new(service:service, key:key)
  end

  # @param segments [Hash<Symbol => String>]
  # @return [String] the path for require
  def self.class_path(segments)
    path = %w(garoon-cat actions)
    path << segments[:prefix]
    path << segments[:service]
    path << segments[:action]
    path.join('/')
  end
  private_class_method :class_path

  # @param segments [Hash<Symbol => String>]
  # @return [String] the class name
  def self.class_name(segments)
    name = %w(GaroonCat Actions)
    name << segments[:prefix].upcase
    name << segments[:service].upcase
    name << segments[:action].camelcase
    name.join('::')
  end
  private_class_method :class_name

  # @param service [GaroonCat::Service]
  # @param key [Symbol]
  def initialize(service:, key:)
    @service = service
    @key = key
  end

  # @param *args [Object] arguments of this action
  # @return [Object] return values of this action
  def execute(*args)
    request = GaroonCat::Request.new(default_params.merge({
    }))
    request_body = request.to_s
    response_body = @service.client.post(@service.uri, request_body)
    response = GaroonCat::Response.new(response_body)
    return response.to_params
  end

  # @return [Hash] the default parameters of this service and its actions
  def default_params
    {
      header: {
        action: @service.name.sub(/Service$/, @key.to_s.camelize),
        security: {
          username_token: {
            username: @service.client.username,
            password: @service.client.password
          }
        },
        timestamp: {
          created: Time.now,
          expires: Time.now,
        },
        locale: 'jp'
      },
      body: {
        parameters: nil
      }
    }
  end

end
