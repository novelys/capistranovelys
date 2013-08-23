module Capistrano
  class Configuration
    # Sugar for loading given recipes
    def use_stack(*args)
      args.each { |recipes| load "novelys/#{recipes.to_s}" }
    end

    # Sugar for loading common recipes (+ supplied is present)
    def use_default_stack(*args)
      args = ([:airbrake, :logs, :rbenv, :remote_commands, :stages, :unicorn] + args).uniq
      use_stack(*args)
    end
    alias :use_default_stack_and :use_default_stack
  end
end
