require 'square/utils/api'
require 'square/connect/model/refund'

module Square
  module Connect
    module API
      module Refunds
        include Square::Utils::API

        # Returns the list of refunds if authentication was successful, otherwise raises {Square::Error::Unauthorized}
        #
        # @see https://connect.squareup.com/docs/connect/endpoints/get-refunds
        # @note Authentication Required
        # @raise [Square::Error::Unauthorized] Error raised when supplied user credentials are invalid.
        # @return [Square::Connect::Refund]
        # @param options
        # @param merchant_id [String]
        def refunds(options = {}, merchant_id = 'me')
          response = objects_from_response(Square::Connect::Refund, :get, "/#{merchant_id}/refunds", options)
          refunds = response[:objects]

          while response[:next_link_params] && (options[:limit].nil? || (options[:limit] && options[:limit] > refunds.size))
            response = objects_from_response(Square::Connect::Refund, :get, "/#{merchant_id}/refunds?#{response[:next_link_params]}")
            refunds += response[:objects]
          end

          refunds
        end

      end
    end
  end
end
