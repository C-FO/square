require 'square/utils/api'
require 'square/connect/model/settlement'

module Square
  module Connect
    module API
      module Settlements
        include Square::Utils::API

        # Returns a settlement if authentication was successful, otherwise raises {Square::Error::Unauthorized}
        #
        # @see https://connect.squareup.com/docs/connect/endpoints/get-settlementid
        # @note Authentication Required
        # @raise [Square::Error::Unauthorized] Error raised when supplied user credentials are invalid.
        # @return [Square::Connect::Settlement]
        # @param settlement_id [String]
        # @param merchant_id [String]
        def settlement(settlement_id, merchant_id = 'me')
          object_from_response(Square::Connect::Settlement, :get, "/#{merchant_id}/settlements/#{settlement_id}")
        end

        # Returns the list of settlements if authentication was successful, otherwise raises {Square::Error::Unauthorized}
        #
        # @see https://connect.squareup.com/docs/connect/endpoints/get-settlements
        # @note Authentication Required
        # @raise [Square::Error::Unauthorized] Error raised when supplied user credentials are invalid.
        # @return [Square::Connect::Settlement]
        # @param options [Hash]
        # @param merchant_id [String]
        def settlements(options = {}, merchant_id = 'me')
          response = objects_from_response(Square::Connect::Settlement, :get, "/#{merchant_id}/settlements", options)
          settlements = response[:objects]

          while response[:next_link_params] && (options[:limit].nil? || (options[:limit] && options[:limit] > settlements.size))
            response = objects_from_response(Square::Connect::Settlement, :get, "/#{merchant_id}/settlements?#{response[:next_link_params]}")
            settlements += response[:objects]
          end

          settlements

        end

      end
    end
  end
end
