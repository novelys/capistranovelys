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

