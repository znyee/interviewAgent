# 【RAG实战-11】Embedding Model 和 Rerank

- Source Root: `note`
- Source Path: `2026-04-09 01_24_59-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 2

【RAG实战-11】Embedingmodel和Rerank
model怎么选
本文讨论了2024-2025年开露社区中常用的Embedding模型和Rerank模型的选择，为不同场景提供了模型措配建议
下面把2024-2025年开源社区里最常被拿来做Embedding）和Rerank的模型做个快速横评，方便你按
场景直接挑
1.常用Embedding模型（双塔/稠密向量）
家族
高点晶场景
语言覆盖
典型版本
中文效果出急、8K上下文，配准同名
bge-base-en/v1.5, bge-large次, bge
BGE
中英+多语
reranker：MTEB 榜单风尺寸第探队(
m3
微淘成本低，社区基线：新版v2提升
e5-base-v2, multingual-+5-*
英语/多语
长文表现（HginEa）)
8K上下文，在MTEB多语榜登顶：B
gtebaseenv1.5.gtemlling
GTE
申-英/多语
有官方reraker 发布（Huging FaC
Hugging face)
Instrsctior-bning,一句提示可换任
英语
务，做分美/排序也痕方便（DEV
Instructor
Instructor-base / X0L
Community)
$K长上下文，推理快：配合 Jina
英/中/多硼版本
Jina Embeddings v2
ColBERT 做长文检素(Huging FCg)
3M参数的轻量模型，CPU端极快
英语
MiniLM / all-MiniLM
al-MiniLM-L6-v2
做边牌险素常用
怎么选
一般情况下无脑bg·m3
中文或中英鼠合：bge-m3或bge-large-zh
多语言：gte-multilingual-base 或bge-m3
·资源紧张/边缘设备：e5-smal1或MiniLM
▪长文≥8Ktoken: Jina Embeddingsv2
2.常用Rerank模型（交叉编码/LateInteraction/稀疏）
一般情况下无脑bge·m3
中文或中英混合：bge-m3或bge-large-zh
多语言：gte-multilingual-base 或bge-m3
资源累张/边缘设备：e5-smal1或MiniLH
•长文≥8Ktoken:Jina Embeddingsv2
2.常用Rerank模型（交叉编码/LateInteraction/稀疏）
美型
特点
代表模型
交叉编码 Cross-Encoder
*BAAI/bge-reranker-(base
提好，慢了点
英文检索器最常用“万金治精排，推理只需2-3ms/假落（Hug
cross-encoder/ms-marco-MiniUM-L6-
Er)
多语+中文官方精排，直接接GTE eedaing（Hugng.Eacc）
gte-multlingual-eranker-base
jina-colbert-v2
ColBERT 结构。长文检素时精度/速度拆中好(HggingFace)
Late-Interaction
稀硫/晨合
生成民项痛疏定量，可和调密向量做bybrid 检索（ClHhub)
SPLADE-v2
组合推荐
1.经典流水线：BGE-base 检素top100-bge-reranker-base 精排
2.多语场景：gte-multilingual-base + gte-multilingual-reranker
3. GPU 紧张：e5-smal1 +MiniLM-L6-cross-encoder（batch 推理)
4.长文/8K：jina-embeddings-v2+jina-colbert-v2。段内匹配更稳
3.评估与资源
·MTEB（MassiveTextEmbedding Benchmark）提供58个任务的统一榜单，随时查看最新模型排行
(Hugging Face)
•Hugging Face上所有上述横型书部可 fron sentence_transformers inport SentenceTransformer
加载：LangChain/LlamaIndex 已内置 BGE、GTE、E5 等适配。
·若想跑本地向量库，可配Milvus、Weaviate、Qdrant：稀疏向量（SPLADE）可直接用 Elasticsearch/
OpenSearch的倒排索引。
Embedding 端现在最火的是BGE、E5、GTE、Jlnav2
Rerank 端贝以同门的 BGE-Reranker、 MinlLM Cross-Encoder、 GTE-Reranker 和 ColBERT /
SPLADE为主流。
按语种、上下文长度和部害资源选一对”向量+精排“即可快速落地。
