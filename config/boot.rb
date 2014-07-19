RACK_ENV  = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

Padrino::Logger::Config[:production][:colorize_logging] = false

OmniAuth.config.logger = Padrino.logger

I18n.default_locale = :ja
I18n.enforce_available_locales = false

Padrino.before_load do
end

Padrino.after_load do
  ActiveRecord::Base.auto_upgrade!
end

Padrino.load!
