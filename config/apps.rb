##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount("blog").to('/blog')
#   Padrino.mount("blog", :app_class => "BlogApp").to('/blog')
#   Padrino.mount("blog", :app_file =>  "path/to/blog/app.rb").to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount("Admin").host("admin.example.org")
#   Padrino.mount("WebSite").host(/.*\.?example.org/)
#   Padrino.mount("Foo").to("/foo").host("bar.example.org")
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount("AppName", :app_file => "path/to/file", :app_class => "BlogApp").to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#

Padrino.configure_apps do
  key = '_kaja_nomination_session'
  if production?
    # Use Session Store of Dalli
    require 'rack/session/dalli'

    set :cache, Dalli::Client.new(ENV["MEMCACHIER_SERVERS"], 
                                  { username: ENV["MEMCACHIER_USERNAME"],
                                    password: ENV["MEMCACHIER_PASSWORD"]}
                                 )
  end
  set :sessions, key: key
  set :session_secret, '1f1fa19bb9caf2a2e275ee7542a9a2a163cc803e94c329e4e76da07a5ba22a71'
  set :protection, true
  set :protect_from_csrf, true
end

Twitter.configure do |config|
  config.consumer_key       = (ENV['TWITTER_KEY']           || Oauth.twitter.key)
  config.consumer_secret    = (ENV['TWITTER_SECRET']        || Oauth.twitter.secret)
  config.oauth_token        = (ENV['TWITTER_TOKEN']         || Oauth.twitter.token)
  config.oauth_token_secret = (ENV['TWITTER_TOKEN_SECRET']  || Oauth.twitter.token_secret)
end

# Mounts the core application for this project
Padrino.mount('KajaNomination::App', app_file: Padrino.root('app/app.rb')).to('/')
Padrino.mount("KajaNomination::Admin", app_file: Padrino.root('admin/app.rb')).to("/admin")

