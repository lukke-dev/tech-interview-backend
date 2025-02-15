docker:
	sudo rm rails-app/tmp/pids/server.pid -f
	sudo docker compose -f docker-compose.yml up

build:
	sudo docker compose -f docker-compose.yml build

bash:
	sudo docker compose -f docker-compose.yml exec web /bin/bash

bundle:
	sudo docker container exec api_rails bash -c "bundle install"

debug:
	sudo docker attach api_rails

sidekiq:
	sudo docker compose -f docker-compose.yml exec web bundle exec sidekiq