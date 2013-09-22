namespace :db do
  desc "Set up the database user for this project."
  task :user do
    sh 'createuser -s wax_poetic'
  end
end

desc "Get the database fully up and running for this env"
task :db => %w(db:user db:setup)
