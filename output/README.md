# Output Directory

这个目录用于存放后续生成的可直接交付内容，例如：

- 模拟面试题
- 模拟面试问答
- 项目复盘稿
- STAR 版本答案
- JD 定制问答

默认约定：

- 所有新生成内容优先放在 `output/`
- 文件名尽量使用可读、可排序的格式
- 如果内容依赖特定知识库口径，可在文件头标注来源
- 如果是简历/面试相关内容，生成前默认先参考 `agent_knowledge/persistent_user_constraints.md`
- 模拟面试问答默认使用 `问题 1 / 问题 2 / 问题 3` 格式

当前建议优先阅读：

- `agent_resume_interview_portable_kb.md`：可脱离当前机器单独使用的单文件知识库
- `mock_interview_questions_001-200.md`：当前全部可用的标准问题卷
- `interview_qa_core_001-011.md`：核心高频问题的参考问答稿
- `interview_followup_sample_001-005.md`：5 题连续追问示例
- `interview_index.md`：当前面试文件总索引

当前命名约定：

- `mock_interview_questions_001-200.md`：标准问题卷，按每 200 题分卷
- `interview_qa_core_001-011.md`：核心高频问题的问答稿
- `interview_followup_sample_001-005.md`：连续追问样例
- `interview_index.md`：索引说明
