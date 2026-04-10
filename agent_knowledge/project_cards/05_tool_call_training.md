# Project Card 05: Tool Calling Training Project

## 来源目录

- `D:\code\agent_data\agent资料\S4-agent开发\第五周：train_project\train_project`

## 已核实的事实

- 项目目标是从“问题 -> 工具 -> 答案”轨迹数据出发，完成数据生成、规范化、LoRA 训练、评估和复盘。
- `scripts/synthesize_trajectories_v3.py` 用教师模型生成多步工具调用轨迹。
- `scripts/validate_data_v2.py` 负责数据校验和统计。
- `scripts/02_train.py` 使用 LoRA 做训练。
- `scripts/quick_eval.py` 和 `scripts/full_eval.py` 分别做快速格式评估和完整评估。
- 训练文档明确提到 Qwen3-0.6B、Qwen3-1.7B、Qwen3-4B 三档模型。
- 工具集合至少包含 `search`、`visit`、`calculator`、`finish`。
- `reports/training_before_after_summary.md` 给出了训练前后在格式、工具调用和答案质量上的对比。

## 这个项目能支撑你回答什么

- 为什么 Function Calling 只靠 Prompt 不稳定，最终需要 SFT。
- 轨迹数据长什么样，为什么要统一 `<think> + <tool_call>{JSON}` 格式。
- LoRA 训练里为什么要关注 loss mask、max_length、batch 和梯度累积。
- 如何评估工具调用模型，不只看文本流畅度。

## 和简历的关系

- 强支撑：`Function Calling SFT`、`LoRA`、`训练/评估闭环`。
- 中支撑：`工具选择准确率`、`参数抽取稳定性` 这类评测思路。

## 回答时的推荐话术

- `我做过 Function Calling 训练数据构造，重点是轨迹格式统一、工具参数约束和负样本补充。`
- `我会把评估拆成格式、工具选择、答案质量三个层次，而不是只看最终回答。`

## 不要夸大的点

- 课程报告里的分数只能作为训练项目 Demo 的结果，不能替代你简历里的业务指标。
- 回答时应避免把银行对公场景训练集直接说成你工作里的测试数据集。
