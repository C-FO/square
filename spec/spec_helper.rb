require 'simplecov'
SimpleCov.coverage_dir(File.join(ENV.fetch('CIRCLE_ARTIFACTS', 'public'), 'coverage'))
SimpleCov.start do
  %w[vendor/ spec/].each {|dir| add_filter(dir) }
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'square'
require 'pry'

def fixture_path
  File.expand_path('fixtures', __dir__)
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