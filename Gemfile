source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0.beta1'

gem 'pg'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem "jquery-rails"
gem 'turbolinks', '~> 5'
gem 'puma'

group :development, :test do
  gem 'spring'
  gem 'stackprof'
  gem 'rack-mini-profiler'
  gem 'flamegraph'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
end
