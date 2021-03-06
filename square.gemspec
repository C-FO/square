lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'square/version'

Gem::Specification.new do |spec|
  spec.name          = 'square'
  spec.version       = Square::Version
  spec.authors       = ['Ryu Yokoji', 'Ryota Ikezawa']
  spec.email         = ['yokoji@freee.co.jp', 'ikezawa-ryota@freee.co.jp']
  spec.description   = %q{A Ruby interface to the Square API.}
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/C-FO/square'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3.4'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'faraday', '~> 0.12.2'
  spec.add_dependency 'faraday_middleware', '~> 0.13.1'
  spec.add_dependency 'simple_oauth'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'pry-byebug', '~> 3.9'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rspec_junit_formatter'
  spec.add_development_dependency 'coveralls'
end
