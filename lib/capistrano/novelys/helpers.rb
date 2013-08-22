module Capistrano
  module Novelys
    module Helpers
      # Run rake on the server.
      # To be used in tasks.
      def run_remote_rake(rake_cmd)
        rake_args = ENV['RAKE_ARGS'].to_s.split(',')
        cmd = "cd #{fetch(:latest_release)} && #{fetch(:rake, "rake")} RAILS_ENV=#{fetch(:rails_env, "production")} #{rake_cmd}"
        cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
        run cmd
        set :rakefile, nil if exists?(:rakefile)
      end
      module_function :run_remote_rake
    end
  end
end
