begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec do |t|
    t.rspec_opts = "--format=documentation --color"
  end

  namespace :test do
    desc "Run RSpec examples with code coverage analysis"
    task :coverage => %w(spec) do
      ENV['COVERAGE'] = 'true'
      Rake::Task['spec'].invoke
    end
  end

  desc "Run Ruby and JavaScript code examples"
  task :test => %w(spec konacha:run)
rescue LoadError;end
