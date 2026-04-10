# Agent Data Core Repo

这个仓库保留的是适合进入 GitHub 的核心内容，不追求把本地原始资料完整镜像上去。

## 建议入库的核心目录

- `agent_knowledge/`: 清洗后的知识层、项目卡片、面试素材
- `ready/`: 已整理好的主题知识、索引和合并问答库
- `output/`: 后续生成的可交付内容
- `agent资料/README.md`: 原始资料目录的角色说明
- `agent资料/LARGE_FILE_INDEX.md`: 被排除大文件的索引
- `agent资料/large_files_manifest.json`: 大文件清单，便于后续更新和自动化处理

## 为什么要瘦身

`agent资料/` 当前约 18.49 GB，其中绝大部分体积来自：

- 模型权重、LoRA 适配器、训练检查点
- 课程录像与演示视频
- 数据集原件、语料缓存、压缩包
- 向量库卷数据、运行时缓存、分词索引
- 导出较重的 Notebook

这些内容对 GitHub 仓库不友好，但它们的路径、用途和来源说明仍然有价值，所以仓库中改为保留索引和说明。

## 当前策略

- 保留：Markdown、源码、轻量配置、项目入口、脚本、说明文档
- 排除：大模型权重、视频、数据集缓存、向量库卷数据、超大 Notebook 导出
- 对被排除文件：统一写入 `agent资料/LARGE_FILE_INDEX.md` 与 `agent资料/large_files_manifest.json`

## 更新大文件索引

在仓库根目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\generate_large_file_index.ps1
```

默认会扫描 `agent资料/` 下大于等于 20 MB 的文件，并刷新两份索引文件。

## GitHub 上传前检查

1. 确认 `.gitignore` 已覆盖本地大文件
2. 运行索引脚本，保证说明与实际目录一致
3. 用 `git status --ignored --short` 检查大文件是否已经被排除
4. 再执行提交、推送和创建仓库
