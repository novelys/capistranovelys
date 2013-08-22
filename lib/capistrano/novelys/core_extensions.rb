module Capistrano
  class Configuration
    def use_stack(instance, *args)
      args.each { |recipes| instance.load "novelys/#{recipes.to_s}" }
    end
  end
end
