---
description: Force a full multi-agent team build. PM → Architect → Dev → QA pipeline, regardless of task size.
---

# Build — Multi-Agent Team

**Task**: $ARGUMENTS

## Mandatory Rules

No matter how small the task — **always** run the full team pipeline. Direct implementation is forbidden. No phases may be skipped.

---

## Execution Pipeline

### Phase 1 — Parallel

Call `TeamCreate` immediately, then **in the same message** spawn in parallel:

- `product-manager-agent` — Write PRD from task description, output to `workspace/product-manager/`
- `architect-agent` — Design tech spec, file structure, API contracts, output to `workspace/architect/`

Wait for both to complete before proceeding.

### Phase 2 — Parallel (as needed)

Based on PRD and architecture, determine which dev agents are needed and spawn **in parallel**:

- `frontend-agent` — when UI work is required
- `backend-agent` — when API / database work is required

Wait for completion.

### Phase 3

Spawn `qa-agent` — verify implementation against PRD, fix issues found, deliver ship / no-ship verdict.

### Phase 4 — Optional

Spawn `devops-agent` if deployment or CI/CD work is needed.

### Teardown

Once all agents complete:
1. Send `shutdown_request` to each agent via `SendMessage`
2. Call `TeamDelete` after all confirm shutdown
3. Report completion summary to user

---

## Constraints

- `TeamCreate` **must** be called before any agent is spawned
- Independent agents **must** be spawned in a single message (parallel), never sequentially
- Register all work with `TaskCreate`, set dependencies via `TaskUpdate(addBlockedBy)`
- All agent output goes to the corresponding `workspace/` subdirectory
