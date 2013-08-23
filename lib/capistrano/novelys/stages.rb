# Inspired by https://github.com/TechnoGate/capistrano-exts

set(:default_stage)  { :staging }

default_stages = [default_stage, :production]
location = fetch(:stage_dir, 'config/deploy')

# Load stages from per-stage deploy file if not defined
unless exists?(:stages)
  set :stages, Dir["#{location}/*.rb"].map { |f| File.basename(f, ".rb") }
end

# Force symbols
set :stages, stages.map(&:to_sym)

desc "Set the target stage to `staging'."
task :staging do
  set :stage,     :staging
  set :branch,    fetch(:branch, :staging)
  set :rails_env, :staging

  load "#{location}/#{stage}" if File.exists?("#{location}/#{stage}.rb")
end

desc "Set the target stage to `production'."
task :production do
  set :stage,     :production
  set :branch,    :production
  set :rails_env, :production

  load "#{location}/#{stage}"
end

(stages - default_stages).each do |name|
  desc "Set the target stage to `#{name}'."
  task(name) do
    set(:stage) { name }
    load "#{location}/#{stage}"
  end
end

namespace :multistage do
  desc "[internal] Ensure that a stage has been selected."
  task :ensure do
    if !exists?(:stage)
      logger.important "Defaulting to `#{default_stage}'"
      find_and_execute_task(default_stage)
    end
  end
end

on :start, "multistage:ensure", :except => default_stages + stages
