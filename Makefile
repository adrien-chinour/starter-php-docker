# Makefile only works for Unix System
APP_CONTAINER  = app
RUN_CONTAINER   = docker-compose run --rm $(APP_CONTAINER)

UID := $(shell id -u)
GID := $(shell id -g)
export UID
export GID

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

## ----- Docker ------

build: ## Build containers
	docker-compose build

build-nc: ## Build containers without caching
	docker-compose build --no-cache

sh: ## Run sh on app container
	$(RUN_CONTAINER) sh

up: ## Up containers
	docker-compose up -d

down: ## Down containers
	docker-compose down

## ----- Composer -----

install: composer.lock ## Install vendors according to the current composer.lock file
	$(RUN_CONTAINER) sh -c 'composer install'

update: composer.json ## Update vendors according to the current composer.json file
	$(RUN_CONTAINER) sh -c 'composer update'
