# Interview Agent Workspace

这个仓库现在的定位不是通用资料归档，而是你的个人面试与简历协作工作区。

它主要服务 3 类任务：

1. 基于你的真实简历和项目经历做模拟面试
2. 基于你的知识库补齐技术细节、项目表述和回答口径
3. 针对目标 JD 调整简历、项目描述和 STAR 版本答案

## 核心原则

- 事实优先：先以简历和真实经历为准，再用知识库补实现细节
- 口径分级：区分 `做过`、`实践过/Demo`、`了解/学习过`
- 结果导向：每次任务都应该生成可复用输出，而不是只停留在对话里
- 轻仓库存储：原始大文件保留在本地，GitHub 只保留索引和说明

## 推荐使用顺序

### 做模拟面试

先看：

- `agent_knowledge/candidate_profile.json`
- `agent_knowledge/resume_summary.md`
- `agent_knowledge/resume_material_mapping.md`
- `agent_knowledge/interview_playbook.md`
- `playbooks/mock_interview_workflow.md`
- `prompts/mock_interview.md`

输出建议落到：

- `output/sessions/`

### 做 JD 定制改简历

先看：

- `agent_knowledge/candidate_profile.json`
- `agent_knowledge/resume_summary.md`
- `agent_knowledge/resume_material_mapping.md`
- `playbooks/resume_tailoring_workflow.md`
- `prompts/resume_tailoring.md`

把目标 JD 放到：

- `inputs/jd/`

输出建议落到：

- `output/resume_tasks/`

## 目录说明

- `agent_knowledge/`: 你的事实层、项目卡片、面试规则、简历映射
- `ready/`: 已整理好的主题知识库，可用于补原理、方案、trade-off
- `playbooks/`: 面向任务的执行流程
- `prompts/`: 可直接给模型使用的提示模板
- `inputs/`: 后续放目标 JD、岗位要求、投递上下文
- `output/`: 每次模拟面试、简历改写、项目复盘的产出目录
- `scripts/`: 轻量脚本，例如生成大文件索引、创建新任务模板
- `agent资料/`: 本地原始资料，仅保留索引和说明进入 GitHub

## 快速开始

### 1. 新建一次模拟面试

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start_session.ps1 -Mode interview -Slug backend-agent -Company "目标公司" -Role "Agent应用开发工程师"
```

### 2. 新建一次简历改写任务

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start_session.ps1 -Mode resume -Slug jd-tailor -Company "目标公司" -Role "LLM Agent工程师"
```

### 3. 刷新原始资料大文件索引

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\generate_large_file_index.ps1
```

## 当前仓库更适合产出的内容

- 一整场模拟技术面试
- 单题回答和追问树
- 项目 STAR 复盘
- JD 定制简历改写建议
- 面试薄弱点清单
- 下一轮补强计划

## 关于大文件

`agent资料/` 的原始课程视频、模型权重、训练产物和运行缓存都默认不入 Git。

GitHub 中只保留：

- `agent资料/README.md`
- `agent资料/LARGE_FILE_INDEX.md`
- `agent资料/large_files_manifest.json`

如果后续本地资料有变化，重新运行索引脚本即可。
