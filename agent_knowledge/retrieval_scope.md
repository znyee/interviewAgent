# Retrieval Scope

这个文件定义后续回答问题时，应优先读哪些目录，默认忽略哪些噪声目录。

## 一级优先

- `D:\code\agent_data\简历-agent应用开发工程师.pdf`
- `D:\code\agent_data\agent_knowledge\`
- `D:\code\agent_data\ready\`
- `D:\code\agent_data\agent资料\S4-agent开发\第一周-RAG&向量数据库\RAG`
- `D:\code\agent_data\agent资料\S4-agent开发\第二周：deep_research\deep_research`
- `D:\code\agent_data\agent资料\S4-agent开发\Agent第三周\Agent3`
- `D:\code\agent_data\agent资料\S4-agent开发\Agent第四周-记忆\week4_project`
- `D:\code\agent_data\agent资料\S4-agent开发\第五周：train_project\train_project`

这些目录最适合支撑简历中的 RAG、Tool Calling、Multi-Agent、Memory、LoRA/SFT。

其中：

- `agent_knowledge/` 是“面向简历和面试的二次清洗层”
- `ready/` 是“面向知识检索的预处理主题层”

## 二级优先

- `D:\code\agent_data\agent资料\S2-系统训练营\5-RAG原理与核心组件`
- `D:\code\agent_data\agent资料\S2-系统训练营\7-agent智能体`
- `D:\code\agent_data\agent资料\S2-系统训练营\9-微调实战`
- `D:\code\agent_data\agent资料\S2-系统训练营\10-RLHF实战`
- `D:\code\agent_data\agent资料\S4-agent开发\industry_information_assistant\industry_information_assistant`
- `D:\code\agent_data\agent资料\S2-系统训练营\7-agent智能体\SalesPilot-main`

这些目录更适合补全概念、范式和额外案例，不应直接替代你的主项目叙述。

## 默认忽略

- 所有 `.jpg`、`.png`、`.svg`、`.pdf` 教学配图和截图
- 所有模型权重：`.safetensors`、大体积 `tokenizer/model` 文件夹
- 所有 `node_modules`、`dist`、打包产物
- 所有 `volumes`、Docker 数据目录、日志文件
- 所有 `.zip`、缓存、临时输出

## 默认优先读取的文件类型

- `agent_knowledge/persistent_user_constraints.md`
- `agent_knowledge/interview_assets/*.md`
- `ready/INDEX.md`
- `ready/manifest.json`
- `ready/topics/*.md`
- `ready/interview_qa_kb.md`
- `README.md`
- `docs/*.md`
- `requirements.txt`
- `main.py`、`api.py`、`routes.py`
- `graph.py`、`nodes.py`、`memory_pipeline.py`
- `scripts/*.py`
- `tests/*.py`
- Notebook 标题和目录名

## 问答时的读取顺序

1. 先看 `agent_knowledge/persistent_user_constraints.md`。
2. 再看 `agent_knowledge/resume_summary.md` 和 `agent_knowledge/resume_material_mapping.md`。
3. 如果任务是模拟面试题生成或面试问答，紧接着看 `agent_knowledge/interview_assets/*.md`。
4. 再看 `ready/` 的主题索引和对应 topic 文件。
5. 再根据问题落到对应项目卡片。
6. 只有需要更细源码细节时，才回到原始项目目录。
