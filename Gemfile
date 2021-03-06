# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"
# faker
gem "bcrypt", "~> 3.1.13"
gem "faker", git: "https://github.com/faker-ruby/faker.git", branch: "master"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.4", ">= 6.1.4.1"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use Puma as the app server
gem "apollo_upload_server", "2.1.0"
gem 'scout_apm'
gem "aws-sdk"
gem "batch-loader"
gem "graphql"
gem "pg_search"
gem 'search_object_graphql'
gem "puma", "~> 5.0"
gem "rails_event_store"
gem "rubocop"
gem "rubocop-performance"
gem "rubocop-rails", require: false
gem "rubocop-rspec", require: false
gem "simplecov", require: false, group: :test
gem "standard"
gem "twilio-ruby"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# debuger
gem "pry", "~> 0.13.1"
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot"
  gem "rspec-rails", "~> 5.0.0"
end

group :development do
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

group :test do
  gem "ruby_event_store-rspec"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
