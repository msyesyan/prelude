set :deploy_to, "/var/www/sunteya/apps/#{application}"

set :user, "www-data"
server "uat.bstar.wido.me", :app, :web, :db, :daemons => true
set :asset_env, "RAILS_RELATIVE_URL_ROOT=/#{application}"
default_environment["http_proxy"] = default_environment["https_proxy"] = "http://58.196.13.38:8123"
