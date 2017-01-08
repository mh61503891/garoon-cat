require 'rexml/document'
require 'time'

module GaroonCat
  class Request

    def initialize(action:, username:nil, password:nil, locale:'jp', created_at:Time.now, expires_at:Time.now)
      @action = action
      @username = username
      @password = password
      @locale = locale
      @created_at = created_at
      @expires_at = expires_at
    end

    def header_action
      action = REXML::Element.new('Action')
      action.add_text(@action)
      action
    end

    def header_security
      security = REXML::Element.new('Security')
      if @username && @password
        username_token = REXML::Element.new('UsernameToken')
        username_token.add_element('Username').add_text(@username)
        username_token.add_element('Password').add_text(@password)
        security.add_element(username_token)
      end
      security
    end

    def header_timestamp
      timestamp = REXML::Element.new('Timestamp')
      timestamp.add_element('Created').add_text(@created_at.iso8601)
      timestamp.add_element('Expires').add_text(@expires_at.iso8601)
      timestamp
    end

    def header_locale
      locale = REXML::Element.new('locale')
      locale.add_text(@locale)
      locale
    end

    def body_action
      parameters = REXML::Element.new('Parameters')
      action = REXML::Element.new(@action)
      action.add_element(parameters)
      action
    end

    def doc
      # header
      header = REXML::Element.new('soap:Header')
      header.add_element(header_action)
      header.add_element(header_security)
      header.add_element(header_timestamp)
      header.add_element(header_locale)
      # body
      body = REXML::Element.new('soap:Body')
      body.add_element(body_action)
      # envelope
      envelope = REXML::Element.new('soap:Envelope')
      envelope.add_namespace('soap', 'http://www.w3.org/2003/05/soap-envelope')
      envelope.add_element(header)
      envelope.add_element(body)
      # doc
      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')
      doc.add_element(envelope)
      doc
    end

    def to_s
      doc.to_s
    end

  end
end
