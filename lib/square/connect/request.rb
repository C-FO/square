require 'faraday'
require 'faraday_middleware'
require 'square/request'
require 'square/response'
require 'square/error/client_error'
require 'square/error/server_error'
require 'square/connect/configuration'

module Square
  module Connect
    module Request
      include Square::Request

    private

      # Returns a Faraday::Connection object
      #
      # @return [Faraday::Connection]
      def connection
        return @connection if @connection

        @connection = Faraday.new(Square::Connect.endpoint) do |conn|
          conn.request :oauth2, @access_token if @access_token
          conn.request :json
          conn.use Square::Response::RaiseError, Square::Error::ClientError
          conn.response :json, content_type: /\bjson$/
          conn.use Square::Response::RaiseError, Square::Error::ServerError
          conn.adapter Faraday.default_adapter
        end
      end

    end
  end
end
