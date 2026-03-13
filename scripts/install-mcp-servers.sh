#!/bin/bash

# MCP 服务器安装脚本
# 安装到本项目的 .claude/settings.local.json，不污染全局 ~/.claude/

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()  { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC}    $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC}  $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查依赖
check_deps() {
    if ! command -v claude &>/dev/null; then
        log_error "未找到 claude CLI，请先安装 Claude Code"
        exit 1
    fi
    if ! command -v npx &>/dev/null; then
        log_error "未找到 npx，请先安装 Node.js"
        exit 1
    fi
}

# 安装单个 MCP 服务器
# 用法: install_mcp <name> <package>
install_mcp() {
    local name="$1"
    local package="$2"

    # 检查是否已安装
    if claude mcp list 2>/dev/null | grep -q "^${name}:"; then
        log_warn "${name} 已存在，跳过"
        return 0
    fi

    log_info "安装 ${name} (${package})..."
    if claude mcp add "${name}" -s local -- npx -y "${package}" 2>&1; then
        log_ok "${name} 安装成功"
    else
        log_error "${name} 安装失败"
        return 1
    fi
}

# 主流程
main() {
    echo ""
    echo "========================================="
    echo "  MCP 服务器安装脚本"
    echo "  来源: .claude/settings.local.json (project-local)"
    echo "========================================="
    echo ""

    check_deps

    # 安装 4 个 MCP 服务器
    install_mcp "context7"   "@upstash/context7-mcp@latest"
    install_mcp "sequential" "@modelcontextprotocol/server-sequential-thinking@latest"
    install_mcp "magic"      "@21st-dev/magic@latest"
    install_mcp "playwright" "@playwright/mcp@latest"

    echo ""
    echo "========================================="
    log_info "安装完成，验证连接状态..."
    echo ""
    claude mcp list
    echo ""
    log_warn "注意：Magic MCP 需要 API Key，首次使用时按提示配置"
    echo "========================================="
    echo ""
}

main "$@"
