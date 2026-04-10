# Project Card 04: Multi-Agent Memory System

## 来源目录

- `D:\code\agent_data\agent资料\S4-agent开发\Agent第四周-记忆\week4_project`

## 已核实的事实

- 项目包含 CEO、Researcher、Analyst、Critic 四类 Agent。
- `CEOAgent` 在执行前后会触发 Memory Read / Memory Write。
- `MemoryPipeline` 负责短期缓冲、长期记忆写入、用户画像和上下文压缩。
- 设计上同时使用 Redis 和 Milvus。
- README 和 `WEEK4_PLAN.md` 明确提出短期感官记忆、长期情景记忆、语义记忆这套分层。
- 提供 `/api/memory/add`、`/api/memory/query`、`/api/memory/dream`、`/api/memory/reflect`、`/api/memory/status` 等接口。
- `dreaming.py` 覆盖聚类、去重、矛盾检测、归档、生成 insight 等逻辑。

## 这个项目能支撑你回答什么

- Agent 为什么需要记忆，不只是上下文窗口。
- 短期记忆、长期记忆、语义记忆如何分层。
- Memory 读写在哪些时机触发。
- 如何处理记忆污染、重复、低价值历史。

## 和简历的关系

- 强支撑：`长期记忆`、`用户画像`、`Memory Pipeline`。
- 中支撑：`反思纠错`、`多 Agent 协作`。

## 回答时的推荐话术

- `我实践过把短期对话缓存和长期向量记忆拆开，执行时先读相关记忆，再在结果阶段回写。`
- `记忆系统的关键不是存进去，而是检索、压缩和防污染。`

## 不要夸大的点

- 更适合说 `课程项目里我实现过`。
- 如果面试官追问线上脏数据治理、TTL 和分布式一致性，要明确区分课程实现和真实生产经验。
