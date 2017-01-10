module GaroonCat; module Services; module UTIL_API; module UTIL; class Login

def process_request(service, params)
  GaroonCat::Request.new(params)
end

def process_response(service, xml)
  response = GaroonCat::Response.parse(xml)
  service.cookie = response['cookie'][0].strip
end

end; end; end; end; end
