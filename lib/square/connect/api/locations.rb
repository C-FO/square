require 'square/utils/api'
require 'square/connect/model/location'

module Square
  module Connect
    module API
      module Locations
        include Square::Utils::API

        # Provides details for a business' locations, including their IDs.
        #
        # @see https://docs.connect.squareup.com/api/connect/v1#get-locations
        # @note Authentication Required
        # @raise [Square::Error::Unauthorized] Error raised when supplied user credentials are invalid.
        # @return [Square::Connect::Locations]
        def locations
          response = objects_from_response(Square::Connect::Location, :get, "/me")
          response[:objects]          
        end

      end
    end
  end
end
