# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beeleads/version'

Gem::Specification.new do |spec|
  spec.name          = "beeleads"
  spec.version       = Beeleads::VERSION
  spec.authors       = ["Décio Ferreira"]
  spec.email         = ["decio.ferreira@decioferreira.com"]
  spec.description   = %q{A Ruby interface to the Beeleads API.}
  spec.summary       = %q{A Ruby interface to the Beeleads API.}
  spec.homepage      = "https://github.com/decioferreira/beeleads"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end
