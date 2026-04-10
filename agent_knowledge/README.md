# Agent Knowledge Base

这是一层为后续简历问答、模拟面试、项目复盘准备的“清洗后知识层”。

目标不是替代原始资料，而是把 `agent资料/` 中真正适合问答复用的部分抽出来，形成稳定、可检索、可对齐简历的上下文。

## 建议优先阅读

- `candidate_profile.json`
- `persistent_user_constraints.md`
- `resume_summary.md`
- `resume_material_mapping.md`
- `interview_playbook.md`
- `interview_assets/README.md`
- `retrieval_scope.md`
- `ready_kb.md`

## 项目卡片

- `project_cards/01_rag_milvus.md`
- `project_cards/02_deep_research_agent.md`
- `project_cards/03_langgraph_finance_agent.md`
- `project_cards/04_memory_multi_agent.md`
- `project_cards/05_tool_call_training.md`
- `project_cards/06_mcp_examples.md`

## 主题总览

- `topic_taxonomy.md`
- `knowledge_index.json`
- `ready_kb.md`

## 拟真面试资产

- `interview_assets/resume_concept_bridge.md`
- `interview_assets/answer_generation_rules.md`
- `interview_assets/question_bank.md`
- `interview_assets/followup_trees.md`
- `interview_assets/sample_answers.md`
- `interview_assets/knowledge_gaps.md`

## 使用原则

- 做模拟面试或改简历前，先读取 `candidate_profile.json`，把稳定事实、指标、关键词和禁止夸大的边界固定下来。
- 和简历、面试、项目复盘有关的任务，默认先读 `persistent_user_constraints.md`，把用户长期约束作为第一优先级。
- 回答简历相关问题时，先以 `resume_summary.md` 为主，再用项目卡片补细节。
- 生成模拟面试题时，优先使用 `interview_assets/question_bank.md` 和 `interview_assets/followup_trees.md`，保证问题既贴合简历，又有真实追问节奏。
- 回答模拟面试题时，优先使用 `interview_assets/answer_generation_rules.md` 和 `interview_assets/sample_answers.md`，保证口径贴近你已经学过的知识表达。
- 回答概念题、原理题、课程复盘题时，优先参考 `D:\code\agent_data\ready\` 这一层预处理主题库，再回看原始课程目录。
- 区分三种表述强度：
  - `做过`：简历已明确写出，且有材料支撑。
  - `实践过/搭过 Demo`：课程项目或 PoC 有材料支撑，但不是正式工作主项目。
  - `了解/学习过`：只有课程目录、Notebook 或实验材料支撑。
- 不要把课程项目指标直接冒充为简历项目线上收益。
- 对模型版本、精确数字、线上规模这类细节，若材料不稳定或简历提取不完整，优先使用保守表述。

## 当前清洗策略

- 保留：README、docs、脚本、核心源码入口、测试脚本、课程 Notebook 标题。
- 弱化：图片、打包产物、模型权重、依赖缓存、日志、Docker 卷数据。
- 明确标注“不宜夸大”的能力边界，避免后续生成面试答案时越界。
- 将 `ready/` 视为“预处理后的主题知识层”，默认优先级高于大部分原始课程文件。

## 关于 ready

- 路径：`D:\code\agent_data\ready`
- 角色：预处理后的面试知识库，不是原始源码目录。
- 适用场景：
  - 快速生成模拟面试题
  - 回答原理题和课程知识点题
  - 回答“我学过哪些知识、如何组织这些知识”这类问题
- 不足：
  - 更偏主题总结，不适合直接替代源码级实现细节
  - OCR 整理内容可能有噪声，涉及精确实现时仍要回原始项目目录核对
