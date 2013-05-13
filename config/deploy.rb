set :application, "chubutclasificados"
set :repository,  "git@github.com:aledelsur/clasificadoschubut.git"
set :branch, "development"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "root"

set :deploy_to, "/root/apps/#{application}"
 set :rvm_ruby_string, 'ruby-1.9.3-p392@cc'

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

server "50.116.46.119", :app, :web, :db, :primary => true


namespace(:customs) do
  task :config, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml
    CMD
    run <<-CMD
      chmod -R 777 #{release_path}
    CMD
    
  end
end

namespace :bundle do

  desc "run bundle install and ensure all gem requirements are met"
  task :install do
    run "cd #{current_path} && bundle install  --without=test"
  end

end

namespace :assets do
  desc "runs rake assets:precompile"
  task :reprecompile do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end
end

before "assets:reprecompile", "bundle:install"
after "deploy:finalize_update", "customs:config"
after "deploy", "deploy:cleanup"

#role :web, "50.116.46.119"                          # Your HTTP server, Apache/etc
#role :app, "clasificadoschubut.com"                          # This may be the same as your `Web` server
#role :db,  "clasificadoschubut.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end