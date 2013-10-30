namespace :deploy do
  task :ssh_configuration do
    ssh_config = %(
    Host heroku.com
      StrictHostKeyChecking no
      CheckHostIP no
      UserKnownHostsFile=/dev/null
    )
    File.write File.expand_path("~/.ssh/config"), ssh_config
  end

  task :heroku_keys do
    sh 'yes | heroku keys:clear'
    sh 'yes | heroku keys:add'
  end

  task :application_to_heroku do
    sh 'git remote add heroku git@heroku.com:psychedelica.git'
    sh 'git push heroku master'
  end

  task :notify_airbrake do
    rev = `git rev-parse HEAD`
    sh %{heroku run "rake airbrake:deploy TO=production REVISION=#{rev}"}
  end
end

desc "Deploy to Heroku from Travis-CI"
task :deploy => %w(
  deploy:ssh_configuration
  deploy:heroku_keys
  deploy:application_to_heroku
  deploy:notify_airbrake
)
