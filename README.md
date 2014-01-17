# Capistranovelys - Keeping our recipes DRY

This gem includes every recipe/task that is in use in more than one project at Novelys.

## Installation

`capistranovelys` has a dependency on recent versions of `capistrano`,
meaning you can remove `capistrano` and `capistrano-ext` from your Gemfile, and replace it with :

```ruby
gem "capistranovelys", '~> 1.0.0'
```

## Usage

In your deploy.rb :

* remove `require "production_chain/capistrano" if you are using [novelys/production_chain](https://github.com/novelys/production_chain)
* add `require 'capistrano/novelys'` (loads the core recipes)
* load recipes you need, eg: `use_recipes :database, :rails2, :rbenv, :whenever`. To be used **BEFORE** other loading of recipes such as `deploy/assets`, otherwise some hooks (such as the symlinks) will be executed too late.
  * You can use `use_novelys_and [arg, ...]`. It will load `airbrake`, `rbenv`, `logs`, `stages`, `remote_commands, production_chain`, and the recipes supplied as arguments. This will also use Novelys' configuration for `user`, `deploy_to`, and `repository`. Use `use_novelys` if you don't want/need anything else.
* You probably want to set `user`, `deploy_to`, and `repository` at the very least. Refer to `core.rb` to see which default values are set
* Make sure you don't have duplicates!

## Recipes available

### Core

Common setup and options is done here. I suggest reading the file to go through all the details.

Basically, using core means you're using git, you're using rails, and you'll keep 5 releases.

### SSH

This gem has a dependency on `sushi`. This allows you to do `capistrano [stage] ssh`.

### Rails (`rails`)

Rails 3 & 4 commands.

* `rails:console` : open a rails console
* `rails:secret_token:copy` : copy the secret_token from your local file to the shared path
* `rails:secret_token:symlink` : symlink the secret_token.rb file from the shared path to the current path. Hooked after `deploy:update_code`

### Rails 2 (`rails2`)

Rails 2 commands.

* `rails:console` : open a rails console
* `rails:secret_token:copy` : copy the session_store from your local file to the shared path
* `rails:secret_token:symlink` : symlink the session_store.rb file from the shared path to the current path. Hooked after `deploy:update_code`

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

### Production chain (`production_chain`)

Recipes usings rake tasks from [novelys/production_chain](https://github.com/novelys/production_chain). Will work only if the gem is present.

* `db:dump_and_restore`: restore the database from the server to your local env. Supply `FILE=mongoid` when using mongoid.
* `assets:dump_and_restore`: restore the assets from the public direction to your local env.

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

### Puma (`puma`)

`deploy:start`, `deploy:stop`, `deploy:graceful_stop`, `deploy:reload`, `deploy:restart` tasks for puma. Doesn't actually do anything except requiring "puma".

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
