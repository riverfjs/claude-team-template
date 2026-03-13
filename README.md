# claude-team-template

A Claude Code multi-agent team template. Clone it and start building — agents, MCP servers, and HUD are all pre-configured.

## How it works

When you describe a feature or product, Claude automatically:

1. Forms a team (`TeamCreate`)
2. Spawns **product-manager-agent** + **architect-agent** in parallel
3. Once both finish, spawns **frontend-agent** + **backend-agent** (whichever is needed)
4. Runs **qa-agent** to verify and fix bugs
5. Shuts down all agents and cleans up

No slash commands to remember. No "should I start a team?" — it just does it.

## Setup

```bash
git clone git@github.com:riverfjs/claude-team-template.git my-project
cd my-project
CLAUDE_CONFIG_DIR=.claude CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

> `CLAUDE_CONFIG_DIR=.claude` tells Claude to use `.claude/` as its config directory instead of `~/.claude/`, so agents, settings, plugins, and MCP servers all take effect without touching your global config.

Everything is pre-configured out of the box:
- **Agents** — all 7 specialist agents ready to go
- **MCP servers** — context7, sequential, magic, playwright pre-configured
- **Claude HUD** — real-time statusline showing context, agents, todos
- **Workspace** — `workspace/` subdirectories created on first prompt

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

## MCP servers

| Server | Purpose |
|--------|---------|
| context7 | Library docs and best practices |
| sequential | Multi-step reasoning |
| magic | UI component generation |
| playwright | Browser automation and E2E testing |

## Requirements

- Claude Code
- Node.js ≥ 18


## License

MIT
