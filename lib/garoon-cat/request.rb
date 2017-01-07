require 'rexml/document'

module GaroonCat
  class Request
    def to_s
      param_action = 'Hello'
      param_username = 'testuser'
      param_password = 'testpassword'

      doc = REXML::Document.new
      doc << REXML::XMLDecl.new('1.0', 'UTF-8')
      soap_envelope = REXML::Element.new('soap:Envelope')
      soap_envelope.add_attribute('xmlns:soap', 'http://www.w3.org/2003/05/soap-envelope')
      soap_header = REXML::Element.new('soap:Header')
      action = REXML::Element.new('Action')
      action.add_text(param_action)
      security = REXML::Element.new('Security')
      username_token = REXML::Element.new('UsernameToken')
      username = REXML::Element.new('Username')
      username.add_text(param_username)
      username_token.add_element(username)
      password = REXML::Element.new('Password')
      password.add_text(param_password)
      username_token.add_element(password)
      timestamp = REXML::Element.new('Timestamp')
      created = REXML::Element.new('Created')
      created.add_text('2010-08-12T14:45:00Z')
      expires = REXML::Element.new('Expires')
      expires.add_text('2037-08-12T14:45:00Z')
      timestamp.add_element(created)
      timestamp.add_element(expires)
      locale = REXML::Element.new('locale')
      locale.add_text('jp')
      security.add_element(username_token)
      soap_header.add_element(action)
      soap_header.add_element(security)
      soap_header.add_element(timestamp)
      soap_header.add_element(locale)
      soap_body = REXML::Element.new('soap:Body')
      s_method = REXML::Element.new('BaseGetApplicationStatus')
      parameters = REXML::Element.new('Parameters')
      s_method.add_element(parameters)
      soap_body.add_element(s_method)
      soap_envelope.add_element(soap_header)
      soap_envelope.add_element(soap_body)
      doc.add_element(soap_envelope)
      pretty_formatter = REXML::Formatters::Pretty.new
      output = StringIO.new
      pretty_formatter.write(doc, output)
      output.string
    end
  end
end
