# AGENTS.md

## Secrets and sensitive data

- Treat all secrets as sensitive, including temporary credentials such as session tokens. Do not read, search for, print, echo, log, diff, or otherwise expose them.
- When a secret must be used, load it directly into a shell variable or environment variable without printing it. Do not place secrets in commands, outputs, patches, prompts, or error reports.
- Secrets are stored as files under `~/.secrets` and sourced by `~/.bash_profile` into environment variables.
- Do not run commands that may expose secrets, directly or indirectly, such as `env`, unless the user explicitly requests it.
- If a task would require inspecting or revealing a secret value, stop and ask for an alternative approach first.

## Working agreements

- When beginning work in a repository, identify and read any applicable `AGENTS.md` files before exploring the codebase or making changes.
- Before executing a command or modifying a file, prepare the exact command or proposed change first, including a diff when relevant. If approval is required, present that command or change only in the approval prompt UI, not in `commentary`, and do not repeat it in `final`. If no approval prompt will appear, use `commentary` for any required preview.
- When relevant, prefer MCP servers over fallback approaches.
