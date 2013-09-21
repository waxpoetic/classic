begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec

  desc "Set up the test DB and run RSpec code examples"
  task :test => %w(db:test:prepare spec)
rescue LoadError;end
