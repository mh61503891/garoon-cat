require 'rexml/document'
require 'time'

class GaroonCat::Request

  def initialize(params)
    @params = params
  end

  def header_action
    action = REXML::Element.new('Action')
    action.add_text(@params.dig(:header, :action).to_s)
    action
  end

  def header_security
    security = REXML::Element.new('Security')
    username = @params.dig(:header, :security, :username_token, :username)
    password = @params.dig(:header, :security, :username_token, :password)
    if username && password
      username_token = REXML::Element.new('UsernameToken')
      username_token.add_element('Username').add_text(username)
      username_token.add_element('Password').add_text(password)
      security.add_element(username_token)
    end
    security
  end

  def header_timestamp
    timestamp = REXML::Element.new('Timestamp')
    timestamp.add_element('Created').add_text(@params.dig(:header, :timestamp, :created).iso8601)
    timestamp.add_element('Expires').add_text(@params.dig(:header, :timestamp, :expires).iso8601)
    timestamp
  end

  def header_locale
    locale = REXML::Element.new('locale')
    locale.add_text(@params.dig(:header, :locale))
    locale
  end

  def header
    header = REXML::Element.new('soap:Header')
    header.add_element(header_action)
    header.add_element(header_security)
    header.add_element(header_timestamp)
    header.add_element(header_locale)
    header
  end

  # @todo fix: handling parameters' type
  def body_action_parameters
    parameters = REXML::Element.new('parameters')
    target = @params.dig(:body, :parameters)
    case target
    when Hash
      target.each do |key, value|
        parameters.add_element(key.to_s).add_text(value.to_s)
      end
    end
    # @params.dig(:body, :parameters)&.each do |key, value|
    #   case value
    #   when String
    #     parameters.add_element(key.to_s).add_text(value.to_s)
    #   when Array
    #     value.each do |e|
    #       parameters.add_element(key.to_s).add_text(e.to_s)
    #     end
    #   end
    # end
    parameters
  end

  def body_action
    action = REXML::Element.new(@params.dig(:header, :action).to_s)
    action.add_element(body_action_parameters)
    action
  end

  def body
    body = REXML::Element.new('soap:Body')
    body.add_element(body_action)
    body
  end

  def envelope
    envelope = REXML::Element.new('soap:Envelope')
    envelope.add_namespace('soap', 'http://www.w3.org/2003/05/soap-envelope')
    envelope.add_element(header)
    envelope.add_element(body)
    envelope
  end

  def doc
    doc = REXML::Document.new
    doc << REXML::XMLDecl.new('1.0', 'UTF-8')
    doc.add_element(envelope)
    doc
  end

  def to_s
    doc.to_s
  end

end
