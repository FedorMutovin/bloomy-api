# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Migrations check
gem 'strong_migrations', '~> 2.0.0'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# API specification
gem 'ar_lazy_preload', '~> 2.1.0'
gem 'graphql', '~> 2.3.17'

gem 'ostruct', '~> 0.6.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
group :development do
  # Graphiql
  gem 'graphiql-rails'
  gem 'sprockets-rails', require: 'sprockets/railtie'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', require: false

  gem 'rspec-rails', '~> 7.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot'
  gem 'rubocop-graphql'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-require_tools'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
end
