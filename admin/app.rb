module KajaNomination
  class Admin < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    set :admin_model, 'Account'
    set :login_page,  '/sessions/new'

    enable  :sessions
    disable :store_location

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
    end

    access_control.roles_for :admin do |role|
      role.project_module :settings, '/settings'
      role.project_module :nominees, '/nominees'
      role.project_module :archives, '/archives'
      role.project_module :accounts, '/accounts'
    end

    Twitter.configure do |config|
      config.consumer_key       = (ENV['TWITTER_KEY']           || Oauth.twitter.key)
      config.consumer_secret    = (ENV['TWITTER_SECRET']        || Oauth.twitter.secret)
      config.oauth_token        = (ENV['TWITTER_TOKEN']         || Oauth.twitter.token)
      config.oauth_token_secret = (ENV['TWITTER_TOKEN_SECRET']  || Oauth.twitter.token_secret)
    end

    # Custom error management 
    error(403) { @title = "Error 403"; render('errors/403', layout: :error) }
    error(404) { @title = "Error 404"; render('errors/404', layout: :error) }
    error(500) { @title = "Error 500"; render('errors/500', layout: :error) }
  end
end
