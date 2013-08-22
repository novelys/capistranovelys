## Hooks
after 'deploy:update_code', 'sunspot:symlink'

## Tasks
namespace :sunspot do
  desc "Copy sunspot config"
  task :copy do
    upload "config/sunspot.yml", "#{shared_path}/config/sunspot.yml", :via => :scp
  end

  desc "Link the config/sunspot.yml file in the release_path"
  task :symlink do
    run "test -f #{release_path}/config/sunspot.yml || ln -s #{shared_path}/config/sunspot.yml #{release_path}/config/sunspot.yml"
  end
end
