# Sample Answers

这个文件不是标准答案库，而是“口径校准集”。

目标是让后续生成的回答更像你已经学过、也更容易顺口说出来的版本。

## Q1 项目核心解决了什么问题？

### 参考回答

我理解这个项目核心解决的是两个问题。第一，测试知识比较分散，很多信息散在文档、历史用例和接口说明里，测试同学做分析时先要花很多时间找资料。第二，光把资料找出来还不够，后面还涉及工具调用、结果判断和建议生成，这其实是一个多步链路。

所以这个场景如果只做普通问答，我觉得是不够的。普通问答更适合单轮解释类问题，但我的项目更需要把检索、工具调用和后续决策串起来。我们当时的思路是前面用 RAG 把相关知识尽量召回出来，中间把内部能力抽象成 Tool Schema，再配合 ReAct 这种 workflow 去做“思考、调用、观察、再决策”。

所以我会把这个项目理解成，RAG 负责先把知识找对，工具调用负责把动作做对，Agent 编排负责把整条链路串起来。这也是为什么我没有把它当成一个普通问答系统，而是把它当成一个 Agent 平台来做。

### 主要来源

- `resume_summary.md`
- `ready/topics/0012__s4-agent-01-rag.md`
- `ready/topics/0013__s4-agent-02-agent.md`

## Q2 为什么做混合检索，而不是只做向量检索？

### 参考回答

在我的测试 Agent 场景里，纯向量检索对一些关键术语、版本号、接口名这类 lexical 信号不够稳，语义接近不代表一定命中真正有用的文档。混合检索的思路就是让 BM25 补关键词命中，让向量检索补语义召回，两边一起做候选集，再结合 Metadata Filtering 和 Rerank 把结果压得更准。这个方案的代价是链路更复杂、延迟和调参成本会更高，但它对企业知识库和测试场景会更稳，也更容易解释 Recall@10 和 MRR 为什么能一起提升。

### 主要来源

- `ready/topics/0002__s2-llm-05-rag.md`
- `ready/topics/0085__tf-idf-bm25.md`
- `ready/topics/0081__rag-11-embedding-model-rerank.md`

## Q3 把 35+ Django API 抽象成 Tool Schema 的价值是什么？

### 参考回答

我理解这件事的核心价值不是“接口换个名字”，而是把内部能力统一成模型能稳定路由的工具接口。如果不先做 Tool Schema，很多调用规则都会堆在 Prompt 里，工具一多就容易失控，后面也很难评估到底是模型没理解意图，还是接口定义本身不清楚。抽象成 Tool Schema 以后，工具列表、参数约束、返回结构都会更清晰，既方便 ReAct 这种“思考 - 调用 - 观察 - 再决策”的 workflow，也方便后面做 Function Calling SFT 和离线评估。

### 主要来源

- `resume_summary.md`
- `ready/topics/0013__s4-agent-02-agent.md`
- `ready/topics/0091__agent-1.md`

## Q4 为什么 Prompt 写得很细了，Function Calling 还是会出错？

### 参考回答

这个问题我会从错误类型来答，而不是只说“模型不够强”。在多工具场景里，常见问题其实很具体，比如挑错函数、参数抽取不完整、重复调用，或者上一轮已经走偏了，下一轮还沿着错误意图继续走。Prompt 可以缓解一部分问题，但它对多轮链式调用的约束还是偏软，尤其是工具多、参数复杂的时候，模型很容易出现格式对了但行为不对的情况。所以我们后面才会往 Function Calling SFT 这条路走，希望把“选什么工具、怎么填参数、什么时候停”学得更稳定。

### 主要来源

- `ready/topics/0093__agent-7-function-call.md`
- `ready/topics/0104__13-function-calling.md`
- `project_cards/05_tool_call_training.md`

## Q5 你们怎么构造 Function Calling SFT 数据？

### 参考回答

我会把这类数据理解成工具调用轨迹数据，而不是单轮问答数据。正样本是正确的工具链路，负样本会覆盖几类典型错误，比如挑错函数、漏参数、错参数、重复调用，还有多轮场景里的意图切换错误。这样做的原因是，我们要教模型的不只是输出一个 JSON，而是学会完整链路里的选择和停止条件。数据构造之后，还要配合人工校验和离线评估闭环去看格式可解析率、工具选择准确率、参数 EM，以及最后任务有没有真正执行成功。

### 主要来源

- `resume_summary.md`
- `project_cards/05_tool_call_training.md`
- `ready/topics/0093__agent-7-function-call.md`
- `ready/topics/0104__13-function-calling.md`

## Q6 为什么你们选 LoRA，而不是全量微调？

### 参考回答

我会把这个选择理解成一个工程 trade-off。我们的目标不是把模型整体能力重练一遍，而是针对工具调用这种比较结构化的能力做适配，所以 LoRA 会更合适。它的可训练参数更少，训练成本更低，迭代速度更快，也更适合做多轮数据实验和离线评估闭环。全量微调不是一定不行，但在数据量和资源都有限的时候，LoRA 更容易先跑出稳定基线。实际做的时候我会更关注 rank、插入层、训练和验证 loss 走势，以及数据量不够时怎么避免过拟合。

### 主要来源

- `ready/topics/0099__7-lora.md`
- `ready/topics/0100__8-token-lora-param.md`
- `project_cards/05_tool_call_training.md`

## Q7 为什么做完 SFT 之后还要探索 GRPO？

### 参考回答

我理解 SFT 更像先把格式和基本策略教会模型，比如该怎么选工具、怎么填参数、怎么按规范输出。但到了多工具链路和多步任务上，只学“像训练集一样输出”还不够，因为真正影响效果的是整条链路最后有没有完成、有没有多余调用、结果是不是可信。GRPO 这类方法更适合把任务结果反馈进来，用组内相对奖励去优化整体行为。这里我会保守表述成“探索和预研”，因为它更偏后续优化方向，不会直接说成已经完全线上成熟落地。

### 主要来源

- `resume_summary.md`
- `ready/topics/0107__rl-grpo.md`
- `ready/topics/0106__rl-dpo.md`

## Q8 MCP 和普通 Function Calling 的区别是什么？

### 参考回答

如果用一句工程化的话来区分，我会说 Function Calling 更偏模型侧的“怎么选工具”，而 MCP 更偏系统侧的“怎么把工具标准化接进来”。前者重点是模型理解工具描述、选择合适函数并填参数，后者重点是 client/server 解耦、工具发现和跨语言复用。所以在我这里，Function Calling 更适合回答主项目里的工具调用链路，MCP 更适合作为后续扩展能力去理解协议化接入，而不是直接说成主项目核心方案。

### 主要来源

- `ready/topics/0006__s2-llm-07-agent-mcp.md`
- `project_cards/06_mcp_examples.md`
- `knowledge_gaps.md`
