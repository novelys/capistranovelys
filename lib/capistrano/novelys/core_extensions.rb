module Capistrano
  class Configuration
    def use_stack(*args)
      args.each { |recipes| load "novelys/#{recipes.to_s}" }
    end
  end
end
