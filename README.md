# Codexpod

Run OpenAI's [Codex](https://developers.openai.com/codex) agent securely from a rootless container using [podman](https://podman.io/docs).

While Codex already uses [sandboxing](https://developers.openai.com/codex/concepts/sandboxing), running it from a hardened container provides additional peace of mind:

- Persist Codex state and local project data across container restarts via `hostPath` volumes.
- Explicitly decide which secrets to expose to Codex.

## Usage

| Command      | Description                               |
| ------------ | ----------------------------------------- |
| `make build` | Build the container image.                |
| `make up`    | Start the Podman pod.                     |
| `make down`  | Stop and remove the Podman pod.           |
| `make codex` | Run Codex inside the container.           |
| `make shell` | Open a `bash` shell inside the container. |

## Secrets

Secrets can be exposed to the `codex` user's `bash` session as environment variables sourced from files inside `volumes/secrets/` via its `~/.bashrc`.

```bash
# volumes/secrets/pass.env
export PASSWORD="supersecret"
```

Only place there secrets that you are comfortable making available to Codex.
