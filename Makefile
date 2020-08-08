.PHONY: all
all: compose-down-remove-local compose-up

.PHONY: compose-build
compose-build:
	docker-compose \
		--file docker-compose.yaml \
		build

.PHONY: compose-ps
compose-ps:
	docker-compose \
		--file docker-compose.yaml \
		ps

.PHONY: compose-up
compose-up:
	docker-compose \
		--file docker-compose.yaml \
		up \
		--build \
		--detach

.PHONY: compose-logs
compose-logs:
	docker-compose \
		--file docker-compose.yaml \
		logs \
		--follow \
		--timestamps

.PHONY: compose-up-logs
compose-up-logs:
	$(MAKE) compose-up \
	&& $(MAKE) compose-logs

.PHONY: compose-down-up
compose-down-up:
	$(MAKE) compose-down \
	&& $(MAKE) compose-up

.PHONY: compose-down
compose-down:
	docker-compose \
		--file docker-compose.yaml \
		down

.PHONY: compose-down-remove-local
compose-down-remove-local:
	docker-compose \
		--file docker-compose.yaml \
		down \
		--remove-orphans \
		--rmi local \
		--volumes

.PHONY: compose-down-remove-all
compose-down-remove-all:
	docker-compose \
		--file docker-compose.yaml \
		down \
		--remove-orphans \
		--rmi all \
		--volumes
