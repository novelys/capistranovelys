require 'readline'

## Hooks
after 'deploy:update_code', 'rails2:secret_token:symlink'

## Tasks
namespace :rails2 do
  namespace :secret_token do
    desc "Copy the secret token file to the server"
    task :copy do
      upload "config/initializers/session_store.rb", "#{shared_path}/config/initializes/session_store.rb", :via => :scp
    end

    desc "Symlink the secret token file in the current release"
    task :symlink do
      run "test -f #{release_path}/initializers/session_store.rb || ln -s #{shared_path}/initializers/session_store.rb #{release_path}/initializers/session_store.rb"
    end
  end

  desc "Open a Rails console"
  task :console do
    input = ''
    run "cd #{current_path} && #{bundle_cmd} exec script/console #{rails_env}", :once => true do |chan, stream, data|
      next if data.chomp == input.chomp || data.chomp == ''
      print data
      next unless data.chomp =~ />\s+$/ # Bad prompt detection

      # Readline's quite tolerant, but most control codes (Ctrl-u, Ctrl-l, ...)
      # will screw up the process' stream.
      input = Readline.readline('', true)
      break if input.nil? # EOF
      chan.send_data "#{input}\n"
    end
  end
end
