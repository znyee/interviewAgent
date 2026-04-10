# Project Card 03: LangGraph Finance Agent

## 来源目录

- `D:\code\agent_data\agent资料\S4-agent开发\Agent第三周\Agent3`

## 已核实的事实

- 项目基于 FastAPI + LangGraph。
- README 明确给出 Router、Planner、Executor、Reflector、Critic 这套工作流角色。
- 工具层包含 Text2SQL、代码执行器、PDF 解析、Web 搜索、RAG 搜索。
- `agents/graph.py` 使用 `StateGraph`，并启用 `MemorySaver` checkpointer。
- API 路由包含 `/api/chat`、`/api/sql/query`、`/api/code/execute`、`/api/search`、`/api/rag/search`、`/api/upload/pdf` 等。
- 内置 SQLite + SQLAlchemy 数据层，面向金融分析演示。

## 这个项目能支撑你回答什么

- LangGraph 和普通链式调用的差别。
- Tool Schema / Tool Registry 如何支撑多工具 Agent。
- Text2SQL、代码执行、RAG 和 Web 搜索如何在一个图里协同。
- 为什么需要 Reflector / Critic 这类反思节点。

## 和简历的关系

- 强支撑：`Tool Schema`、`多工具编排`、`LangGraph`。
- 中支撑：`Function Calling` 与 `ReAct` 的工程化落地理解。

## 回答时的推荐话术

- `我做过把工具能力抽象成统一接口，再由图工作流决定路由和执行顺序。`
- `LangGraph 的价值在于状态可追踪、节点职责清晰，适合复杂多步任务。`

## 不要夸大的点

- 这是金融分析场景 Demo，不要直接说成你的测试平台就是这套代码。
- `MemorySaver` 说明你理解会话记忆，但不等于生产级长期记忆已经完成。
