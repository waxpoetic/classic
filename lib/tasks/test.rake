begin
  require 'rspec/core/rake_task'

  namespace :test do
    desc "Run tests for the Ruby on Rails backend"
    RSpec::Core::RakeTask.new :backend do |t|
      t.rspec_opts = "--format=documentation --color"
    end

    desc "Run tests for the Ember.js frontend"
    task :frontend => %w(konacha:run)

    desc "Run backend tests with code coverage analysis"
    task :coverage do
      ENV['COVERAGE'] = 'true'
      puts "Generating coverage report after test.."
      Rake::Task['spec'].invoke
    end
  end

  desc "Run all tests"
  task :test => %w(spec konacha:run)
rescue LoadError;end
