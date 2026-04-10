# Project Card 06: MCP Examples

## 来源目录

- `D:\code\agent_data\agent资料\S2-系统训练营\7-agent智能体\mcp-stage3\mcp-stage3\mcp-stage3\mcp-stage3`
- `D:\code\agent_data\agent资料\S2-系统训练营\7-agent智能体\media-mcp\media-mcp\Redbook-Search-Comment-MCP2.0`

## 已核实的事实

- `mcp-stage3` 明确展示了 `LLM + MCP` 自动化工具调用。
- 核心点是自动从 MCP 服务器发现工具定义，而不是手工维护工具描述。
- 文档明确提到 Function Calling、动态系统提示词和 Serper 搜索。
- `media-mcp` 是一个基于 Playwright 的 MCP Server，用于小红书搜索、内容获取和评论发布。
- `media-mcp` 强调的是 MCP Server 接入方式、结构化结果返回和客户端侧 AI 生成评论。

## 这个项目能支撑你回答什么

- MCP 和普通手写 Tool Schema 的区别。
- 什么是工具发现，为什么 MCP 可以降低客户端维护成本。
- MCP Server 和 MCP Client 各自负责什么。
- MCP 更适合什么场景，不适合什么场景。

## 和简历的关系

- 中支撑：`MCP` 这项技能本身。
- 弱支撑：工作主项目里的具体生产架构。

## 回答时的推荐话术

- `我学习并实践过 MCP，理解它把工具暴露、发现和调用协议标准化的价值。`
- `如果是小规模固定工具集，手写 Tool Schema 也够；如果希望客户端零维护扩展，MCP 更有优势。`

## 不要夸大的点

- 当前材料更偏 Demo 和接入实践。
- 除非你真实工作项目里用了 MCP，否则不要说成你主项目核心架构。
