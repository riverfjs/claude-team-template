# claude-team-template

**English** | [简体中文](./README.zh.md)

A Claude Code multi-agent team template. Clone it and start building — agents, MCP servers, and HUD are all pre-configured.

## Quick Start

```bash
git clone git@github.com:riverfjs/claude-team-template.git my-project
cd my-project
CLAUDE_CONFIG_DIR=.claude claude
```

Then use the `/build` command to start:

```
/build a simple todo web app with user auth
```

> `CLAUDE_CONFIG_DIR=.claude` tells Claude to use `.claude/` as its config directory instead of `~/.claude/`, so agents, settings, plugins, and MCP servers all take effect without touching your global config.

## Usage

| Command | Description |
|---------|-------------|
| `/build <task>` | Start a full agent team to build the task. This is the primary way to use this template. |

The `/build` command forces the full team pipeline regardless of task size:

```
Phase 1 (parallel):  product-manager → PRD    +  architect → tech spec
Phase 2 (parallel):  frontend → UI code       +  backend → API code
Phase 3:             qa → verify & fix
Phase 4 (optional):  devops → deploy
```

## What's Pre-configured

Everything works out of the box — no additional setup:
- **7 specialist agents** — PM, architect, frontend, backend, devops, QA, project manager
- **4 MCP servers** — context7, sequential, magic, playwright
- **Claude HUD** — real-time statusline showing context usage, agent status, todos
- **Workspace** — auto-created on first prompt

## Agents

| Agent | Role |
|-------|------|
| `product-manager-agent` | Writes PRD with acceptance criteria |
| `architect-agent` | Designs file structure, data contracts, API specs |
| `frontend-agent` | Builds UI from specs |
| `backend-agent` | Builds APIs and services from specs |
| `devops-agent` | CI/CD, Docker, infrastructure |
| `qa-agent` | Verifies against PRD, fixes bugs, ships/no-ships |
| `project-manager-agent` | Task tracking for multi-week projects |

## Workspace

Each agent writes to its own directory:

```
workspace/
├── product-manager/   ← PRDs
├── architect/         ← Architecture docs
├── frontend/          ← Frontend code
├── backend/           ← Backend code
├── devops/            ← CI/CD configs
└── qa/                ← Test reports
```

## MCP Servers

| Server | Purpose |
|--------|---------|
| context7 | Library docs and best practices |
| sequential | Multi-step reasoning |
| magic | UI component generation |
| playwright | Browser automation and E2E testing |

## Prerequisites

This template uses [Agent Teams](https://code.claude.com/docs/en/agent-teams). Follow the official guide to enable it before use.

## License

MIT
