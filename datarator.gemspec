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
	spec.description   = %q{DATA geneRATOR with: HTTP based JSON API}
	spec.homepage      = "https://github.com/datarator/datarator"
	spec.license       = "MIT"

	spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md)
	spec.executables   = ['datarator']
	spec.default_executable = 'datarator'
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	# spec.add_development_dependency "bundler", "~> 1.7"
	spec.add_development_dependency "rake", "~> 10.0"
	spec.add_development_dependency "rspec", "~> 3.4"
	spec.add_development_dependency "guard", "~> 2.13"
	spec.add_development_dependency "guard-rspec", "~> 4.6"
	# anyone running mac out there?
	spec.add_development_dependency "rspec-nc", "~> 0.2.1"

	spec.add_development_dependency "pry", "~> 0.10.3"
	spec.add_development_dependency "pry-remote", "~> 0.1.8"
	spec.add_development_dependency "pry-nav", "~> 0.2.4"
	spec.add_development_dependency "coveralls", "~> 0.8.13"
	spec.add_development_dependency "rack-test", "~> 0.6.3"
	spec.add_development_dependency "ruby-prof", "~> 0.15.9"

	spec.add_runtime_dependency "faker", "~> 1.6.3"
	spec.add_runtime_dependency "regexp-examples", "~> 1.2"
	spec.add_runtime_dependency "json", "~> 1.8"
	# not in use (for now)
	# spec.add_dependency "liquid", "~> 3.0.3"
	spec.add_runtime_dependency "sinatra", "~> 1.4"
	#
	# let's use puma (as heroku guys recommend)
	# spec.add_runtime_dependency "unicorn", "~> 5.0"
	spec.add_runtime_dependency "puma", "~> 3.2"
end
