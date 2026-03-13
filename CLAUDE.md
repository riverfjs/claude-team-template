# Multi-Agent Development System

This project uses a team-based AI agent workflow. **When a user requests a feature, product, or non-trivial task — automatically form a team and orchestrate agents. Do not wait to be asked.**

## Auto-Trigger Rules

| User says | Action |
|-----------|--------|
| "build X", "create X", "implement X", "make X" | Full team: PM → Architect → Dev → QA |
| "design / architect X" | Spawn `architect-agent` |
| "write PRD / spec for X" | Spawn `product-manager-agent` |
| "test / verify X" | Spawn `qa-agent` |
| "deploy / set up CI for X" | Spawn `devops-agent` |
| Simple one-file fix | No team needed — do it directly |

## Default Team Workflow

For any feature or product request, follow this pipeline:

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
6. **Never** ask the user "should I start a team?" — just start it

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
