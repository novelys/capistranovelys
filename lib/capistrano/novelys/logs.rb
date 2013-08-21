## Tasks
namespace :logs do
  desc "Tail Rails logs"
  task :tail do
    stream "tail -f #{shared_path}/log/#{rails_env}.log"
  end
end
