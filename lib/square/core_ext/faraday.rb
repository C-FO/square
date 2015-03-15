require 'faraday'

module Faraday
  class Request::OAuth2 < Middleware

    def call(env)
      env[:request_headers]['Authorization'] ||= "Bearer #{@access_token}"
      @app.call(env)
    end

    def initialize(app, access_token)
      @app, @access_token = app, access_token
    end

  end
end

Faraday.register_middleware :request, square_oauth2: -> { Faraday::Request::OAuth2 }
