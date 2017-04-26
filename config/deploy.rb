lock "3.7.2"

set :application, "todoapp3"
set :repo_url, "git@github.com:alex-ross/todomvc-turbolinks.git"
set :branch, "master"
set :deploy_to, "/usr/local/src/#{fetch :application}"

namespace "docker" do
  task "update" do
    on roles(:app) do
      within release_path do
        docker_base = [
          "docker-compose",
          "-p", fetch(:application), 
          "-f", "docker-compose.yml",
          "-f", "config/docker-compose/production.yml"
        ]
        execute(*docker_base, "up", "-d", "--build", "--remove-orphans")
        execute(*docker_base, "run", "--rm", "web", "bin/rails db:create", "2>&1")
        execute(*docker_base, "run", "--rm", "web", "bin/rails db:setup")
      end
    end
  end
end

after "deploy:updating", "docker:update"
