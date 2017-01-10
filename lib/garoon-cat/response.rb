require 'rexml/document'
require 'xmlsimple'

module GaroonCat
  class Response

    def self.parse(source)
      @source = source
      @doc = REXML::Document.new(source)
      if @doc.elements['//returns']
        return XmlSimple.xml_in(@doc.elements['//returns'].to_s)
      end
      raise @doc.elements['/soap:Envelope/soap:Body/soap:Fault/soap:Detail/cause'].text.strip
    end

  end
end
