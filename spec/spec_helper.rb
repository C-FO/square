require 'simplecov'
SimpleCov.coverage_dir(File.join(ENV.fetch('CIRCLE_ARTIFACTS', 'public'), 'coverage'))
SimpleCov.start do
  %w[vendor/ spec/].each { |dir| add_filter(dir) }
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'square'
require 'webmock'
require 'pry'

include WebMock::API

WebMock.disable_net_connect!(allow: 'coveralls.io')

def endpoint_for(api_name)
  case api_name
  when :connect
    Square::Connect::Default::ENDPOINT
  else
    ''
  end
end

def a_get(api_name, path)
  a_request(:get, endpoint_for(api_name) + path)
end

def a_post(api_name, path)
  a_request(:post, endpoint_for(api_name) + path)
end

def a_put(api_name, path)
  a_request(:put, endpoint_for(api_name) + path)
end

def a_delete(api_name, path)
  a_request(:delete, endpoint_for(api_name) + path)
end

def stub_get(api_name, path)
  stub_request(:get, endpoint_for(api_name) + path)
end

def stub_post(api_name, path)
  stub_request(:post, endpoint_for(api_name) + path)
end

def stub_put(api_name, path)
  stub_request(:put, endpoint_for(api_name) + path)
end

def stub_delete(api_name, path)
  stub_request(:delete, endpoint_for(api_name) + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file).read
end

RSpec.configure do |config|
  config.expose_dsl_globally = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
