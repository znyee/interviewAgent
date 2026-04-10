# LlamaIndex组件

- Source Root: `agent资料`
- Source Path: `S2-系统训练营/5-RAG原理与核心组件/提示词工程+Functioncall+RAG/04_llamaindex组件.ipynb`
- Source Kind: `ipynb`
- KB Type: `interview-topic`

# 环境准备

!pip install llama-index-core \
llama-index-llms-openai \
llama-index-readers-file \
llama-index-readers-web

!pip install unstructured[pdf,docx,pptx] \
paddleocr \
pillow

!pip install trafilatura \
cohere \
pypdf \
python-pptx

!pip install sentence-transformers \
rank_bm25

# 一、数据模块
- 1. 数据解析-数据链接器（Data Connectors）
- 2. 文档分块
- 3. 向量储存
- 4. 索引构建

## 1. **Data Connectors（数据连接器）**
**功能**：用于从各种数据源（数据库、API、文件系统等）提取数据，并将其转换为适合 LlamaIndex 处理的格式。

**支持的数据源**
- 本地文件（TXT、PDF、CSV、JSON、Markdown 等）
- 数据库（PostgreSQL、MongoDB、SQL 等）
- Web 爬取（网站、Notion、Google Drive、Slack）
- API（调用 REST API 或 GraphQL API 获取数据）

### 两个问题
- 我们能不能继续扩大我们的处理数据来源呢：包含本地文件、网页、数据库等等
- 我们发现他并不能很好地读取图片、表格的数据【RAG面试必问问题】

- 我们从llamahub中加载连接器：https://llamahub.ai/?tab=readers
- llamacloud使用sota的文件处理工具：https://cloud.llamaindex.ai/

- https://cloud.llamaindex.ai/project/35a4b13f-e004-400e-af4d-ed8b0adb68fd

---

## 2. **Data Indexes（数据索引）**
**功能**：构建高效的索引结构，以便快速检索和查询数据。索引可以组织和优化大规模文本数据的存储和访问。

**流程**
- **切分**
- **打标**
- **构建索引**
- **入库**

**示例**

### 2.1 Chunk切分

#### 在RAG系统中数据块切分的重要性

在检索增强生成（Retrieval-Augmented Generation, RAG）系统中，数据块切分（chunking）是一个至关重要的环节，直接影响系统的检索质量和生成效果。

#### 检索精度和相关性

- **语义完整性**：合理的切分能确保每个数据块包含完整的语义单元，使检索结果更加连贯有意义
- **相关性提升**：精确切分可以使检索系统更准确地匹配用户查询的真正意图，减少无关信息的干扰
- **消除噪声**：适当大小的数据块可以减少不相关内容被一同检索的可能性

#### 向量表示与相似度计算

- **向量密度**：较小的块能产生更精确的语义向量表示，使相似度计算更加准确
- **降低维度诅咒影响**：适当切分可以减轻在高维空间中相似度计算的挑战
- **检索效率**：合理大小的向量可以加速相似度计算和索引查找过程

#### 生成质量优化

- **上下文窗口管理**：适当大小的数据块能在不超过模型最大输入限制的情况下提供足够上下文
- **信息密度平衡**：切分策略影响输入到生成模型的信息密度和质量
- **减少幻觉**：精确检索到的相关块可以为生成模型提供更准确的事实依据，减少幻觉

#### 实际应用考量

- **领域特性适配**：不同领域（医疗、法律、技术文档等）可能需要不同的切分策略
- **多级切分**：有时需要采用多级切分策略，结合大块和小块的优势
- **元数据增强**：切分时保留和添加适当的元数据可以提升检索效果

正确的切分策略能显著提高RAG系统的整体性能，是构建高质量RAG应用的关键环节之一。

### 数据块切分（Chunking）优化方案

#### 一、基于规则的切分方案

1. **固定长度切分**
   - 按照固定的标记数（tokens）或字符数进行切分
   - 简单实用，但可能会切断语义单元

2. **结构化文档切分**
   - 根据文档的自然结构（章节、段落、标题）进行切分
   - 保留原始文档的组织逻辑和层次结构

3. **句法与语法切分**
   - 利用句号、问号等标点符号作为切分点
   - 按照句子、段落等语法单位切分

4. **滑动窗口切分**
   - 使用固定大小的窗口，但允许相邻块之间有一定重叠
   - 减少因硬切分导致的上下文丢失

5. **基于分隔符切分**
   - 利用特定的分隔符（如Markdown标记、HTML标签）进行切分
   - 适用于具有明确格式的文档

6. **分层递归切分**
   - 先按大单位（章节）切分，再逐层细分（段落、句子）
   - 创建多级索引结构，适应不同粒度的检索需求

#### 二、基于语义的切分方案

1. **主题边界检测**
   - 使用TextTiling等算法检测文本中的主题转换
   - 在主题变化处进行切分，确保每块内容主题一致

2. **语义相似度指导切分**
   - 使用嵌入模型计算文本片段间的语义距离
   - 在语义变化显著处进行切分，保持块内语义连贯

3. **实体关系保留切分**
   - 识别文本中的关键实体和它们之间的关系
   - 确保相关实体和关系描述保留在同一块中

4. **信息密度感知切分**
   - 分析文本各部分的信息密度和重要性
   - 根据信息密度的变化动态调整块的大小

5. **语义单元识别切分**
   - 使用NLP模型识别完整的语义单元
   - 确保语义完整性，避免割裂关键信息

6. **意图适配切分**
   - 基于预期的查询意图调整切分策略
   - 优化块的内容以更好地匹配可能的查询类型

<span style="color:red;">**实际应用中，一般是按照在解析之后，按照页、段落、图片、表格先进行划分，然后添加分词信息，详细的tag/父文本信息**</span>

下面是格式化后的JSON输出

```json
{
  "id_": "1ae12437-1e62-4972-9564-49d2d3aea577",
  "embedding": null,
  "metadata": {
    "file_path": "/Users/项目库/LlamaIndex-Tutorials/01_Introduction/data/同仁堂研报.pdf",
    "file_name": "同仁堂研报.pdf",
    "file_type": "application/pdf",
    "file_size": 2786710,
    "creation_date": "2025-03-08",
    "last_modified_date": "2025-03-08",
    "total_pages": 28,
    "source": "4"
  },
  "excluded_embed_metadata_keys": [
    "file_name",
    "file_type",
    "file_size",
    "creation_date",
    "last_modified_date",
    "last_accessed_date"
  ],
  "excluded_llm_metadata_keys": [
    "file_name",
    "file_type",
    "file_size",
    "creation_date",
    "last_modified_date",
    "last_accessed_date"
  ],
  "relationships": {
    "SOURCE": {
      "node_id": "c4ed2441-c6f9-442d-be81-cada183af0ea",
      "node_type": "DOCUMENT",
      "metadata": {
        "file_path": "/Users/项目库/LlamaIndex-Tutorials/01_Introduction/data/同仁堂研报.pdf",
        "file_name": "同仁堂研报.pdf",
        "file_type": "application/pdf",
        "file_size": 2786710,
        "creation_date": "2025-03-08",
        "last_modified_date": "2025-03-08",
        "total_pages": 28,
        "source": "4"
      },
      "hash": "25df3e5d16b9d424fd08e52ec0f357561d8067aba5e113a016eeb55cf53196c5"
    }
  },
  "metadata_template": "{key}: {value}",
  "metadata_separator": "\n",
  "text": "2025-03-06 同仁堂 \n \n \n敬请参阅最后一页免责声明 \n-4- \n证券研究报告 \n \n投资风险 \n1、牛黄、麝香等天然贵细原料价格继续大幅上涨带来较大成本压力； \n2、产品质量风险，导致品牌形象受损； \n3、主力产品安宫牛黄丸（双天然）提价，导致市场需求下滑风险； \n4、牛黄进口试点落地不及预期，天然贵细药材无法支持进一步生产扩张。",
  "mimetype": "text/plain",
  "start_char_idx": 0,
  "end_char_idx": 173,
  "metadata_seperator": "\n",
  "text_template": "{metadata_str}\n\n{content}"
}
```

len(nodes)

## 2.2 模型设置

- 如果要使用国内的模型可以按照如下方式设置

from llama_index.llms.openai_like import OpenAILike

llm=OpenAILike(model="", api_base="", api_key="")

## 2.3 设置向量数据库

%pip install llama-index-vector-stores-faiss

!pip install llama-index

## 3. **Engines（查询引擎）**
**功能**：处理用户查询，并通过索引和检索机制返回最佳匹配结果。可以进行复杂查询、嵌套查询、RAG 生成等。

**支持的查询模式**
- **基础查询（Retrieval Queries）**：基于向量索引检索最相关的文档。
- **生成增强查询（RAG Queries）**：结合 LLM 生成答案。
- **多跳推理（Multi-hop Queries）**：跨多个数据源进行逻辑推理。

### 如果我们要自定义回答的格式呢？
### 如果要实现聊天的记忆呢？

### 如果要实现流式输出呢

---
## 4. **Data Agents（数据代理）**
**功能**：结合大模型（LLM）和工具（工具链、API）来执行复杂任务，如自动化推理、代码执行、任务分解等。

**支持的能力**
- **使用外部 API 进行增强**（如数据库查询、API 调用）
- **多步推理和任务拆分**（Agentic Workflow）
- **与 RAG 结合，动态选择最佳检索策略**

# 到目前为止大家觉得RAG存在哪些问题？

---

### 一、**查询模块（Query Understanding）**
**核心问题**：用户意图识别偏差，导致检索方向错误
**典型案例**
1. **复杂分析请求误解**
   - 用户提问："近三年研发投入增长率？"
   - 系统行为：直接返回各年研发投入绝对值而非计算增长率
   - 问题本质：未能识别"增长率"隐含的数学计算需求，默认按关键词匹配原始数据
2. **统计类请求的局限性**
   - 用户提问："文档中'三农'出现多少次？"
   - 系统行为：返回含"三农"的段落而非全局统计
   - 问题本质：将统计需求误判为关键词检索

**优化策略**
- 增加意图识别层：通过分类模型区分查询类型（事实检索/数值计算/统计分析）
- 交互式澄清机制：对模糊问题主动反问（如"是否需要计算增长率？"）
- 预设能力边界声明：明确告知用户系统不支持的功能（如字符统计）

---

### 二、**数据处理入库模块（Data Processing）**
**核心问题**：数据组织形式不当，导致知识利用率低下
**典型案例**
1. **非结构化数据入库**
   - 案例：PDF合同中的图片条款未被OCR识别
   - 后果：问答时无法提取违约金具体数值
2. **数据时效性缺失**
   - 案例：政务系统推荐已取消的线下窗口
   - 根源：知识库混杂新旧政策且无时间戳标注

**优化策略**
| 问题类型 | 解决方案 | 工具示例 |
|-----------------|-----------------------------------|--------------------------|
| 非结构化文本 | 实体关系抽取构建三元组 | SpaCy, Dygie++ |
| 多模态数据 | 图片/表格OCR解析+结构化存储 | PaddleOCR, Camelot |
| 数据时效管理 | 添加生效时间戳+版本控制系统 | Elasticsearch _meta字段 |
| 内容筛选 | 基于业务场景的主动降噪（如过滤食堂菜单） | Rules Engine |

---

### 三、**查询-文本块匹配模块（Retrieval）**
**核心问题**：语义匹配与上下文理解不足
**典型案例**：传入三体的小说
1. **逻辑关系断裂**
   - 查询："黑暗森林法则核心思想"
   - 错误匹配：返回小说中无关的早餐描写段落
   - 根本原因：纯向量检索无法理解叙事逻辑结构
2. **长文档处理缺陷**
   - 查询："术语X出现次数"
   - 系统行为：返回包含术语的段落而非全文档统计

**优化策略**
- **分块策略升级**
  - 动态分块：按语义单元而非固定长度切割（如使用TextTiling算法）
  - 层级索引：建立章节-段落-句子的多级检索结构
- **检索增强**
  - 混合检索：结合关键词BM25与向量相似度（如HyDE方法）
  - 上下文扩展：通过LLM生成假设文档提升召回率

---

### 四、**知识回答模块（Generation）**
**核心问题**：信息整合与推理能力缺失
**典型案例**
1. **多轮对话断裂**
   - 第一问："糖尿病患者能否吃西瓜？" → 正确回答含糖量
   - 追问："每天吃多少合适？" → 错误跳转到水果种植技术
2. **数值推理失败**
   - 查询："研发强度与股价相关性"
   - 系统行为：罗列数据后编造错误结论

**优化策略**
- **增强型生成架构**
  ```python
  # 伪代码示例：融合外部工具的生成流程
  def generate_answer(query, retrieved_data):
      if needs_calculation(query):
          result = call_math_plugin(retrieved_data)  # 调用计算插件
          return format_calculation(result)
      elif needs_reasoning(query):
          reasoning_chain = build_chain_of_thought(retrieved_data)  # 思维链构建
          return validate_with_knowledge_graph(reasoning_chain)  # 知识图谱验证
      else:
          return base_generator(query, retrieved_data)
  ```
- **多轮对话管理**
  - 使用对话状态跟踪（DST）维护上下文
  - 设置对话边界约束（如医疗场景禁止跨科室推理）

---

### 模块间协同优化示例
**场景**：金融产品收益率查询
1. **数据处理模块**
   - 结构化存储收益率数据为`{产品名:str, 收益率:float, 生效时间:datetime}`
   - 建立策略删除过期数据（如自动清理2年前记录）
2. **检索模块**
   - 对"收益率"类查询强制附加时间范围过滤器
3. **生成模块**
   - 当检测到数值比较时，自动触发差值计算插件
   - 对政策类回答添加来源标注（如"根据2024年X文件第Y条"）

通过这种模块化的问题拆解与针对性增强，可使RAG系统准确率提升40%以上（实际业务场景测试数据）。关键是要避免试图用单一模块解决所有问题，而应建立各环节的协同校验机制。

# 到目前为止大家觉得RAG存在哪些问题？

---

## 5. **Application Integrations（应用集成）**
**功能**：将 `LlamaIndex` 连接到外部应用、前端界面或生产环境，支持 API、插件、流式接口等。

**常见的集成方式**
- **LangChain**：结合 LangChain 进行 RAG 任务处理。
- **FastAPI / Flask**：搭建 API 服务器，支持 Web 调用。
- **Streamlit / Gradio**：构建可交互的 RAG 应用。
- **云平台（Azure OpenAI, AWS, GCP）**：部署到云端。

**示例**（FastAPI 部署 API）
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/query/")
def query_llama(question: str):
    response = query_engine.query(question)
    return {"answer": response}

# 运行：uvicorn filename:app --reload
```

---

## **总结**
LlamaIndex 通过这 **五大核心模块** 提供完整的 RAG 解决方案
1. **Data Connectors** —— 连接数据源，加载数据。
2. **Data Indexes** —— 构建索引，加速检索。
3. **Engines** —— 处理查询，返回结果。
4. **Data Agents** —— 结合 LLM 进行推理和任务执行。
5. **Application Integrations** —— 让应用无缝对接到生产环境。

这使得 `LlamaIndex` 成为一个强大的框架，适用于构建各种知识库问答、企业检索、智能客服等应用 🚀。
