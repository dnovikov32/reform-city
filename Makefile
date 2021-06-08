ENV = source ./docker/env.sh
DOCKER_COMPOSE = $(ENV) && docker-compose

SHELL := /bin/bash
DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: docker-up
docker-up: ## Start all docker containers. To start only one container, use CONTAINER=<service>
	$(DOCKER_COMPOSE) up -d $(CONTAINER)

.PHONY: docker-down
docker-down: ## Stop all docker containers. To stop only one container, use CONTAINER=<service>
	$(DOCKER_COMPOSE) down $(CONTAINER)

.PHONY: docker-build
docker-build: ## Build all docker images. Build a specific image: make docker-build CONTAINER=<service>
	$(DOCKER_COMPOSE) up -d --force-recreate --no-deps --build

.PHONY: docker-rebuild
docker-rebuild: ## Build all docker images from scratch, without cache etc. Build a specific image: make docker-build CONTAINER=<service>
	$(DOCKER_COMPOSE) rm -sf $(CONTAINER) && \
	$(DOCKER_COMPOSE) build --pull --no-cache $(CONTAINER) && \
	$(DOCKER_COMPOSE) up -d --force-recreate $(CONTAINER)

.PHONY: install
install: ## Install default application
	sh scripts/install.sh

.PHONY: ssh-php
ssh-php: ## PHP container console
	$(DOCKER_COMPOSE) exec php bash

.PHONY: phplint
phplint: ## Runs phplint
	php app/vendor/bin/phplint ./app --exclude=vendor --no-cache
	php app/vendor/bin/phplint ./app/vendor/yiicom --no-cache