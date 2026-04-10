# Interview Assets

这一层专门服务于两个目标：

1. 基于你的简历生成更拟真的面试问题
2. 让回答尽量落在你已经学过、看过、做过或实践过的知识范围内

## 文件说明

- `resume_concept_bridge.md`
  - 把简历中的核心条目映射到 `ready/` 和原始项目资料
- `answer_generation_rules.md`
  - 约束后续如何生成“你不会陌生”的回答
- `question_bank.md`
  - 拟真问题库，按项目背景、RAG、Agent、SFT、GRPO、Memory、MCP 等分类
- `followup_trees.md`
  - 高频主问题的真实追问链，避免只生成一堆离散题
- `sample_answers.md`
  - 口径校准答案，确保后续回答更贴近你学过的表达方式
- `knowledge_gaps.md`
  - 明确哪些内容不该从课程资料里硬补

## 使用顺序

1. 先看 `persistent_user_constraints.md`
2. 再看 `resume_summary.md`
3. 再看 `resume_concept_bridge.md`
4. 然后用 `question_bank.md` 生成或挑选面试题
5. 再用 `followup_trees.md` 把主问题扩展成真实追问
6. 回答时严格遵守 `answer_generation_rules.md`
7. 用 `sample_answers.md` 校准口径
8. 遇到边界问题，参考 `knowledge_gaps.md`

## 这一层和其他层的关系

- `agent_knowledge/`：面向简历和面试的总清洗层
- `ready/`：预处理后的主题知识层
- `agent资料/`：原始课程与项目材料

## 核心原则

- 问题必须贴合你的简历，而不是只贴合课程
- 回答优先使用你学过的概念，而不是引入陌生高级术语
- 如果一个概念只在课程里学过，没有工作项目直接支撑，回答时应明确成“实践过 / 学过 / 用 Demo 做过”
