.PHONY: build codex down rebuild shell up

CONTAINER := codex-codex
IMAGE := localhost/codex:0.1.0
MANIFEST := podman/codex.yaml
ROOT_DIR := $(CURDIR)

build:
	podman build --tag $(IMAGE) .

codex:
	podman exec --interactive --tty $(CONTAINER) bash -lc 'exec codex'

down:
	ROOT_DIR=$(ROOT_DIR) envsubst < $(MANIFEST) | podman kube down -

rebuild:
	podman build --no-cache --tag $(IMAGE) .

shell:
	podman exec --interactive --tty $(CONTAINER) bash

up:
	ROOT_DIR=$(ROOT_DIR) envsubst < $(MANIFEST) | podman kube play --replace --userns keep-id:uid=1001,gid=1001 -
