source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails", "~> 7.0.4"

gem "dalli", "~> 3.2.3"
gem "dry-initializer", "~> 3.1.1"
gem "dry-struct", "~> 1.6.0"
gem "faraday", "~> 2.7.2"
gem "geocoder", "~> 1.8.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do; end

group :development do; end

group :test do
  gem "rspec-rails", "~> 6.0.1"
  gem "rspec_junit_formatter", "~> 0.6.0"
  gem "webmock", "~> 3.18.1"
  gem "vcr", "~> 6.1.0"
end
