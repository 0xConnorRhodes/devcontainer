all: build shell

run:
	docker compose down && docker compose up -d
	docker exec -it devct-dev /usr/bin/fish

rebuild: clean clean-build shell

clean:
	docker container rm -f devct-dev
	docker image rm -f devct-dev
	yes |docker image prune -a

clean-build:
	docker compose build --no-cache
	docker compose up -d
	sleep 3

build:
	docker container rm -f devct-dev
	docker compose down
	docker compose up -d --force-recreate


shell:
	docker exec -it devct-dev /usr/bin/fish
