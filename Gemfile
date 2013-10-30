source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '~> 3.2'
gem 'pg'
gem 'active_model_serializers'
gem 'jbuilder'
gem 'carrierwave'
gem 'fog'
gem 'puma'
gem 'mini_magick'
gem 'strong_parameters'
gem 'asset_sync'
gem 'stripe'
gem 'devise'

group :assets do
  gem 'jquery-rails',     '2.2.2'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'zurb-foundation',  '>= 4.0'
  gem 'uglifier',         '~> 1.3'
  gem 'font-awesome-rails'
end

gem 'ember-rails', '0.12.0'
gem 'emblem-rails', '0.0.7'
gem 'ember_script-rails'

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'travis'
end

group :development, :test do
  gem 'pry-rails'
  gem 'konacha'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'airbrake'
  gem 'redis-rails'
  gem 'rails_12factor'
  gem 'rack-cache'
end
