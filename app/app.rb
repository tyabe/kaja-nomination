module KajaNomination
  class App < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register CompassInitializer

    configure :production do
      register Padrino::Contrib::ExceptionNotifier
      register Padrino::Contrib::Helpers::AssetsCompressor
    end

    use OmniAuth::Builder do
      provider :github,   ENV['GITHUB_KEY']   || Oauth.github.key,   ENV['GITHUB_SECRET']    || Oauth.github.secret
      provider :twitter,  ENV['TWITTER_KEY']  || Oauth.twitter.key,  ENV['TWITTER_SECRET']   || Oauth.twitter.secret
      provider :facebook, ENV['FACEBOOK_KEY'] || Oauth.facebook.key, ENV['FACEBOOK_SECRET']  || Oauth.facebook.secret
    end

    get :auth, map: '/auth/:provider/callback' do
      auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth["provider"].to_s, auth["uid"].to_s) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      flash[:notice] = t('app.login_success')
      redirect session.delete(:return_to) || '/'
    end

    get '/auth/failure' do
      flash[:alert] = t('app.authentication_failed')
      redirect '/'
    end

    get :logout, map: '/logout' do
      session[:user_id] = nil
      flash[:notice] = t('app.logout_success')
      redirect '/'
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      return unless session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

    def authenticate!
      return if logged_in?
      flash[:warn] = t('app.please_login')
      redirect '/'
    end

    def error404
      status 404
      render 'errors/not_found'
    end

    error ActiveRecord::RecordNotFound, Sinatra::NotFound, 404 do
      error404
    end

    error do
      render 'errors/error'
    end

    after do
      ActiveRecord::Base.connection.close
    end

  end
end
