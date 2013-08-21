## Hooks
after 'deploy:update_code', 'mongoid:symlink'

## Tasks
namespace :mongoid do
  desc "Copy mongoid config"
  task :copy do
    upload "config/mongoid.yml", "#{shared_path}/config/mongoid.yml", :via => :scp
  end

  desc "Link the mongoid config in the release_path"
  task :symlink do
    run "test -f #{release_path}/config/mongoid.yml || ln -s #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end

  desc "Create MongoDB indexes"
  task :index do
    run "cd #{current_path} && #{bundle_cmd} exec rake db:mongoid:create_indexes", :once => true
  end
end

