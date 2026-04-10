# Ready KB

## 路径

- `D:\code\agent_data\ready`

## 定位

`ready/` 是一层已经整理过的知识库数据，适合后续问答直接检索。

它和 `agent资料/` 的关系是：

- `agent资料/` 偏原始课程资料、项目源码、Notebook、模型和附件
- `ready/` 偏整理后的主题化 Markdown 知识库
- `agent_knowledge/` 偏面向你简历和面试场景的二次清洗层

## 当前已确认的信息

- 入口文件：`ready/INDEX.md`
- 汇总问答库：`ready/interview_qa_kb.md`
- 结构化清单：`ready/manifest.json`
- 主题目录：`ready/topics`

根据 `ready/INDEX.md`：

- Total Ready Topics: 107
- Curated Document Topics: 71
- OCR Grouped Topics: 36

## 使用优先级

### 优先使用 `ready/` 的场景

- 原理题
- 八股题
- 学习路径总结
- 课程知识梳理
- 面试题生成

### 不应只依赖 `ready/` 的场景

- 需要精确源码细节的问题
- 需要确认接口、类名、文件路径的问题
- 需要确认你“真实做过什么”的问题

这类问题仍然要结合：

- `agent_knowledge/resume_summary.md`
- `agent_knowledge/resume_material_mapping.md`
- 原始源码目录

## 和简历场景的关系

`ready/` 最适合补以下主题：

- Transformer / Attention / MoE
- RAG 分块、召回、重排、Query Rewrite
- Agent 设计方法
- Function Calling
- LoRA / SFT
- DPO / GRPO / RLHF
- MCP
- 长期记忆与多智能体

## 问答规则

- 如果用户问“你学过什么”，优先参考 `ready/`
- 如果用户问“你项目里怎么做的”，优先参考 `agent_knowledge/` 和原始项目
- 如果用户问“这个概念和你项目怎么结合”，先从 `ready/` 提炼概念，再映射回简历项目

## 风险提醒

- `manifest.json` 中部分标题来自 OCR 或外部文档转换，命名可能不够稳定
- `ready/interview_qa_kb.md` 体积较大，适合检索，不适合每次全量读取
- 对精确数字、模型版本、实验结果，仍应以简历和原始项目材料为准
