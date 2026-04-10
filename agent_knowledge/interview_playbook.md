# Interview Playbook

用于后续生成模拟面试题、口语化回答、项目复盘时的统一规则。

开始任何任务前，默认先参考 `persistent_user_constraints.md`，不要把用户长期约束只留在对话上下文里。

## 回答顺序

1. 先说你在简历里真实做过的事。
2. 再补课程材料能支撑的实现细节。
3. 最后补权衡、问题和反思。

## 叙述强度规则

- `做过`：简历明确写出，并且知识库有高强度支撑。
- `实践过`：课程项目或 Demo 中做过，但不是你工作主项目的核心事实。
- `了解/学习过`：只有 Notebook、README 或实验资料支撑。

## 问答资产入口

- `interview_assets/resume_concept_bridge.md`：把简历条目和你熟悉的 `ready/` 知识点连起来。
- `interview_assets/question_bank.md`：提供主问题池，适合生成成组面试题。
- `interview_assets/followup_trees.md`：把主问题扩展成 3 到 5 轮的真实追问链。
- `interview_assets/answer_generation_rules.md`：约束回答风格，避免变成陌生术语堆砌。
- `interview_assets/sample_answers.md`：提供口径校准样例，优先复用这里的表达方式。
- `interview_assets/knowledge_gaps.md`：遇到边界问题时控制表述强度。

## 面试回答模板

### 项目题

- 背景：业务痛点是什么。
- 方案：整体链路怎么拆。
- 关键技术：RAG、工具调用、评测、训练、记忆分别怎么做。
- 难点：哪里不稳定，为什么 Prompt 不够。
- 结果：指标提升或效率收益。

### 原理题

- 先给一句定义。
- 再给你项目里怎么用。
- 再说 trade-off。

### 追问题

- 优先回答失败案例、调参过程、为什么换方案。
- 不要只说“效果更好”，要说为什么更好，代价是什么。

## 生成模拟面试题时的建议配比

- 70%：强绑定简历主项目
- 20%：课程项目补充题
- 10%：风险追问题

## 拟真追问规则

- 不要只给散题，优先按“主问题 + 1 到 2 轮深挖 + 1 轮风险追问”生成。
- 第一轮追问优先问实现链路，第二轮追问优先问 trade-off、失败模式或评估。
- 如果题目落在简历主项目上，至少要能回到 `RAG / Tool Schema / Function Calling SFT / LoRA / GRPO` 其中一条主线。
- 如果题目落在课程延伸能力上，必须明确它是“实践过 / 学过 / Demo 里做过”，不要伪装成主项目事实。

## 面试角色建议

- 一面偏项目还原：优先问业务痛点、链路设计、为什么这样拆。
- 技术深挖面偏方法论：优先问检索优化、工具调用、训练闭环和评估。
- 主管面偏判断力：优先问 trade-off、迭代优先级、边界和后续规划。

## 风险追问题建议覆盖

- 为什么不用纯 Prompt，非要做 SFT？
- 为什么要混合检索，不只用向量？
- 多轮工具调用为什么会失败？
- GRPO 奖励怎么设计，如何避免 reward hacking？
- MCP 和普通 Function Calling 的差别是什么？
- Memory 读写什么时候触发，如何防止脏记忆污染？

## 明确禁止

- 禁止把课程项目的演示指标说成工作项目线上指标。
- 禁止把 Demo 技术栈直接说成你所在公司的生产栈。
- 禁止补全未经确认的模型版本、QPS、机器配置、数据规模。

## 后续可直接复用的请求方式

### 生成模拟面试题

`请基于 agent_knowledge/resume_summary.md 和 agent_knowledge/resume_material_mapping.md，生成 20 道面试题，按基础/项目深挖/挑战追问分类。`

### 回答单题

`请基于 agent_knowledge 下的知识，回答“为什么 Function Calling 只靠 Prompt 不够稳定？”要求贴合我的简历项目。`

### 项目复盘

`请把我的主项目整理成 STAR 版本，重点突出 RAG、Tool Schema、SFT 和 GRPO。`

### 面试官追问

`请扮演面试官，连续追问我的 RAG + Function Calling 项目 10 轮，每轮只问一个问题。`

### 拟真问答一体化

`请基于 agent_knowledge/interview_assets/question_bank.md、agent_knowledge/interview_assets/followup_trees.md 和 agent_knowledge/interview_assets/sample_answers.md，围绕我的简历主项目做一场 8 轮拟真技术面试；每轮先提问，再给出一版贴近我已学习知识的参考回答。`
