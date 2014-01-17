module Capistrano
  class Configuration
    # Sugar for loading given recipes
    def use_recipes(*args)
      args.each { |recipes| load "novelys/#{recipes.to_s}" }
    end

    # Sugar for loading common recipes (+ supplied is present)
    def use_novelys(*args)
      args = ([:airbrake, :logs, :production_chain, :rbenv, :remote_commands, :novelys, :stages] + args).uniq
      use_recipes(*args)
    end
    alias :use_novelys_and :use_novelys
  end
end
