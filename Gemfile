source 'https://rubygems.org'

ruby '2.1.2'

gem 'padrino', '0.12.3'

# Server requirements
gem 'thin'

# Project requirements
gem 'rake'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'settingslogic'
gem 'octokit'
gem 'twitter'

# Component requirements
gem 'bcrypt'
gem 'erubis'
gem 'mini_record'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'pry-padrino'
end

group :test do
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
  gem 'rspec-padrino'
  gem "database_cleaner", "1.0.1"
end
