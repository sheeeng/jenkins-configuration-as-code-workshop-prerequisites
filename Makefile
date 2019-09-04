.PHONY: all
all: clean jenkins

.PHONY: build
build:
	docker-compose \
		build

.PHONY: status
status:
	docker-compose \
		--file docker-compose.yaml \
		ps

.PHONY: jenkins
jenkins:
	docker-compose \
		--file docker-compose.yaml \
		up \
		--build \
		--detach \
	&& docker-compose \
		--file docker-compose.yaml \
		logs \
		--follow \
		--timestamps

.PHONY: remake
remake:
	docker-compose \
		--file docker-compose.yaml \
		down \
	&& $(MAKE) jenkins

.PHONY: stop
stop:
	docker-compose \
		--file docker-compose.yaml \
		down

.PHONY: clean
clean:
	docker-compose \
		--file docker-compose.yaml \
		down \
		--remove-orphans \
		--rmi all \
		--volumes
