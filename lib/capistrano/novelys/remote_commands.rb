namespace :remote do
  desc 'Run remote rake task'
  task :rake do
    ARGV.values_at(Range.new(ARGV.index('remote:rake')+1,-1)).each do |task|
      run "cd #{current_path}; RAILS_ENV=#{rails_env} rake #{task}"
    end
    exit(0)
  end

  desc 'Run remote command'
  task :command do
    command = ARGV.values_at(Range.new(ARGV.index('remote:command')+1,-1))
    run "cd #{current_path}; RAILS_ENV=#{rails_env} #{command*' '}"
    exit(0)
  end
end
