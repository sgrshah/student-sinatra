require 'bundler/capistrano'

set :application, "Student-Sinatra"
set :repository,  "git@github.com:sgrshah/student-sinatra.git"

set :user, 'sgrshah'
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "198.199.72.57"                          # Your HTTP server, Apache/etc
role :app, "198.199.72.57"                          # This may be the same as your `Web` server

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end