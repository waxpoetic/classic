begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec do
    t.rcov = true
    t.rspec_opts = "--format=documentation --color"
  end

  desc "Run Ruby and JavaScript code examples"
  task :test => %w(spec konacha:run)
rescue LoadError;end
