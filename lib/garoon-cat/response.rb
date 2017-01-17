require 'rexml/document'
require 'xmlsimple'

class GaroonCat::Response

  def initialize(source)
    @source = source
    @doc = REXML::Document.new(source)
    if @doc.elements['//returns']
      @params = XmlSimple.xml_in(@doc.elements['//returns'].to_s)
    else
      raise @doc.elements['/soap:Envelope/soap:Body/soap:Fault/soap:Detail/cause'].text.strip
    end
  end

  def to_params
    @params
  end

end
