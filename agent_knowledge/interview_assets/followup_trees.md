# High-Fidelity Follow-Up Trees

这个文件的目标不是增加题量，而是让模拟面试更像真实面试。

真实技术面通常不是连续抛 20 道散题，而是围绕一条主线连续追问 3 到 5 轮。

## 使用规则

1. 先从主问题起，不要直接跳到细节。
2. 如果回答偏空泛，下一轮追问实现链路。
3. 如果回答偏实现，下一轮追问 trade-off、失败模式或评估。
4. 一棵树最多追问 5 轮，避免偏离简历主线。

## Tree 1：项目总览链

### 主问题

你的游戏智能测试 Agent 平台，核心解决了什么问题？

### 追问链

1. 为什么这个场景不是普通问答，而要做 Agent？
2. 你把整条链路拆成了哪些层？
3. 你负责的核心模块具体是哪一段？
4. 这个平台最难做稳的点是什么？
5. 你怎么判断它确实比原来方案更好？

### 回答必须落回

- 测试知识分散
- 用例设计和风险评审依赖人工经验
- RAG 负责“找得到”
- Tool Schema / ReAct 负责“调得对”
- 评估闭环负责“结果可验证”

### 主要来源

- `resume_summary.md`
- `question_bank.md` 的 Q01 到 Q04
- `ready/topics/0012__s4-agent-01-rag.md`
- `ready/topics/0013__s4-agent-02-agent.md`

## Tree 2：RAG 优化链

### 主问题

为什么你们做混合检索，而不是只做向量检索？

### 追问链

1. 纯向量检索在你们场景里最容易错在哪里？
2. Query Rewrite 在这里起什么作用？
3. Metadata Filtering 和 Rerank 分别放在哪一层？
4. 你怎么解释 Recall@10 和 MRR 的提升？
5. 如果线上延迟受限，你会优先保留哪一层，为什么？

### 回答必须落回

- 测试场景存在术语、版本号、专有名词
- BM25 和向量检索互补
- Rewrite 解决“用户表达”和“知识表达”错位
- Filtering 是前置约束，Rerank 是候选重排
- 指标提升来自召回和排序共同优化

### 主要来源

- `question_bank.md` 的 Q05 到 Q10
- `ready/topics/0002__s2-llm-05-rag.md`
- `ready/topics/0081__rag-11-embedding-model-rerank.md`
- `ready/topics/0085__tf-idf-bm25.md`

## Tree 3：Tool Schema 与 Agent 工作流链

### 主问题

你们为什么要把 35+ Django API 抽象成 Tool Schema？

### 追问链

1. 如果不做 Tool Schema，直接靠 Prompt 写调用规则，会出现什么问题？
2. ReAct 在你们链路里具体怎么工作？
3. 多工具链式调用最容易失败的点是什么？
4. 你们为什么需要结果回写或反思纠错？

### 回答必须落回

- 把内部能力统一成可路由的工具接口
- 减少 Prompt 层硬编码
- 工具调用需要“思考 -> 调用 -> 观察 -> 再决策”
- 多步链路里容易出现错工具、漏参数、重复调用
- 闭环机制是为了解决失败恢复和结果校验

### 主要来源

- `question_bank.md` 的 Q11 到 Q14
- `ready/topics/0013__s4-agent-02-agent.md`
- `ready/topics/0091__agent-1.md`

## Tree 4：Function Calling SFT 链

### 主问题

为什么 Prompt 已经写得很细了，Function Calling 还是会出错？

### 追问链

1. 你们实际观察到的错误类型有哪些？
2. 这些问题为什么不能只靠继续调 Prompt 解决？
3. 你们是怎么构造 SFT 数据的？
4. 评估时你们怎么拆指标？
5. 为什么最后选 LoRA，而不是全量微调？

### 回答必须落回

- 挑错函数
- 参数抽取不完整
- 重复调用
- 多轮意图切换时的粘性错误
- 正负样本和多轮轨迹数据
- 工具选择准确率、参数 EM、链路完成率

### 主要来源

- `question_bank.md` 的 Q15 到 Q19
- `ready/topics/0093__agent-7-function-call.md`
- `ready/topics/0104__13-function-calling.md`
- `ready/topics/0099__7-lora.md`
- `ready/topics/0100__8-token-lora-param.md`
- `project_cards/05_tool_call_training.md`

## Tree 5：GRPO 与后续演进链

### 主问题

为什么在做完 SFT 之后，你们还会继续探索 GRPO？

### 追问链

1. 你觉得 SFT 已经解决了什么，还没解决什么？
2. 如果是多工具链路，你会怎么设计奖励？
3. 这类奖励最容易被模型钻什么空子？
4. 如果继续迭代，你会优先上 Memory、Multi-Agent 还是 MCP，为什么？

### 回答必须落回

- SFT 解决格式和基本策略
- 多步任务稳定性和整体成功率仍需要优化
- 奖励要覆盖工具选择、参数、完成度和冗余调用
- reward hacking 风险要控制
- Memory、Multi-Agent、MCP 更适合作为下一阶段能力演进

### 主要来源

- `question_bank.md` 的 Q20 到 Q24
- `ready/topics/0107__rl-grpo.md`
- `ready/topics/0106__rl-dpo.md`
- `ready/topics/0014__s4-agent-04.md`
- `ready/topics/0006__s2-llm-07-agent-mcp.md`
