begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec

  desc "Run Ruby and JavaScript code examples"
  task :test => %w(spec konacha:run)
rescue LoadError;end
