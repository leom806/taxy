source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby ">= 3.1.2"

gem "rails", "~> 7.0.1"

gem "chartkick"
gem "importmap-rails"
gem "jbuilder"
gem "lograge"
gem "pagy"
gem "pg_search"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-attack"
gem "ransack"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "wisper"
gem "sucker_punch"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false


group :development do
  gem "annotate"
  gem "brakeman" # brakeman -f html -o brakeman_report.html
  gem "bundler-audit"
  gem "web-console"
  gem "prettier"
  gem "rubycritic", require: false
end

group :test do
  gem "database_cleaner-active_record"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "faker"
  gem "factory_bot_rails"
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "pry-byebug"
  gem 'rspec-rails', '~> 6.0.0'
end
