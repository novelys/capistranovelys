module Capistrano
  module Novelys
    module Helpers
      # Run rake on the server.
      # To be used in tasks.
      def run_remote_rake(cap, rake_cmd)
        rake_args = ENV['RAKE_ARGS'].to_s.split(',')
        release = cap.fetch(:latest_release)
        rake = cap.fetch(:rake, 'rake')
        env = cap.fetch(:rails_env, 'production')

        cmd = "cd #{release} && #{rake} RAILS_ENV=#{env} #{rake_cmd}"
        cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?

        cap.run cmd

        cap.set :rakefile, nil if cap.exists?(:rakefile)
      end
      module_function :run_remote_rake
    end
  end
end
