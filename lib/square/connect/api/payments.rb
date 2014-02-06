require 'square/utils'
require 'square/connect/payment'

module Square
  module Connect
    module API
      module Payments
        include Square::Utils::API

        # Returns a payment if authentication was successful, otherwise raises {Square::Error::Unauthorized}
        #
        # @see https://connect.squareup.com/docs/connect/endpoints/get-paymentid
        # @note Authentication Required
        # @raise [Square::Error::Unauthorized] Error raised when supplied user credentials are invalid.
        # @return [Square::Connect::Payment]
        # @param payment_id [String]
        # @param merchant_id [String]
        def payment(payment_id, merchant_id = 'me')
          object_from_response(Square::Connect::Payment, :get, "/#{merchant_id}/payments/#{payment_id}")
        end

        # Returns the list of payments if authentication was successful, otherwise raises {Square::Error::Unauthorized}
        #
        # @see https://connect.squareup.com/docs/connect/endpoints/get-payments
        # @note Authentication Required
        # @raise [Square::Error::Unauthorized] Error raised when supplied user credentials are invalid.
        # @return [Square::Connect::Payment]
        # @param options [Hash]
        # @param merchant_id [String]
        def payments(options = {}, merchant_id = 'me')
          objects_from_response(Square::Connect::Payment, :get, "/#{merchant_id}/payments", options)
        end

      end
    end
  end
end
