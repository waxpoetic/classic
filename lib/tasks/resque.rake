namespace :resque do
  desc "Set up Resque worker in Rails"
  task :setup => :environment do
    ENV['QUEUE'] ||= '*'
  end
end

desc "Start the Resque worker in the Rails environment"
task :resque => %w(resque:setup resque:work)
