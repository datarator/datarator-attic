# speed up: http://stackoverflow.com/questions/25141231/ruby-guard-watch-is-behaving-really-slow
ignore([%r{^ui/*}])

# see: https://github.com/guard/guard-rspec
guard :rspec, cmd: 'bundle exec rspec' do
	watch(%r{^spec/.+_spec\.rb$})
	watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
	watch('spec/spec_helper.rb')  { "spec" }
end
