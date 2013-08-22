# Capistranovelys - Keeping our recipes DRY

This gem, once stable, should include every recipe/task that serves for more than one of our project.

## Installation

`capistranovelys` has a dependency on recent versions of `capistrano`,
meaning you can remove `capistrano` and `capistrano-ext` from your Gemfile, and replace it with :

```ruby
gem "capistranovelys", :git => 'git@github.com:novelys/capistranovelys.git'
```

## Usage

In your deploy.rb :

* remove `require "production_chain/capistrano";
* add `require 'capistrano/novelys'` (loads the core recipes)
* optionnally, add `require 'capistrano/novelys/stack'` (loads recipes that are in use in almost every project here)
* load recipes you need, eg:  `load 'novelys/database'`
* Make sure you don't have duplicates

## Recipes available

### Core

Common setup and options is done here. I suggest reading the file to go through all the details.

Basically, using core means you're using git, you're using rails, and you'll keep 5 releases.

### SSH

This gem has a dependency on `sushi`. This allows you to do `capistrano [stage] ssh`.

### Database

* `database:create` : create the database
* `database:seed` : seed the database
* `database:copy` : copy the database.yml from your local file to the shared path
* `database:symlink` : symlink the database.yml file from the shared path to the current path. Hooked after `deploy:update_code`

### Mongoid

* `mongoid:copy` : copy the mongoid.yml from your local file to the shared path
* `mongoid:symlink` : symlink the mongoid.yml file from the shared path to the current path. Hooked after `deploy:update_code`
* `mongoid:index` : create the indexes

### Logs

* `logs:tail` : tail the logs of the rails app

### Rbenv

Setup the `default_environment` with the correct path for rbenv

### Remote_commands

* `remote:rake` : Execute a rake task on the target (eg: `cap remote:rake "assets:precompile"`)
* `remote:command` : Execute a shell command on the target (eg: `cap remote:command ls`)

### S3

* `s3:copy` : copy the amazon_s3.yml from your local file to the shared path
* `s3:symlink` : symlink the amazon_s3.yml file from the shared path to the current path. Hooked after `deploy:update_code`

### Unicorn

`deploy:start`, `deploy:stop`, `deploy:graceful_stop`, `deploy:reload`, `deploy:restart` tasks for unicorn

### Whenever

Setup options for the `whenever` gem

## Projects using it

* dieppe
