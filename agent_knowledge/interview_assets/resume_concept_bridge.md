# Resume Concept Bridge

这个文件把你的简历条目，和你已经学习过的知识主题连起来。

目标是让后续问题和回答都满足两个条件：

1. 问题看起来像针对你简历问的
2. 回答里的知识点又尽量来自你熟悉的材料

## 1. 主项目总览

### 简历主项目

- 基于 RAG + Function Calling 的游戏智能测试 Agent 平台

### 面试官最可能深挖的 6 条主线

1. 为什么要做这个 Agent 平台
2. RAG 知识层怎么设计
3. Tool Schema / ReAct 工作流怎么编排
4. 为什么 Prompt 不够，后来要做 Function Calling SFT
5. 为什么在 SFT 之后还要探索 GRPO
6. 如果继续做，你会不会上 Multi-Agent / Memory / MCP

---

## 2. 简历条目到知识主题的映射

| 简历条目 | 建议使用的熟悉知识点 | 主要来源 | 推荐表述强度 |
|---|---|---|---|
| 两阶段 DataAgent + RAG 知识层 | 离线解析、在线召回、两阶段三模块、分块、向量化、混合检索、重排、上下文压缩、自适应检索 | `ready/topics/0012__s4-agent-01-rag.md` `ready/topics/0002__s2-llm-05-rag.md` `ready/topics/0081__rag-11-embedding-model-rerank.md` `ready/topics/0085__tf-idf-bm25.md` | 强 |
| 混合检索、Query Rewrite、Metadata Filtering、Rerank | BM25、稠密向量、Cross-Encoder、规则重排、元数据过滤、查询改写 | `ready/topics/0002__s2-llm-05-rag.md` `ready/topics/0081__rag-11-embedding-model-rerank.md` `ready/topics/0085__tf-idf-bm25.md` | 强 |
| Tool Schema 抽象与 Agent 工作流 | tool list、结构化输出、ReAct、plan/act/observe/reflect、prompt chain、multi-tool chain | `ready/topics/0013__s4-agent-02-agent.md` `ready/topics/0091__agent-1.md` | 强 |
| Function Calling SFT | 提示词写到极致仍出错、挑错函数、重复调用、参数抽取错误、数据构造、评估闭环 | `ready/topics/0093__agent-7-function-call.md` `ready/topics/0104__13-function-calling.md` `project_cards/05_tool_call_training.md` | 强 |
| LoRA 微调 | 可训练参数、rank r、token/LoRA-param、数据规模、早停 | `ready/topics/0099__7-lora.md` `ready/topics/0100__8-token-lora-param.md` | 强 |
| GRPO 对齐探索 | 组内相对奖励、无需单独 value model、KL 惩罚、SFT 后继续优化多步任务 | `ready/topics/0107__rl-grpo.md` `ready/topics/0018__trl-deepseek-r1-grpo.md` | 中 |
| 多智能体 / 调度 | 单 Agent 到 Multi-Agent、上下文隔离、分治与压缩、orchestrator-worker | `ready/topics/0013__s4-agent-02-agent.md` `project_cards/02_deep_research_agent.md` | 中 |
| 记忆系统 | working memory、persistent memory、写入-管理-读取、用户画像、时间衰减、摘要与召回 | `ready/topics/0014__s4-agent-04.md` `ready/topics/0082__rag-12.md` `ready/topics/0108__agent-04.md` | 中 |
| MCP | MCP client/server、list tools、stdio/HTTP、组件化、工具隔离 | `ready/topics/0006__s2-llm-07-agent-mcp.md` `project_cards/06_mcp_examples.md` | 中 |
| Transformer / MoE 基础 | Attention、FFN、残差、位置编码、多头注意力、MoE | `ready/topics/0001__s2-llm-02-transformer-moe.md` | 弱到中 |

---

## 3. 回答时优先使用的“熟悉词”

这些词你在材料里反复见过，后续回答应优先使用它们，而不是替换成你没见过的术语。

### RAG 方向

- 离线解析
- 在线召回
- 两阶段三模块
- 混合检索
- BM25
- Cross-Encoder
- Query Rewrite
- Metadata Filtering
- 上下文压缩
- 自适应检索

### Agent 方向

- workflow
- tool list
- 结构化输出
- ReAct
- prompt chain
- reflect / reflection
- 调度者 / workers
- 单 Agent / Multi-Agent

### Function Calling / SFT 方向

- 挑错函数
- 重复调用
- 参数抽取
- 链式调用中断
- 轨迹数据
- 训练闭环
- 评估闭环

### LoRA / RL 方向

- LoRA rank
- 可训练参数
- token / LoRA-param
- 早停
- 奖励设计
- KL 惩罚
- 组内相对奖励

### Memory / MCP 方向

- working memory
- persistent memory
- 写入 / 管理 / 读取
- 时间衰减
- 用户画像
- client / server
- list tools

---

## 4. 简历问题和知识来源的组合方式

### 如果问题偏“项目怎么做”

- 先从简历项目出发
- 再用 `0012 / 0013 / 0014 / 0093 / 0104 / 0107` 这些 ready 主题补方法论
- 最后落回你简历里的指标和改进结果

### 如果问题偏“原理为什么”

- 先用 `ready/` 的主题化知识解释概念
- 再说这个概念在你主项目里怎么用

### 如果问题偏“为什么选择这个方案”

- 优先用 trade-off 来答
- 例如：
  - RAG vs 纯 Prompt
  - 混合检索 vs 纯向量
  - SFT vs 只调提示词
  - GRPO vs 停留在 SFT
  - Single Agent vs Multi-Agent

---

## 5. 需要特别保守的条目

以下条目如果被问到，必须回到真实经历，不应只靠课程内容补。

- OCR / ASR / 视频理解的真实落地细节
- 公司内部 35+ Django API 的真实接口治理方式
- 线上并发规模、QPS、机器配置、成本
- 真实数据集规模、标注成本、训练时长
- 公司内部评测平台或发布流程的真实形态
