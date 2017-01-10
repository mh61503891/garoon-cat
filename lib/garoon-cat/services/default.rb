module GaroonCat
  module Services
    class Default

      def process_request(service, params)
        GaroonCat::Request.new(params)
      end

      def process_response(service, xml)
        GaroonCat::Response.parse(xml)
      end

    end
  end
end
