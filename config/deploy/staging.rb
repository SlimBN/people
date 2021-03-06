set :branch, 'master'
server ENV['STAGING_SERVER'], user: ENV['STAGING_USER'], roles: %w{web app db}

set :deploy_to, ENV['STAGING_DEPLOY_PATH']

set :docker_volumes, [
  "#{shared_path}/config/sec_config.yml:/var/www/app/config/sec_config.yml",
  "#{shared_path}/log:/var/www/app/log",
  "#{shared_path}/public/uploads:/var/www/app/public/uploads",
  "people_staging_assets:/var/www/app/public/assets",
  "people_staging_node_modules:/var/www/app/node_modules",
  "#{shared_path}/assets/javascripts/react_bundle.js:/var/www/app/app/assets/javascripts/react_bundle.js",
]

set :docker_dockerfile, "docker/staging/Dockerfile"

