module Capistrano
  module Novelys
    module Helpers
      # Run rake on the server.
      # To be used in tasks.
      def run_remote_rake(rake_cmd)
        rake_args = ENV['RAKE_ARGS'].to_s.split(',')
        release = Capistrano::Configuration.instance.fetch(:latest_release)
        rake = Capistrano::Configuration.instance.fetch(:rake, 'rake')
        env = Capistrano::Configuration.instance.fetch(:rails_env, 'production')

        cmd = "cd #{release} && #{rake} RAILS_ENV=#{env} #{rake_cmd}"
        cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?

        run cmd

        set :rakefile, nil if exists?(:rakefile)
      end
      module_function :run_remote_rake
    end
  end
end
