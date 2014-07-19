Padrino.configure_apps do
  set :sessions,          key: '_kaja_nomination_session'
  set :session_secret,    ENV['SESSION_SECRET'] || '1f1fa19bb9caf2a2e275ee7542a9a2a163cc803e94c329e4e76da07a5ba22a71'
  set :protection,        except: :path_traversal
  set :protect_from_csrf, true
end

Padrino.mount("KajaNomination::Admin", app_file: Padrino.root('admin/app.rb')).to("/admin")

Padrino.mount("KajaNomination::Admin", :app_file => Padrino.root('admin/app.rb')).to("/admin")
Padrino.mount('KajaNomination::App', app_file: Padrino.root('app/app.rb')).to('/')
