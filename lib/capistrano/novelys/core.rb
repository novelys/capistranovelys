## Dependencies
depend :remote, :command, 'git'

## Default configuration
set(:scm)              { :git }
set(:use_sudo)         { false }
set(:deploy_via)       { :remote_cache }
set(:repository_cache) { 'git_cache' }
set(:copy_exclude)     { %w(.svn .DS_Store .git) }
set(:keep_releases)    { 5 }
set(:public_children)  { %w(images) }
set(:bundle_cmd)       { 'bundle' }


## SSH Options
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

## Default hooks
after 'deploy:update', 'deploy:cleanup'
after 'deploy:setup',  'deploy:mkdir_config'

## Default tasks
namespace :deploy do
  desc "Create directories required for correct symlinking"
  task :mkdir_config do
    run "mkdir -p #{shared_path}/config/initializers"
  end
end
