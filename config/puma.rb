workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
environment ENV['RACK_ENV'] || 'development'

workdir = if ENV['RACK_ENV'] == 'development'
            Dir.pwd
          else
            '/usr/local/share/datarator'
          end

# Set up socket location
if ENV['RACK_ENV'] == 'production'
  bind 'unix:///tmp/unicorn.sock'
else
  port ENV['PORT'] || 9292
end

# Logging
stdout_redirect "#{workdir}/log/puma.stdout.log", "#{workdir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{workdir}/tmp/puma.pid"
state_path "#{workdir}/tmp/puma.state"
