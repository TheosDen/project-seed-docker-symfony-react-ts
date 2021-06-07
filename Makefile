.DEFAULT_GOAL := help
.PHONY: help
SHELL := /bin/bash

# Reset
COLOR_OFF=\033[0m
# Regular Colors
COLOR_DANGER=\033[0;31m
COLOR_SUCCESS=\033[0;32m
COLOR_WARNING=\033[0;33m
COLOR_INFO=\033[0;35m

CMD_WEB_SERVICE := @docker-compose exec --user=application web
CMD_WEB_SERVICE_ROOT := @docker-compose exec -u root php-fpm
WORKDIR := /var/www


help:
	@printf "Here are available targets:\n"
	@grep -E '^[a-zA-Z-]+:[a-zA-Z -]*##.*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "${COLOR_SUCCESS}%-30s${COLOR_OFF} %s\n", $$1, $$2}'

run: ## [r] Run project
	@printf "${COLOR_INFO}Starting system services...${COLOR_OFF}\n"
	@docker-compose up -d --build
	@docker-compose ps
r: run
up: run

down: ## [d] Brings the containers down.
	@printf "${COLOR_INFO}Stopping system services...${COLOR_OFF}\n"
	@docker-compose down
d: down

ps: ## Shows containers statuses
	@docker-compose ps

build: ## [b] Build back only
	@printf "${COLOR_INFO}Building backend...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) composer install
	$(CMD_WEB_SERVICE) bin/console d:m:m -n --allow-no-migration
b: build

develop-deploy: ## [dd] Full develop build (back and front)
	@make build --no-print-directory
	@printf "${COLOR_INFO}Building frontend...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) yarn
	$(CMD_WEB_SERVICE) yarn dev
dd: develop-deploy

webpack-watch: ## [ww] Encore watch
	$(CMD_WEB_SERVICE) yarn
	$(CMD_WEB_SERVICE) yarn watch
ww:webpack-watch

php-console: ## [pc] Open php environment console
	$(CMD_WEB_SERVICE) bash
pc: php-console

run-all-tests: ## [t] Run all tests and static analyse
	@printf "${COLOR_INFO}PHP_CS - 'bin/phpcs src'...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) bin/phpcs src -p
	@printf "${COLOR_INFO}PHPSTAN - 'bin/phpstan analyse src tests --level max'...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) bin/phpstan analyse src tests --level max
	@printf "${COLOR_INFO}PHPUnit - 'bin/phpunit tests'...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) bin/phpunit tests
	@printf "${COLOR_INFO}JEST - 'yarn test'...${COLOR_OFF}\n"
	$(CMD_WEB_SERVICE) yarn test
t: run-all-tests
