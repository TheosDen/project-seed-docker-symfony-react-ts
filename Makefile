.DEFAULT_GOAL := help
.PHONY: help
SHELL := /bin/bash

# Reset
COLOR_OFF=\033[0m
# Regular Colors
COLOR_DANGER=\033[0;31m
COLOR_SUCCESS=\033[0;32m
COLOR_WARNING=\033[0;33m

CMD_WEB_SERVICE := @docker-compose exec --user=application web
CMD_WEB_SERVICE_ROOT := @docker-compose exec -u root php-fpm
WORKDIR := /var/www


help:
	@printf "Here are available targets:\n"
	@grep -E '^[a-zA-Z-]+:[a-zA-Z -]*##.*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "${COLOR_SUCCESS}%-30s${COLOR_OFF} %s\n", $$1, $$2}'

run: ## [r] Run project
	@printf "${COLOR_WARNING}Starting system services...${COLOR_OFF}\n"
	@docker-compose up -d --build
	@docker-compose ps
r: run
up: run

develop-deploy: ## [r] Run project
	$(CMD_WEB_SERVICE) composer install
	$(CMD_WEB_SERVICE) yarn
	$(CMD_WEB_SERVICE) yarn dev
dd: develop-deploy

down: ## [d] Brings the containers down.
	@printf "${COLOR_WARNING}Stopping system services...${COLOR_OFF}\n"
	@docker-compose down
d: down

php-console: ## [pc] Open php environment console
	$(CMD_WEB_SERVICE) bash
pc: php-console

ps: ## Shows containers statuses
	@docker-compose ps

webpack-watch: ## [ww] Encore watch
	$(CMD_WEB_SERVICE) yarn
	$(CMD_WEB_SERVICE) yarn watch
ww:webpack-watch

run-all-tests: ## [t] Run all tests and static analyse
	@printf "${COLOR_WARNING}PHP_CS - 'bin/phpcs src'...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) bin/phpcs src -p
	@printf "${COLOR_WARNING}PHPSTAN - 'bin/phpstan analyse src tests --level max'...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) bin/phpstan analyse src tests --level max --memory-limit 1G
	@printf "${COLOR_WARNING}JEST - 'yarn test'...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) yarn test
t: run-all-tests
