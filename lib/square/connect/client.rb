require 'square/connect/api/locations'
require 'square/connect/api/bank_accounts'
require 'square/connect/api/merchants'
require 'square/connect/api/payments'
require 'square/connect/api/refunds'
require 'square/connect/api/settlements'
require 'square/connect/configuration'
require 'square/connect/request'

module Square
  module Connect
    class Client
      include Square::Connect::API::Locations
      include Square::Connect::API::BankAccounts
      include Square::Connect::API::Merchants
      include Square::Connect::API::Payments
      include Square::Connect::API::Refunds
      include Square::Connect::API::Settlements
      include Square::Connect::Configuration
      include Square::Connect::Request

      attr_accessor :access_token

      # Initializes a new Client object
      #
      # @param options [Hash] A customizable set of options.
      # @option oauth_token [String]
      # @option oauth_token_secret [String]
      # @return [Square::Client]
      def initialize(options={})
        @access_token = options[:access_token]

        # Set global keys
        Square::Connect::Configuration.keys.each do |key|
          instance_variable_set(:"@#{key}", options[key] || Square::Connect.instance_variable_get(:"@#{key}"))
        end

        self
      end
    end
  end
end
