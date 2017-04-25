# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "todoapp"
set :repo_url, "git@github.com:alex-ross/todomvc-turbolinks.git"
set :branch, "deploy"
set :deploy_to, "/usr/local/src/#{fetch :application}"

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"


namespace "docker" do
  task "update" do
    on roles(:app) do
      within release_path do
        docker_base = ["docker-compose", "-p", fetch(:application), "-f", "docker-compose.yml", "-f", "config/docker-compose/production.yml"]
        execute(*docker_base, "up", "-d", "--build", "--remove-orphans")
        execute(*docker_base, "run", "--rm", "web", "rails setup")
        execute(*docker_base, "run", "--rm", "web", "rails migrate")
      end
    end
  end
end

after "deploy:updating", "docker:update"
