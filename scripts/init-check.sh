#!/bin/bash
# Auto-run by UserPromptSubmit hook — creates workspace dirs on first run
# Tracks script hash in marker — re-runs if this script changes

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MARKER="$PROJECT_ROOT/.claude/.initialized"
CURRENT_HASH=$(md5 -q "$PROJECT_ROOT/scripts/init-check.sh" 2>/dev/null || md5sum "$PROJECT_ROOT/scripts/init-check.sh" 2>/dev/null | awk '{print $1}')

# Already initialized with same script version — skip
[ -f "$MARKER" ] && [ "$(cat "$MARKER")" = "$CURRENT_HASH" ] && exit 0

# Workspace directories
mkdir -p "$PROJECT_ROOT/workspace/"{product-manager,architect,frontend,backend,devops,qa}

# Save current hash as marker
echo "$CURRENT_HASH" > "$MARKER"
