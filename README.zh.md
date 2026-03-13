# claude-team-template

Claude Code 多智能体团队模板。Clone 即用，无需任何额外配置 — Agent、MCP、HUD 全部预置。

## 工作原理

当你描述一个功能或产品需求，Claude 自动：

1. 组建团队（`TeamCreate`）
2. 并行启动 **product-manager-agent** + **architect-agent**
3. 两者完成后，并行启动 **frontend-agent** + **backend-agent**（按需）
4. 运行 **qa-agent** 验证并修复 bug
5. 关闭所有 agent，清理资源

不需要记任何 slash command，不需要问"要不要启动团队" — 直接开始。

## 使用方式

```bash
git clone git@github.com:riverfjs/claude-team-template.git my-project
cd my-project
CLAUDE_CONFIG_DIR=.claude CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

> `CLAUDE_CONFIG_DIR=.claude` 让 Claude 使用项目内的 `.claude/` 作为配置目录，而不是 `~/.claude/`，agent、设置、插件、MCP 全部在项目内生效，不影响全局配置。

开箱即用，已预置：
- **7 个专属 Agent** — 开箱即用
- **MCP 服务** — context7、sequential、magic、playwright 已配置
- **Claude HUD** — 实时状态栏，显示上下文用量、agent 状态、待办进度
- **工作区** — 首次 prompt 时自动创建 `workspace/` 子目录

## Agent 列表

| Agent | 职责 |
|-------|------|
| `product-manager-agent` | 编写 PRD 和验收标准 |
| `architect-agent` | 设计文件结构、数据契约、API 规范 |
| `frontend-agent` | 根据规范构建 UI |
| `backend-agent` | 根据规范构建 API 和服务 |
| `devops-agent` | CI/CD、Docker、基础设施 |
| `qa-agent` | 对照 PRD 验证、修复 bug、决定是否发布 |
| `project-manager-agent` | 多周项目的任务追踪 |

## 工作区结构

每个 Agent 写入各自目录：

```
workspace/
├── product-manager/   ← PRD 和需求文档
├── architect/         ← 架构和 API 规范
├── frontend/          ← 前端源码
├── backend/           ← 后端源码
├── devops/            ← CI/CD 配置
└── qa/                ← 测试报告
```

## MCP 服务

| 服务 | 用途 |
|------|------|
| context7 | 库文档和最佳实践查询 |
| sequential | 多步骤推理 |
| magic | UI 组件生成 |
| playwright | 浏览器自动化和 E2E 测试 |

## 环境要求

- Claude Code
- Node.js ≥ 18


## License

MIT
