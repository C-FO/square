require 'simplecov'
SimpleCov.coverage_dir(File.join(ENV.fetch('CIRCLE_ARTIFACTS', 'public'), 'coverage'))
SimpleCov.start do
  %w[vendor/ spec/].each { |dir| add_filter(dir) }
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'square'
require 'webmock'
require 'webmock/rspec'
require 'pry'
require 'securerandom'
require 'active_support/core_ext/hash'

include WebMock::API

if ENV['COVERALLS_REPO_TOKEN']
  # Add coveralls setting
  require 'coveralls'
  Coveralls.wear_merged!('rails')
end

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
  config.define_derived_metadata do |m|
    m[:aggregate_failures] = true unless m.key?(:aggregate_failures)
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
