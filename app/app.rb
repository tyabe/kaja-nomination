class KajaNomination < Padrino::Application
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register CompassInitializer
  register Padrino::Contrib::Helpers::Flash

  configure :production do
    register Padrino::Cache
    register Padrino::Contrib::ExceptionNotifier
    register Padrino::Contrib::Helpers::AssetsCompressor

    set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
#    set :cache, Padrino::Cache::Store::Memory.new(50)
#    set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', exception_retry_limit: 1))

    enable :caching
  end

  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY']||Setting.github.key, ENV['GITHUB_SECRET']||Setting.github.secret
  end

  get :auth, map: '/auth/:provider/callback' do
    auth    = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect '/'
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  not_found do
    render 'errors/not_found'
  end

  error do
    render 'errors/error'
  end

end
