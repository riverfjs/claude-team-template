#!/bin/bash
# Auto-run by UserPromptSubmit hook — silent unless something needs installing
# Tracks script hash in marker — re-runs if init-check.sh or install-mcp-servers.sh changes

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MARKER="$PROJECT_ROOT/.claude/.initialized"
CURRENT_HASH=$(md5 -q "$PROJECT_ROOT/scripts/init-check.sh" "$PROJECT_ROOT/scripts/install-mcp-servers.sh" 2>/dev/null || md5sum "$PROJECT_ROOT/scripts/init-check.sh" "$PROJECT_ROOT/scripts/install-mcp-servers.sh" 2>/dev/null | awk '{print $1}' | tr -d '\n')

# Already initialized with same script version — skip
[ -f "$MARKER" ] && [ "$(cat "$MARKER")" = "$CURRENT_HASH" ] && exit 0

# 1. Workspace directories
mkdir -p "$PROJECT_ROOT/workspace/"{product-manager,architect,frontend,backend,devops,qa}

# 2. MCP servers — only install if any are missing
if command -v claude &>/dev/null; then
    INSTALLED=$(claude mcp list 2>/dev/null || echo "")
    MISSING=()
    for server in context7 sequential magic playwright; do
        echo "$INSTALLED" | grep -qi "${server}" || MISSING+=("$server")
    done

    if [ ${#MISSING[@]} -gt 0 ]; then
        echo "[init] Installing missing MCP servers: ${MISSING[*]}"
        bash "$PROJECT_ROOT/scripts/install-mcp-servers.sh"
    fi
fi

# Save current hash as marker
echo "$CURRENT_HASH" > "$MARKER"
