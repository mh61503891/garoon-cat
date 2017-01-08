require 'rexml/document'

module GaroonCat
  class Request

    def initialize
      @action = 'BaseGetApplicationStatus'
      @username = ENV['USERNAME']
      @password = ENV['PASSWORD']
      @locale = 'jp'
    end

    def security
      security = REXML::Element.new('Security')
      if @username && @password
        username_token = REXML::Element.new('UsernameToken')
        username_token.add_element('Username').add_text(@username)
        username_token.add_element('Password').add_text(@password)
        security.add_element(username_token)
      end
      security
    end

    def locale
      locale = REXML::Element.new('locale')
      locale.add_text(@locale)
      locale
    end

    def to_s
      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')
      soap_envelope = REXML::Element.new('soap:Envelope')
      soap_envelope.add_namespace('soap', 'http://www.w3.org/2003/05/soap-envelope')
      soap_header = REXML::Element.new('soap:Header')
      action = REXML::Element.new('Action')
      action.add_text(@action)
      timestamp = REXML::Element.new('Timestamp')
      created = REXML::Element.new('Created')
      created.add_text('2010-08-12T14:45:00Z')
      expires = REXML::Element.new('Expires')
      expires.add_text('2037-08-12T14:45:00Z')
      timestamp.add_element(created)
      timestamp.add_element(expires)
      soap_header.add_element(action)
      soap_header.add_element(security)
      soap_header.add_element(timestamp)
      soap_header.add_element(locale)
      soap_body = REXML::Element.new('soap:Body')
      s_method = REXML::Element.new(@action)
      parameters = REXML::Element.new('Parameters')
      s_method.add_element(parameters)
      soap_body.add_element(s_method)
      soap_envelope.add_element(soap_header)
      soap_envelope.add_element(soap_body)
      doc.add_element(soap_envelope)
      doc.to_s
    end
  end
end
