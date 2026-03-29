# AGENTS.md

## Purpose

This repository packages OpenAI Codex to run inside a rootless Podman container with explicit local volume mounts for persistent state, projects, and secrets.

The main goal is stronger local isolation than running Codex directly on the desktop, while still keeping the workflow simple.

## Key Commands

- `make build`: build the container image
- `make rebuild`: rebuild without using the layer cache
- `make up`: create or replace the Podman pod
- `make down`: stop and remove the Podman pod
- `make codex`: run Codex inside the container
- `make shell`: open a `bash` shell inside the container

## Files That Matter

- `Dockerfile`: image definition
- `Makefile`: local workflow entry points
- `podman/codex.yaml`: pod manifest template rendered with `envsubst`
- `volumes/codex/config.toml`: tracked Codex configuration

## Volumes

The container uses bind mounts under `volumes/`:

- `volumes/codex/`: persistent Codex state
- `volumes/projects/`: working directory inside the container
- `volumes/secrets/`: local secret files

Do not commit secret contents. Only `volumes/codex/config.toml` is intended to be tracked.

## Editing Guidance

- Keep version pins explicit unless intentionally updating them.
- Keep YAML and TOML keys in alphabetical order where practical and where parsing order does not matter.
- Do not hardcode host-specific absolute paths in the manifest beyond the `${ROOT_DIR}` template mechanism already used by the Makefile.
- Prefer minimal, targeted changes over broad refactors.

## Security Expectations

- Treat `volumes/secrets/` as sensitive local input.
- Do not widen container privileges casually.
- Keep the Podman and Codex sandboxing model intact unless there is a clear reason to change it.
- If changing auth, secret loading, or environment inheritance behavior, explain the security tradeoff clearly.
