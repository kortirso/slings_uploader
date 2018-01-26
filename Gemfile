source 'https://rubygems.org'

ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.4'
gem 'therubyracer', platforms: :ruby

# Use postgresql as the database for Active Record
gem 'pg', '0.21'

# Use Puma as the app server
gem 'puma', '3.10.0'

# Use SCSS for stylesheets
gem 'sass-rails', '5.0.6'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '3.2.0'

# Store secrets
gem 'figaro'

# Foundation for frontend
gem 'foundation-rails', '6.4.1.3'

# Use Slim as the templating engine. Better than ERB
gem 'slim'

# File uploading
gem 'carrierwave', '~> 1.0'
gem 'rmagick'

# Beautiful names
gem 'friendly_id', '~> 5.1.0'
gem 'babosa'

# Beautiful forms
gem 'simple_form', '3.5.0'

# HTTP Client
gem 'rest-client'

# Authorization
gem 'devise', github: 'plataformatec/devise'

# Add Auth through social networks
gem 'omniauth'
gem 'omniauth-vkontakte'

# Background Jobs
gem 'redis-namespace'
gem 'sidekiq', '5.0.5'

# Code analyzation
gem 'rubocop', '~> 0.49.1', require: false

# Model Serializers
gem 'active_model_serializers', '~> 0.10.0'
gem 'oj'
gem 'oj_mimic_json'

# Add Webpack
gem 'foreman'
gem 'webpacker', '3.2.1'
gem 'webpacker-react', '~> 0.3.2'

# Pagination
gem 'kaminari'

# Mailer
gem 'premailer-rails'

group :development do
    gem 'capistrano', require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano-rails', require: false
    gem 'capistrano-rvm', require: false
    gem 'capistrano-sidekiq', require: false
    gem 'listen', '~> 3.0.5'
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
    gem 'database_cleaner'
    gem 'rspec-rails'
    gem 'factory_bot_rails'
    gem 'rails-controller-testing'
end

group :test do
    gem 'json_spec'
    gem 'shoulda-matchers'
    gem 'simplecov', require: false
end
