# encoding: UTF-8
## Hooks
after 'deploy:update_code', 'thinking_sphinx:symlink'

## Tasks
namespace :thinking_sphinx do
  desc "Copy local sphinx config"
  task :copy do
    upload "config/development.sphinx.conf", "#{shared_path}/config/#{rails_env}.sphinx.conf", :via => :scp
  end

  desc "Link the config/*.sphinx.conf file in the release_path"
  task :symlink do
    run "test -f #{release_path}/config/#{rails_env}.sphinx.conf || ln -s #{shared_path}/config/#{rails_env}.sphinx.conf #{release_path}/config/#{rails_env}.sphinx.conf"
  end

  desc "Generate the Sphinx configuration file"
  task :configure do
    Novelys::Helpers.run_remote_rake(self, "thinking_sphinx:configure")
  end

  desc "Index data"
  task :index do
    Novelys::Helpers.run_remote_rake(self, "thinking_sphinx:index")
  end

  desc "Start the Sphinx daemon"
  task :start do
    configure
    Novelys::Helpers.run_remote_rake(self, "thinking_sphinx:start")
  end

  desc "Stop the Sphinx daemon"
  task :stop do
    configure
    Novelys::Helpers.run_remote_rake(self, "thinking_sphinx:stop")
  end

  desc "Stop and then start the Sphinx daemon"
  task :restart do
    stop
    start
  end

  desc "Stop, re-index and then start the Sphinx daemon"
  task :rebuild do
    stop
    index
    start
  end

  desc "Add the shared folder for sphinx files for the current environment"
  task :shared_sphinx_folder, :roles => :web do
    run "mkdir -p #{shared_path}/db/sphinx/#{rails_env}"
  end
end

## Alias for thinking_sphinx namespace
namespace :ts do
  desc "Generate the Sphinx configuration file"
  task(:configure) { thinking_sphinx.configure }

  desc "Index data"
  task(:index) { thinking_sphinx.index }

  desc "Stop, re-index and then start the Sphinx daemon"
  task(:rebuild) { thinking_sphinx.rebuild }

  desc "Stop and then start the Sphinx daemon"
  task(:restart) { thinking_sphinx.restart }

  desc "Add the shared folder for sphinx files for the production environment"
  task(:shared_sphinx_folder) { thinking_sphinx.shared_sphinx_folder }

  desc "Start the Sphinx daemon"
  task(:start) { thinking_sphinx.start }

  desc "Stop the Sphinx daemon"
  task(:stop) { thinking_sphinx.stop }

  desc "Copy local sphinx config"
  task(:copy) { thinking_sphinx.copy }

  desc "Link the config/*.sphinx.conf file in the release_path"
  task(:symlink) { thinking_sphinx.symlink }
end

