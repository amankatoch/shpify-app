# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'shopifymap'
#set :repo_url, 'git@bitbucket.org:thesubroot/shopifymap.git'

set :deploy_to, '/home/deploy/shopifymap'

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:reload'
    # on roles(:app), in: :sequence, wait: 5 do
    #   execute :touch, release_path.join('tmp/restart.txt')
    # end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end