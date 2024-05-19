all: build shell

run:
	docker compose down && docker compose up -d

rebuild: clean clean-build shell

clean:
	docker container rm -f devct
	docker image rm -f devct
	yes |docker image prune -a

clean-build:
	docker compose build --no-cache
	docker compose up -d

build:
	docker container rm -f devct
	docker compose down
	docker compose up -d --force-recreate


shell:
	docker exec -it devct-dev /usr/bin/fish
