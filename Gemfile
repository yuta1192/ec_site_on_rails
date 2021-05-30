source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', groups: %w(test development), require: false
gem 'mysql2'
gem 'pg', groups: %w(production), require: false
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem "activesupport", ">= 5.2.4.3"
gem "actionpack", ">= 5.2.4.3"
gem "activestorage", ">= 5.2.4.3"
gem 'bootstrap', '~> 4.5.0'
gem 'jquery-rails'
# seed
gem 'seed-fu'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# パスワードハッシュ化
gem 'bcrypt'
# slim化
gem 'slim'
gem 'html2slim'
# 画像系
gem 'carrierwave'
gem 'rmagick'
# 表示切り替えや表示個数の指定のため
gem 'kaminari'
gem 'kaminari-bootstrap'
# カレンダー
gem 'fullcalendar-rails'
gem 'momentjs-rails'
# webpacker
gem 'webpacker', github: "rails/webpacker"

gem 'mini_racer'
# mongodb
gem 'mongoid'
gem 'bson_ext'
# oauth
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-hatena'
gem 'omniauth-linkedin'
gem 'omniauth-mixi'
gem 'omniauth-twitter'
#datadog
gem 'ddtrace'
gem 'dogstatsd-ruby'
# fluentd
gem 'act-fluent-logger-rails', git: 'https://github.com/actindi/act-fluent-logger-rails.git'
gem 'lograge'
# for elastic search
gem 'elasticsearch-rails', git: 'git://github.com/elastic/elasticsearch-rails.git', branch: '6.x'
gem 'elasticsearch-model', git: 'git://github.com/elastic/elasticsearch-rails.git', branch: '6.x'
# for image uploader with AWS S3
gem 'carrierwave'
gem 'fog-aws'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem "rspec"
  gem "rspec_junit_formatter"
  gem 'dotenv-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
  # rubocop
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
