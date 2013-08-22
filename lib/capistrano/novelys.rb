# This is our default stack

require "capistrano"
require "capistrano/novelys/core_extensions"
require "capistrano/novelys/version"
require "capistrano/novelys/helpers"

if Capistrano::Configuration.instance
  Capistrano::Configuration.instance.load_paths << File.dirname(__FILE__)
  Capistrano::Configuration.instance.load "novelys/core"

  # Capistrano extensions bundled with this gem
  require "sushi/ssh"

  # Capistrano extensions expected to be present
  begin
    require "bundler/capistrano"
  rescue LoadError
    puts "It seems bundler is not there. This might be a problem."
  end
end
