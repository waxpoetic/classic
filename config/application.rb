require File.expand_path('../boot', __FILE__)

%w(
  active_record
  action_controller
  action_view
  action_mailer
  sprockets
).each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError;end
end

Bundler.require(*Rails.groups(:assets => %w(development test)))

module WaxPoetic
  class Application < Rails::Application
    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # Run in UTC time
    # config.time_zone = 'Central Time (US & Canada)'

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use strong_parameters for mass-assignment protection
    config.active_record.whitelist_attributes = false

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Don't init the app on assets:precompile
    config.assets.initialize_on_precompile = false

    # Use the development variant of Ember normally
    config.ember.variant = :development

    # Send emails from localhost
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    # Don't generate factories
    config.generators { |g| g.factory_girl false }

    # Use local cookie storage for session by default
    config.session_store :cookie_store, key: '_wax_poetic_session'

    # Run a Redis server on localhost (with Foreman)
    config.redis_url = 'redis://localhost:6379'
  end
end
