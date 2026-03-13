# Multi-Agent Development System

This project uses a team-based AI agent workflow. **All development tasks MUST go through the agent team pipeline. Never implement anything directly — always form a team first.**

## Commands

| Command | Purpose |
|---------|---------|
| `/build <description>` | **Primary command.** Forces full team pipeline: PM → Architect → Dev → QA |

Users should always use `/build` to start work. If a user types a request without `/build`, remind them to use it.

## Default Team Workflow

For **every** task — no exceptions:

```
Phase 1 (parallel):  product-manager-agent  +  architect-agent
                            ↓ both complete
Phase 2 (parallel):  frontend-agent  +  backend-agent  (spawn only what's needed)
                            ↓ complete
Phase 3:             qa-agent
                            ↓ complete
Phase 4 (if needed): devops-agent
```

## Orchestration Rules

1. **Always** call `TeamCreate` before spawning any teammate
2. **Always** create tasks with `TaskCreate` and set dependencies with `TaskUpdate(addBlockedBy)`
3. **Always** run independent agents in a single message (parallel spawning)
4. **Always** shut agents down with `SendMessage(shutdown_request)` when done
5. **Always** clean up with `TeamDelete` after all agents confirm shutdown
6. **Never** implement code directly — delegate to agents
7. **Never** ask the user "should I start a team?" — just start it

## Agent Roster

| Agent | Trigger condition |
|-------|------------------|
| `product-manager-agent` | Any new feature — writes PRD first |
| `architect-agent` | Any implementation — designs tech spec first |
| `frontend-agent` | UI/web work needed |
| `backend-agent` | API/database/server work needed |
| `devops-agent` | Deployment, CI/CD, infrastructure needed |
| `qa-agent` | After any implementation — verifies and fixes |
| `project-manager-agent` | Multi-week projects needing explicit task tracking |

## Workspace Layout

Agents write their outputs here:

```
workspace/
├── product-manager/   ← PRDs and requirement docs
├── architect/         ← Architecture and API specs
├── frontend/          ← Frontend source code
├── backend/           ← Backend source code
├── devops/            ← CI/CD configs and scripts
└── qa/                ← Test reports
```

## Parallel Execution

Always launch independent agents in a single message block. Sequential spawning when there is no dependency is a waste.

```
# GOOD — one message, two Agent calls
Phase 1: spawn product-manager-agent + architect-agent simultaneously

# BAD — unnecessary wait
Spawn product-manager-agent, wait, then spawn architect-agent
```

## Branch Strategy

- `main` — production releases
- `develop` — integration branch
- `feature/{agent}/{task}` — per-agent feature branches
