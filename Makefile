include .env
export

all: build shell

build:
ifeq (, $(shell which podman))
	@echo "Using Docker"
	docker container rm -f devct
	docker image rm -f devct
	docker compose down
	docker compose up -d --force-recreate
	docker exec -it devct sh -c "echo $$USERNAME:$$PASS | chpasswd"
	docker exec -it devct su -c "chezmoi apply" - $$USERNAME
else
	@echo "Using Podman"
	podman container rm -f devct
	podman image rm -f devct
	podman-compose down
	podman-compose up -d --force-recreate
	podman exec -it devct sh -c "echo $$USERNAME:$$PASS | chpasswd"
	podman exec -it devct su -c "chezmoi apply" - $$USERNAME
endif


shell:
ifeq (, $(shell which podman))
	@echo "Using Docker"
	docker exec -it devct su -c /usr/bin/fish - $$USERNAME
else
	@echo "Using Podman"
	podman exec -it devct su -c /usr/bin/fish - $$USERNAME
endif
