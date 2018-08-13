require 'faraday'
require 'square/error/bad_gateway'
require 'square/error/bad_request'
require 'square/error/forbidden'
require 'square/error/gateway_timeout'
require 'square/error/internal_server_error'
require 'square/error/not_acceptable'
require 'square/error/not_found'
require 'square/error/service_unavailable'
require 'square/error/unauthorized'

module Square
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        err = classify_error(env.status)
        raise err if err
      end

      def initialize(app, klass)
        @klass = klass
        super(app)
      end

      private

      def classify_error(http_status)
        case http_status
        when 400
          Square::Error::BadRequest
        when 401
          Square::Error::Unauthorized
        when 403
          Square::Error::Forbidden
        when 404
          Square::Error::NotFound
        when 406
          Square::Error::NotAcceptable
        when 500
          Square::Error::InternalServerError
        when 502
          Square::Error::BadGateway
        when 503
          Square::Error::ServiceUnavailable
        when 504
          Square::Error::GatewayTimeout
        end
      end
    end
  end
end
