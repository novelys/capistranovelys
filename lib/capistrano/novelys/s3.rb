## Hooks
after 'deploy:update_code', 's3:symlink'

## Tasks
namespace :s3 do
  desc "Copy amazon S3 config"
  task :copy do
    upload "config/amazon_s3.yml", "#{shared_path}/amazon_s3.yml", :via => :scp
  end

  desc "Link the config/amazon_s3.yml file in the release_path"
  task :symlink do
    run "test -f #{release_path}/config/amazon_s3.yml || ln -s #{shared_path}/amazon_s3.yml #{release_path}/config/amazon_s3.yml"
  end
end
