# Topic Taxonomy

这个文件把 `agent资料/` 中真正和你后续面试最相关的知识分层整理出来。

## A. 基础理论层

- 大模型基础：`S2-系统训练营/1-大模型基础速通`
- Transformer / MoE：`S2-系统训练营/2-手撕Transformer&MOE`

适合回答：

- Transformer 基本结构
- Attention / FFN / MoE 的理解
- 大模型训练与推理基础

## B. RAG 能力层

- RAG 原理与高级变体：`S2-系统训练营/5-RAG原理与核心组件/从零-RAG大师`
- RAG 项目实战：`S2-系统训练营/6-RAG项目实战`
- 周项目版 RAG 服务：`S4-agent开发/第一周-RAG&向量数据库/RAG`

可支撑主题：

- 分块策略
- 查询改写
- 重排序
- 上下文压缩
- 图 RAG / 分层检索 / 自适应 RAG
- Milvus 向量检索与服务拆分

## C. Agent 与工作流层

- Agent / MCP / 销售助手：`S2-系统训练营/7-agent智能体`
- Deep Research：`S4-agent开发/第二周：deep_research`
- LangGraph 多工具系统：`S4-agent开发/Agent第三周/Agent3`

可支撑主题：

- ReAct
- Orchestrator-Worker
- Tool Schema
- 多工具路由
- 多智能体协作
- MCP 的工具发现与客户端接入

## D. Memory 层

- 长期记忆项目：`S4-agent开发/Agent第四周-记忆/week4_project`

可支撑主题：

- 短期记忆 vs 长期记忆
- Redis + Milvus 分层记忆
- 用户画像
- 记忆检索与压缩
- Dreaming / Reflect / Memory GC

## E. 微调与工具调用训练层

- 微调实战：`S2-系统训练营/9-微调实战`
- 工具调用训练项目：`S4-agent开发/第五周：train_project/train_project`

可支撑主题：

- LoRA 微调
- 轨迹数据构造
- Function Calling SFT
- 训练前后评估闭环
- 工具调用格式约束

## F. RLHF / 对齐层

- RLHF 实战：`S2-系统训练营/10-RLHF实战`
- 急救营补充：`S3-急救营`

可支撑主题：

- PPO / DPO / GRPO 基本区别
- 奖励设计
- 对齐与多步决策稳定性

## 最适合贴合你简历的主线

建议后续所有问答优先围绕以下主线组织：

1. RAG 知识层
2. Tool Schema + ReAct 工作流
3. Function Calling SFT
4. GRPO/对齐探索
5. Multi-Agent / Memory 作为进阶话题
