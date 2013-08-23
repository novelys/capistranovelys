module Capistrano
  class Configuration
    # Sugar for loading given recipes
    def use_stack(*args)
      args.each { |recipes| load "novelys/#{recipes.to_s}" }
    end

    # Sugar for loading common recipes + supplied
    def use_default_stack_and(*args)
      args = ([:airbrake, :logs, :rbenv, :remote_commands, :unicorn] + args).uniq
      use_stack(*args)
    end
  end
end
