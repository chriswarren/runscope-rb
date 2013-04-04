# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'runscope/version'

Gem::Specification.new do |spec|
  spec.name          = "runscope"
  spec.version       = Runscope::VERSION
  spec.authors       = ["Chris Warren"]
  spec.email         = ["chris@expectless.com"]
  spec.description   = %q{Easy setup to pipe specified HTTP traffic through Runscope}
  spec.summary       = %q{Easy setup to pipe specified HTTP traffic through Runscope}
  spec.homepage      = "http://github.com/chriswarren/runscope"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~>2.13.0"
  spec.add_development_dependency "fakeweb", "~> 1.3.0"
end
