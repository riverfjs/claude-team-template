# claude-team-template

Claude Code 多智能体团队模板。Clone 即用，无需任何额外配置 — Agent、MCP、HUD 全部预置。

## 快速开始

```bash
git clone git@github.com:riverfjs/claude-team-template.git my-project
cd my-project
CLAUDE_CONFIG_DIR=.claude CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

启动后用 `/build` 命令开始：

```
/build a simple todo web app with user auth
```

> `CLAUDE_CONFIG_DIR=.claude` 让 Claude 使用项目内的 `.claude/` 作为配置目录，而不是 `~/.claude/`，agent、设置、插件、MCP 全部在项目内生效，不影响全局配置。

## 使用方式

| 命令 | 说明 |
|------|------|
| `/build <任务描述>` | 启动完整 Agent 团队完成任务。这是使用此模板的主要方式。|

`/build` 命令强制走完整团队流水线，无论任务大小：

```
Phase 1（并行）:  product-manager → PRD    +  architect → 技术方案
Phase 2（并行）:  frontend → UI 代码       +  backend → API 代码
Phase 3:          qa → 验证并修复
Phase 4（可选）:  devops → 部署
```

## 开箱即用

以下全部预配置好，无需额外设置：
- **7 个专属 Agent** — PM、架构师、前端、后端、运维、QA、项目经理
- **4 个 MCP 服务** — context7、sequential、magic、playwright
- **Claude HUD** — 实时状态栏，显示上下文用量、Agent 状态、待办进度
- **工作区** — 首次 prompt 时自动创建

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
