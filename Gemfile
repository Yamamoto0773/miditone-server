# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

######## Environment
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'ridgepole'

######## DB
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

######## Model
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'enumerize', '~> 2.3.1'

######## Front
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

######## Api
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use fast-json-api for serialier
gem 'fast_jsonapi', '~> 1.5'

######## Utility
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'diff-lcs', '~> 1.3'
# QR code
gem 'rqrcode'
# Use Pry as rails console
gem 'pry-rails', '~> 0.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # test
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 5.0.2'
  gem 'rspec-rails', '~> 3.8'
  gem 'rspec-request_describer'
  # rubocop
  gem 'rubocop-rails', '~> 2.3.2', require: false
  # resolve N+1
  gem 'bullet'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # User FFaker in seed data
  gem 'ffaker'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
