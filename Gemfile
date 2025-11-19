source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.4.0'

gem "rails", "~> 8.1.0"

gem "base64"
gem "bigdecimal", "~> 3.3"
gem "bootsnap", require: false
gem "cssbundling-rails"
gem "csv", "~> 3.3"
gem "jsbundling-rails"
gem "mutex_m"
gem "pagy", "~> 5.10"
gem "pg", "~> 1.1"
gem "phlex-rails"
gem "propshaft"
gem "puma", "~> 6.4"
gem "ransack", "~> 4.4"
gem "redis", "~> 4.0"
gem "stimulus-rails"

gem "turbo-rails", "~> 1.3.0"
gem "turbo_power", "~> 0.1.2"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug"
end

group :development do
  gem "tidewave"

  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
