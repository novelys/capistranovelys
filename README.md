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
* load recipes you need, eg: `use_stack :database, :rails2, :rbenv, :whenever`. To be used **BEFORE** other loading of recipes such as `deploy/assets`, otherwise some hooks (such as the symlinks) will be executed too late.
  * You can use `use_default_stack_and [arg, ...]`. It will load `airbrake`, `rbenv`, `unicorn`, `logs`, `stages`, `remote_commands`, and the recipes supplied as arguments. Use `use_default_stack` if you don't want/need anything else.
* Make sure you don't have duplicates!

## Recipes available

### Core

Common setup and options is done here. I suggest reading the file to go through all the details.

Basically, using core means you're using git, you're using rails, and you'll keep 5 releases.

### SSH

This gem has a dependency on `sushi`. This allows you to do `capistrano [stage] ssh`.

### Rails 2 (`rails2`)

* `rails2:console` : open a rails console
* `rails2:secret_token:copy` : copy the session_store from your local file to the shared path
* `rails2:secret_token:symlink` : symlink the session_store.rb file from the shared path to the current path. Hooked after `deploy:update_code`

### Rails 3 (`rails3`)

* `rails3:console` : open a rails console
* `rails":secret_token:copy` : copy the secret_token from your local file to the shared path
* `rails3:secret_token:symlink` : symlink the secret_token.rb file from the shared path to the current path. Hooked after `deploy:update_code`

### Stages (`stages`)

Replacement with better defaults for stages:

* bundles two stages, `staging` and `production`, `staging` being the default`;
* those stages comes with default for `branch` and `rails_env`; staging can override `branch` at runtime (via `cap -S branch=value`);
* if no stages are specified, stages are defined and loaded by looking in `config/deploy/*.rb`

You should not require `capistrano/ext/multistage`.

### Database (`database`)

* `database:create` : create the database
* `database:seed` : seed the database
* `database:copy` : copy the database.yml from your local file to the shared path
* `database:symlink` : symlink the database.yml file from the shared path to the current path. Hooked after `deploy:update_code`

### Mongoid (`mongoid`)

* `mongoid:copy` : copy the mongoid.yml from your local file to the shared path
* `mongoid:symlink` : symlink the mongoid.yml file from the shared path to the current path. Hooked after `deploy:update_code`
* `mongoid:index` : create the indexes

### Logs (`logs`)

* `logs:tail` : tail the logs of the rails app

### Rbenv (`rbenv`)

Setup the `default_environment` with the correct path for rbenv

### Remote commands (`remote_commands`)

* `remote:rake` : Execute a rake task on the target (eg: `cap remote:rake "assets:precompile"`)
* `remote:command` : Execute a shell command on the target (eg: `cap remote:command ls`)

### S3 (`s3`)

* `s3:copy` : copy the amazon_s3.yml from your local file to the shared path
* `s3:symlink` : symlink the amazon_s3.yml file from the shared path to the current path. Hooked after `deploy:update_code`

### Unicorn (`unicorn`)

`deploy:start`, `deploy:stop`, `deploy:graceful_stop`, `deploy:reload`, `deploy:restart` tasks for unicorn

### Airbrake (`airbrake`)

* `airbrake:copy` : copy the airbrake.rb from your local file to the shared path
* `airbrake:symlink` : symlink the airbrake.rb file from the shared path to the current path. Hooked after `deploy:update_code`

### Sphinx (`sphinx`)

* `thinking_sphinx:copy` : copy the *.sphinx.conf from your local file to the shared path
* `thinking_sphinx:symlink` : symlink the *.sphinx.conf file from the shared path to the current path. Hooked after `deploy:update_code`
* Every task available under the namespace `thinking_sphinx` is also available under the namespace `ts`, eg. `ts:rebuild`

### Sunspot (`sunspot`)

* `sunspot:copy` : copy the sunspot.yml from your local file to the shared path
* `sunspot:symlink` : symlink the sunspot.yml file from the shared path to the current path. Hooked after `deploy:update_code`

### Whenever (`whenever`)

Setup options for the `whenever` gem

## Projects using it

* dieppe
