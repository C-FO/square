require 'faraday'

module Faraday
  class Request
    class SquareOauth2 < Middleware

      def call(env)
        env[:request_headers]['Authorization'] ||= "Bearer #{@access_token}"
        @app.call(env)
      end

      def initialize(app, access_token)
        @app, @access_token = app, access_token
      end
    end

    register_middleware square_oauth2: SquareOauth2
  end
end
