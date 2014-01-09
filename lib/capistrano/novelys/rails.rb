require 'readline'

## Hooks
after 'deploy:update_code', 'rails:secret_token:symlink'

## Tasks
namespace :rails do
  namespace :secret_token do
    desc "Copy the secret token file to the server"
    task :copy do
      upload "config/initializers/secret_token.rb", "#{shared_path}/config/initializes/secret_token.rb", :via => :scp
    end

    desc "Symlink the secret token file in the current release"
    task :symlink do
      run "test -f #{release_path}/config/initializers/secret_token.rb || ln -s #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
    end
  end

  desc "Open a Rails console"
  task :console do
    run_interactively "bundle exec rails console #{rails_env}"
  end

  desc "Open a DBConsole"
  task :dbconsole do
    run_interactively "bundle exec rails dbconsole #{rails_env}"
  end
end

def run_interactively(command, server = nil)
  server ||= find_servers_for_task(current_task).first
  exec %Q(ssh #{user}@#{server.host} -t 'cd #{current_path} && #{command}')
end
