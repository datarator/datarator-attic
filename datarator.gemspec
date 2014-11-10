# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datarator/version'



Gem::Specification.new do |spec|
  spec.name          = "datarator"
  spec.version       = Datarator::VERSION
  spec.authors       = ["Peter Butkovic"]
  spec.email         = ["butkovic@gmail.com"]
  spec.summary       = %q{Stateless DATA geneRATOR.}
  spec.description   = %q{DATA geneRATOR with: web UI and HTTP based JSON API}
  spec.homepage      = "https://github.com/datarator/datarator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.executables   = ['datarator']
  spec.default_executable = 'datarator'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

	# let's get notified on test runs
	spec.add_development_dependency "rspec"
	spec.add_development_dependency "guard"
	spec.add_development_dependency "guard-rspec"
	# anyone running mac out there?
	spec.add_development_dependency "rspec-nc"
	spec.add_development_dependency "pry"
	spec.add_development_dependency "pry-remote"
	spec.add_development_dependency "pry-nav"

	spec.add_development_dependency "coveralls"

	spec.add_development_dependency "faker"

	spec.add_development_dependency "json"

	spec.add_development_dependency "liquid"

	spec.add_development_dependency "sinatra"

	spec.add_development_dependency "rack-test"

	spec.add_development_dependency "ruby-prof"

end
