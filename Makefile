# These shell flags are REQUIRED for an early exit in case any program called by make errors!
.SHELLFLAGS=-euo pipefail -c
SHELL := /bin/bash

TARGETS := build deploy new help
.PHONY: $(TARGETS)

build: ## Build all containers.
	@PWD=$(PWD) PUSH=false ./hack/build_and_push.sh

deploy: ## Build and push all containers.
	@PWD=$(PWD) PUSH=true ./hack/build_and_push.sh

new: ## Bootstrap a new container directory.
	@[[ -z "$(NAME)" ]] && { echo >&2 "error: NAME is unset." && echo >&2 "usage: NAME=<name> make new" && exit 1; } || true
	@mkdir $(NAME) && touch $(NAME)/Dockerfile
	@cp commands.sh.tpl $(NAME)/commands.sh

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
