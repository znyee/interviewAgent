# Project Card 01: Milvus RAG Service

## 来源目录

- `D:\code\agent_data\agent资料\S4-agent开发\第一周-RAG&向量数据库\RAG`
- `D:\code\agent_data\agent资料\S2-系统训练营\5-RAG原理与核心组件`

## 已核实的事实

- 项目把能力拆成两层：
  - `milvus_api.py` 负责向量库 CRUD 和检索接口。
  - `rag_service.py` 负责面向问答的 RAG 服务。
- 服务是 FastAPI。
- 文档中明确有 Milvus、API 层和 RAG Service 的拆分。
- `rag_service.py` 提供 `/chat`、`/chat/stream`、`/chat/with-history` 等接口。
- README 明确提到意图识别、查询扩展、参考片段、多轮对话等能力。
- `milvus_insert.py`、`milvus_query.py`、`milvus_delete.py` 覆盖了入库、查询、删除等基础流程。

## 这个项目能支撑你回答什么

- RAG 服务为什么要和向量库 API 分层。
- 文档入库通常包含哪些环节：切分、向量化、元数据、写入。
- 检索增强问答里，为什么要做查询扩展和多轮上下文。
- 如何把知识库能力封装成 HTTP 服务供上层 Agent 复用。

## 和简历的关系

- 强支撑：`RAG 知识层`、`分块/检索/引用`、`查询改写与召回优化`。
- 中支撑：`Metadata Filtering`、`Rerank` 的思路层理解。

## 回答时的推荐话术

- `我做过把底层检索层和上层问答层解耦，这样方便独立演进索引和业务逻辑。`
- `在 RAG 里我通常会关注召回、重排和上下文组织，而不是只做一个向量检索接口。`

## 不要夸大的点

- 当前材料不能直接证明你在这个项目里做了 OCR/ASR。
- 当前材料也不能直接证明你上线了 Elasticsearch 混合检索，只能支撑你理解相关方案。
