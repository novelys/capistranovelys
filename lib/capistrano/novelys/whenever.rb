require 'whenever/capistrano'

## Whenever
set(:whenever_command)     { 'bundle exec whenever' }
set(:whenever_environment) { stage }
