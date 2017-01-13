require 'garoon-cat/action'

class GaroonCat::Service

  # @return [GaroonCat::Client]
  attr_reader :client

  # @return [String]
  attr_reader :name

  # @return [URI]
  attr_reader :uri

  # @param client [GaroonCat::Client]
  # @param name [String]
  # @param uri [URI]
  def initialize(client:, name:, uri:)
    @client = client
    @name = name
    @uri = uri
  end

  private

  # @param key [Symbol] the key of an action.
  # @return [GaroonCat::Action #execute]
  def action(key)
    @actions ||= {}
    @actions[key] ||= GaroonCat::Action.create(service:self, key:key)
  end

  def method_missing(key, *args)
    action(key).execute(args)
  end

end
