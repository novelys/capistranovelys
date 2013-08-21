# Novelys default stack

if Capistrano::Configuration.instance
  Capistrano::Configuration.instance.load "novelys/core"
  Capistrano::Configuration.instance.load "novelys/logs"
  Capistrano::Configuration.instance.load "novelys/rbenv"
  Capistrano::Configuration.instance.load "novelys/remote_commands"
  Capistrano::Configuration.instance.load "novelys/s3"
  Capistrano::Configuration.instance.load "novelys/unicorn"
end
