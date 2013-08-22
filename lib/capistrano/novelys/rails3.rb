require 'readline'

## Hooks
after 'deploy:update_code', 'rails3:secret_token:symlink'

## Tasks
namespace :rails3 do
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
    input = ''
    run "cd #{current_path} && #{bundle_cmd} exec rails console #{rails_env}", :once => true do |chan, stream, data|
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
