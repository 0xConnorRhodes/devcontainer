all: build shell

build:
	docker container rm -f devct
	docker image rm -f devct
	docker compose down
	docker compose up -d --force-recreate

shell:
	docker exec -it devct su -c /usr/bin/fish - connor
