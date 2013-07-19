# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'runscope'

Gem::Specification.new do |spec|
  spec.name          = "runscope-rb"
  spec.version       = Runscope::VERSION
  spec.authors       = ["Chris Warren"]
  spec.email         = ["chris@expectless.com"]
  spec.description   = %q{Start using Runscope to monitor your API traffic in minutes}
  spec.summary       = %q{Start using Runscope to monitor your API traffic in minutes}
  spec.homepage      = "http://github.com/chriswarren/runscope-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~>2.13.0"
  spec.add_development_dependency "webmock", "~> 1.13.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "debugger", "~> 1.6.1"
  spec.add_development_dependency "fuubar", "~> 1.1.1"
end
