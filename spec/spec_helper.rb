# Load gem bundle
require 'bundler/setup'

# Begin code coverage analysis
if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter 'vendor'
  end
  SimpleCov.coverage_dir 'doc/coverage'
end

# Load test framework
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Load additional modules
require 'vcr'
require 'pry'
require 'capybara'
require 'capybara/poltergeist'
require 'email_spec'
#require 'resque_spec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Always include Devise helpers in controller tests
  config.include Devise::TestHelpers, :type => :controller
  config.include TestUsers

  config.include EmailSpec::Helpers, :type => :mailer
  config.include EmailSpec::Matchers, :type => :mailer
end

# Upload files locally when testing
CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
end

# HTTP mocking
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.ignore_request do |request|
    URI(request.uri).path =~ %r(v1/tokens)
  end
end

# Use PhantomJS to run Capybara specs
Capybara.javascript_driver = :poltergeist
