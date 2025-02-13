docker:
	sudo rm rails-app/tmp/pids/server.pid -f
	sudo docker compose -f docker-compose.yml up

build:
	sudo docker compose -f docker-compose.yml build

bash:
	sudo docker compose -f docker-compose.yml exec web /bin/bash

stop:
	sudo docker stop $(docker ps -a -q)

bundle:
	sudo docker container exec api_rails bash -c "bundle install"