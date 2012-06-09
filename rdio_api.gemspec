# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rdio_api/version"

Gem::Specification.new do |s|
  s.name        = "rdio_api"
  s.version     = RdioApi::VERSION
  s.authors     = ["Anil"]
  s.homepage    = "http://github.com/anilv/rdio_api"
  s.summary     = %q{A Ruby wrapper for the Rdio API}
  s.description = %q{A Ruby wrapper for the Rdio API}
  
  s.add_development_dependency 'rake', '~> 0.9'
  s.add_development_dependency 'rspec', '~> 2.6'
  s.add_development_dependency 'webmock', '~>1.6'
  s.add_development_dependency 'oauth', '~>0.4.5'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'guard-rspec'
  
  s.add_runtime_dependency 'faraday', '~> 0.6.1'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.6.5'
  s.add_runtime_dependency 'hashie', '~> 1.2.0'
  s.add_runtime_dependency 'multi_json', '~> 1.0.3'
  s.add_runtime_dependency 'simple_oauth', '~> 0.1.5'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end