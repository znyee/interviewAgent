# Resume-Grounded Question Bank

这个问题库不是泛化八股，而是针对你的简历主项目和你学过的知识来设计的。

每个问题都包含：

- 面试官为什么会问
- 主要知识来源
- 回答必须出现的点
- 不建议扩展的点

推荐搭配方式：

- 用 `question_bank.md` 选主问题
- 用 `followup_trees.md` 生成连续追问
- 用 `sample_answers.md` 校准回答口径

---

## A. 项目背景与整体设计

### Q01 你的这个游戏智能测试 Agent 平台，核心解决了什么问题？

- 面试官意图：确认你是否真正理解业务痛点，而不是只会堆技术名词
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0012__s4-agent-01-rag.md`
- 回答必须出现：
  - 测试知识分散
  - 用例编写低效
  - 风险评审依赖人工经验
  - 平台希望把知识检索、工具调用和建议生成串起来
- 不建议扩展：
  - 不要凭空补线上调用规模

### Q02 为什么这个场景不是普通问答系统，而要做 Agent？

- 面试官意图：区分你是否理解 Agent 和普通 LLM/RAG 的边界
- 主要来源：
  - `ready/topics/0012__s4-agent-01-rag.md`
  - `ready/topics/0013__s4-agent-02-agent.md`
- 回答必须出现：
  - 普通问答只适合单轮生成
  - 你的场景需要流程、工具和结果回写
  - Agent 更适合端到端完成复杂任务
- 不建议扩展：
  - 不要直接把课程里的银行案例说成你的工作案例

### Q03 你这个平台的整体链路怎么拆？

- 面试官意图：看系统设计能力
- 主要来源：
  - `resume_summary.md`
  - `project_cards/01_rag_milvus.md`
  - `project_cards/05_tool_call_training.md`
- 回答必须出现：
  - 知识层
  - 工具层
  - Agent 编排层
  - 评估或结果回写
- 不建议扩展：
  - 不要杜撰完整微服务图

### Q04 简历里写的“两阶段 DataAgent + RAG 知识层”具体怎么理解？

- 面试官意图：看你是不是自己写的简历
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0012__s4-agent-01-rag.md`
  - `ready/topics/0002__s2-llm-05-rag.md`
- 回答必须出现：
  - 离线解析 / 入库
  - 在线召回 / 组装上下文
  - 检索前和检索后的优化点
- 不建议扩展：
  - 不要把课程里的全部 20 个 RAG 优化点都堆进去

---

## B. RAG 与检索优化

### Q05 为什么你们做混合检索，而不是只做向量检索？

- 面试官意图：看你是否理解关键词命中和语义召回的互补
- 主要来源：
  - `ready/topics/0002__s2-llm-05-rag.md`
  - `ready/topics/0085__tf-idf-bm25.md`
  - `ready/topics/0012__s4-agent-01-rag.md`
- 回答必须出现：
  - 纯向量检索对关键术语、版本号、专有名词不稳定
  - BM25 / 关键词检索能补 lexical 信号
  - 混合检索更适合企业知识和测试场景
- 不建议扩展：
  - 不要随口说具体融合权重，除非你确定

### Q06 你怎么理解 chunk size 的选择？

- 面试官意图：看你是否做过实际检索调优
- 主要来源：
  - `ready/topics/0002__s2-llm-05-rag.md`
- 回答必须出现：
  - chunk 太大：语义不准、噪声大
  - chunk 太小：信息不完整
  - overlap 的作用
  - 需要靠评估集选
- 不建议扩展：
  - 不要编造你们具体的 chunk 参数

### Q07 Query Rewrite 在你们场景里解决了什么问题？

- 面试官意图：看你是否理解“用户表达”和“知识表达”的落差
- 主要来源：
  - `ready/topics/0002__s2-llm-05-rag.md`
- 回答必须出现：
  - 用户问题不一定和知识库表述一致
  - 查询改写可以做语义补全、子问题拆解或术语标准化
  - 长尾问题和多轮上下文时更有价值
- 不建议扩展：
  - 不要把所有 query rewrite 都说成必须

### Q08 重排和 Metadata Filtering 在链路里各自做什么？

- 面试官意图：看你是否理解检索链路是多段优化
- 主要来源：
  - `ready/topics/0002__s2-llm-05-rag.md`
  - `ready/topics/0081__rag-11-embedding-model-rerank.md`
- 回答必须出现：
  - metadata filtering 是前置约束
  - rerank 是候选结果再排序
  - Cross-Encoder 适合精排但有成本
- 不建议扩展：
  - 不要把 metadata filtering 和 rerank 混成一件事

### Q09 你怎么解释 Recall@10 和 MRR 的提升？

- 面试官意图：看你是否理解评估指标，而不是只会背数字
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0002__s2-llm-05-rag.md`
- 回答必须出现：
  - Recall@10 关注前 10 个候选里能不能召回正确内容
  - MRR 更关注正确结果排得靠不靠前
  - 提升通常来自召回和排序同时变好
- 不建议扩展：
  - 不要把离线指标说成线上最终效果

### Q10 你们是怎么处理长尾问题和多轮上下文的？

- 面试官意图：看检索系统是否只对简单问题有效
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0002__s2-llm-05-rag.md`
- 回答必须出现：
  - Query Rewrite
  - 上下文组装
  - 重排 / 过滤
  - 多轮对话中的历史信息利用
- 不建议扩展：
  - 不要编造成熟长期记忆，除非明确说是探索

---

## C. Tool Schema 与 Agent 工作流

### Q11 你说把 35+ Django API 抽象成 Tool Schema，这件事的核心价值是什么？

- 面试官意图：看你是否理解“工具抽象”而不是只会调接口
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0013__s4-agent-02-agent.md`
- 回答必须出现：
  - 把内部能力统一成可路由的工具接口
  - 降低 Prompt 层复杂度
  - 便于评估和训练工具调用
- 不建议扩展：
  - 35+ 这个数字保持简历口径，不要继续外推

### Q12 你的 ReAct 工作流具体怎么理解？

- 面试官意图：看你是否真的理解 ReAct，而不是把它当 buzzword
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0013__s4-agent-02-agent.md`
- 回答必须出现：
  - 思考 / 调工具 / 观察结果 / 再决策
  - 适合多步问题
  - 比单次生成更可控
- 不建议扩展：
  - 不要把所有流程都答成一个大 prompt

### Q13 Single Agent 和 Multi-Agent 你怎么取舍？

- 面试官意图：看你是否理解系统复杂度控制
- 主要来源：
  - `ready/topics/0013__s4-agent-02-agent.md`
  - `project_cards/02_deep_research_agent.md`
- 回答必须出现：
  - 单 Agent 简单、成本低
  - Multi-Agent 适合复杂任务拆解和上下文隔离
  - 不是 Agent 越多越好
- 不建议扩展：
  - 如果工作项目不是多 Agent，就不要说成已经全面落地

### Q14 为什么你们需要“结果回写 / 反思纠错”？

- 面试官意图：看你是否考虑过错误恢复
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0013__s4-agent-02-agent.md`
  - `ready/topics/0002__s2-llm-05-rag.md`
- 回答必须出现：
  - 工具调用可能失败或结果不完整
  - 检索结果可能不够回答问题
  - 需要形成闭环而不是一次性生成
- 不建议扩展：
  - 不要讲成复杂自监督系统，除非你真的做过

---

## D. Function Calling、SFT 与 LoRA

### Q15 为什么 Prompt 写到极致了，Function Calling 还是会出错？

- 面试官意图：这是你简历里最关键的追问题之一
- 主要来源：
  - `ready/topics/0093__agent-7-function-call.md`
  - `ready/topics/0104__13-function-calling.md`
- 回答必须出现：
  - 挑错函数
  - 重复调用
  - 参数抽取不完整
  - 多轮意图切换时粘性错误
- 不建议扩展：
  - 不要只说“模型能力不够”，要说具体错法

### Q16 你们是怎么构造 Function Calling SFT 数据的？

- 面试官意图：看你是不是真的做过数据工程
- 主要来源：
  - `resume_summary.md`
  - `project_cards/05_tool_call_training.md`
  - `ready/topics/0093__agent-7-function-call.md`
- 回答必须出现：
  - 正样本：正确工具链路
  - 负样本：挑错函数、错参数、漏参数、重复调用
  - 多轮轨迹
  - 人工校验或迭代闭环
- 不建议扩展：
  - 不要编造具体标注平台

### Q17 你们怎么评估工具选择准确率和参数 EM？

- 面试官意图：看你是否有工程化评测意识
- 主要来源：
  - `resume_summary.md`
  - `project_cards/05_tool_call_training.md`
  - `ready/topics/0104__13-function-calling.md`
- 回答必须出现：
  - 格式是否可解析
  - 选的工具是否正确
  - 参数字段是否完整、值是否准确
  - 最终任务是否执行成功
- 不建议扩展：
  - 不要只讲一个总分

### Q18 为什么这个场景你们选 LoRA，而不是全量微调？

- 面试官意图：看你是否理解训练成本和收益
- 主要来源：
  - `ready/topics/0099__7-lora.md`
  - `ready/topics/0100__8-token-lora-param.md`
- 回答必须出现：
  - 可训练参数少
  - 训练成本低、迭代快
  - 更适合工具调用格式和特定能力适配
- 不建议扩展：
  - 不要强行说全量微调一定更差

### Q19 数据量不够时，LoRA 微调怎么做才不容易翻车？

- 面试官意图：看你是否知道微调的失败模式
- 主要来源：
  - `ready/topics/0099__7-lora.md`
  - `ready/topics/0100__8-token-lora-param.md`
- 回答必须出现：
  - 低 rank 建基线
  - 控制插入层
  - 观察训练/验证 loss
  - 早停和逐步扩数据
- 不建议扩展：
  - 不要把 batch size 当成数据量替代品

---

## E. GRPO 与对齐优化

### Q20 为什么做完 SFT 之后，你们还会继续探索 GRPO？

- 面试官意图：看你是否理解 SFT 和对齐的分工
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0107__rl-grpo.md`
- 回答必须出现：
  - SFT 更像学会格式和基本策略
  - 多步任务稳定性仍可能不够
  - GRPO 更适合用任务结果反馈优化行为
- 不建议扩展：
  - 不要把 GRPO 说成已经完全线上成熟落地

### Q21 如果是多工具链路，你会怎么设计奖励信号？

- 面试官意图：看你是否真的理解奖励设计，而不是只会背 GRPO 定义
- 主要来源：
  - `resume_summary.md`
  - `ready/topics/0107__rl-grpo.md`
- 回答必须出现：
  - 工具是否选对
  - 参数是否正确
  - 链路是否完成
  - 冗余调用是否惩罚
  - 引用或结果是否可信
- 不建议扩展：
  - 不要展开成复杂数学推导

### Q22 你怎么用一句话讲清楚 PPO、DPO、GRPO 的区别？

- 面试官意图：经典原理追问
- 主要来源：
  - `ready/topics/0107__rl-grpo.md`
  - `ready/topics/0106__rl-dpo.md`
- 回答必须出现：
  - PPO：在线强化学习，依赖 value 或 advantage 估计
  - DPO：基于偏好对数据，离线优化
  - GRPO：组内相对比较，简化 value model 依赖
- 不建议扩展：
  - 不要在这道题里长篇展开公式

---

## F. Memory 与 MCP

### Q23 如果后续继续做，你觉得这个测试 Agent 什么时候值得引入 Memory？

- 面试官意图：看你是否理解记忆系统不是装饰品
- 主要来源：
  - `ready/topics/0014__s4-agent-04.md`
  - `ready/topics/0108__agent-04.md`
- 回答必须出现：
  - 多轮会话
  - 用户偏好或历史上下文
  - 重要中间结果复用
  - 上下文窗口有限
- 不建议扩展：
  - 不要默认说你们线上已经完整上了长期记忆

### Q24 MCP 和普通 Function Calling，你怎么理解两者区别？

- 面试官意图：看你是否理解技能栏里的 MCP，不只是听说过
- 主要来源：
  - `ready/topics/0006__s2-llm-07-agent-mcp.md`
  - `project_cards/06_mcp_examples.md`
- 回答必须出现：
  - Function Calling 更偏模型侧工具选择
  - MCP 更偏协议化、组件化、client/server 解耦
  - MCP 适合工具发现和跨语言复用
- 不建议扩展：
  - 如果工作项目里没用 MCP，不要说成主项目核心方案

---

## G. 基础原理补充题

### Q25 为什么 Transformer 比 RNN / LSTM 更适合现在的大模型？

- 面试官意图：看你基础是否扎实
- 主要来源：
  - `ready/topics/0001__s2-llm-02-transformer-moe.md`
- 回答必须出现：
  - 并行计算
  - 长距离依赖
  - 多层堆叠
- 不建议扩展：
  - 不要答成论文背诵

### Q26 你怎么通俗解释 MoE？

- 面试官意图：看你是否能把原理讲清楚
- 主要来源：
  - `ready/topics/0001__s2-llm-02-transformer-moe.md`
- 回答必须出现：
  - 不是所有参数都激活
  - router 决定走哪些专家
  - 用更低激活成本换更高能力
- 不建议扩展：
  - 如果和你主项目无关，就别强行绑定工作经历
