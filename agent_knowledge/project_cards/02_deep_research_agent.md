# Project Card 02: Deep Research Agent

## 来源目录

- `D:\code\agent_data\agent资料\S4-agent开发\第二周：deep_research\deep_research`

## 已核实的事实

- 核心类名是 `DeepResearchAgent`。
- 项目采用 Orchestrator-Workers 架构。
- 文档明确包含 OODA 循环、查询类型分类、动态 Worker 调度、来源质量评估、质量阈值和迭代优化。
- `api.py` 提供 `/research`、`/research/{task_id}`、`/research/{task_id}/result`、`/research/{task_id}/stream` 等接口。
- 文档强调 Markdown 报告生成、SSE 流式进度和自动质量检查。

## 这个项目能支撑你回答什么

- 多智能体系统里 orchestrator 和 worker 如何分工。
- 为什么研究类 Agent 需要任务拆解、并行搜索和质量复查。
- OODA 在 Agent 执行链中的作用。
- 如何做研究任务的状态管理和流式进度返回。

## 和简历的关系

- 强支撑：`多步任务拆解`、`工具调用工作流`、`研究/分析型 Agent`。
- 中支撑：`反思纠错`、`质量门控`。

## 回答时的推荐话术

- `我对 orchestrator-worker 这种拆解方式比较熟，适合把复杂任务分成多个并行子问题。`
- `在这类 Agent 里，难点不是会不会搜，而是怎么控制质量、边界和迭代次数。`

## 不要夸大的点

- 这是课程项目，回答时应说成 `我实践过` 或 `我系统实现过 Demo`。
- 如果你的工作项目不是研究型 Agent，不要把业务场景直接等同。
