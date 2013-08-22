require './config/boot'
require 'airbrake/capistrano'

## Hooks
after 'deploy:update_code', 'airbrake:symlink'

## Tasks
namespace :airbrake do
  desc "Copy airbrake API Key"
  task :copy do
    upload "config/initializers/airbrake.rb", "#{shared_path}/config/initializers/airbrake.rb", :via => :scp
  end

  desc "Link the config/initializers/airbrake.rb file in the release_path"
  task :symlink do
    run "test -f #{release_path}/config/initializers/airbrake.rb || ln -s #{shared_path}/config/initializers/airbrake.rb #{release_path}/config/initializers/airbrake.rb"
  end
end
