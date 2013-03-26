source 'https://rubygems.org'

ruby '2.0.0'

# Server requirements
gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Project requirements
gem 'rake'
gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'settingslogic'
gem 'octokit'
gem 'twitter'

# Component requirements
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'compass'
gem 'erubis', "~> 2.7.0"
gem 'mini_record'

# Padrino Stable Gem
gem 'padrino', '0.11.0'
gem 'padrino-contrib'

group :production do
  gem 'pg'
  gem 'dalli'
  gem 'yui-compressor', :require => 'yui/compressor'
end

group :development do
  gem 'sqlite3'
  gem 'pry-padrino'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'rspec-padrino'
  gem 'capybara'
  gem 'launchy'
  gem 'faker'
  gem 'fabrication'
end

# Or Padrino Edge
# gem 'padrino', :git => 'git://github.com/padrino/padrino-framework.git'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.10.7'
# end
