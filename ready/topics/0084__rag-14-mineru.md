# 【RAG实战-14】MinerU解析短板分析

- Source Root: `note`
- Source Path: `2026-04-09 01_25_36-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 3

【RAG实战-14】MinerU解析短板分析
本文讨论了MinerU文档解析开露项目的短板分析及改进建议，关键要点包括：1.项目现状：MinerU2.x已将PDF→Mar
、MinerU
搭建。你可以考虑基于MinerU的现有问题进行改进（下文给出问题和处理思路）。部署在你自己的项目
下面先用一段话快速概括：MinerU2.x已把PDF一Markdown/JSON的整体精度和速度拉到同类开
源工具的第一梯队。但在版面顺序、复杂表格、竖排文字/小语种OCR、公式与代码块识别、输出一致
性、文件/硬件限制以及许可证合规性等方面仍有明显短板
官方TODO和GitHubIssue区也列出了若干尚未解决或正在处理中/长期规划中的问题。接下来按类
别展开说明，井给出改进建议。
1.版面与阅读顺序
说期
问题
典型场景
阅读顺序机序
模型以几同中心排序，极复杂布局仍会乱序（gthub.com）
多栏期刊，广告型肺板
日文古爆POF
目前仅“有限支持”。置排区域常被当成模排切块（mnerneaedc5.）
置排文字支持不足
改进方向：引I入基于GraphLayout的阅读顺序推理或使用vim+RL微调：竖排可通过增加直立文本数据、在
OCR后处理阶段做方向校正。
2.表格解析瓶颈
场景
症状
睡页长表
被拆成多个表且表头丢失（gihb.m）
行列合井/嵌套表
单元格疆位，列数溢出（gihub.com)
90°货转表
VLM模式定位失败（ghub.com）)
改进方向：在版面检测后加聘页线索合井（行/列名相似度）、使用基于TableDet+TableRec的两阶段方法替换
当前rule-based合井：对旋转表先做Hough或DLA方向检测再送入表格分割模型。
OCR相关限制
2.表格解析瓶赖
场景
症状
跨页长表
被拆域多个表且表头丢失（githab.cm)
单元格疆位，列致滋出（gthub.cxm）
行列合井/嵌套表
90°旋转表
VLM 模式定位失败（ghub.com)
改进方向：在版面检测后加跨页线素合并（行/列名相似度）、使用基于TableDet+TableRec的两阶段方法替换
当前rule-based合井：对旋转表先做Hough或DLA方向检测再送入表格分割模型。
3.OCR相关限制
·小语种/重音符号：拉丁重音、阿语易混字符误识率高（mineru.readthedocs.io）
·无法关闭OCR开关：use_ocr=False仍触发OCR流程（github.com）
·图像内文字：虽然集成 PaddleOCR，可对GPU缓存与batch-size不够友好，易OOM（github.com）
改进方向：切换P-OCRv5多语模型井开放lang fallback；把OCR模块抽成独立服务，增加显存/CPU动态分配
与真正的 disable分支。
4.公式与特殊符号识别
·数学集合、化学分子式、函数曲线经常漏检或转LaTeX失败（github.com）
·Markdown中道染失败（分隔符/转义）（github.com）
改进方向：为公式检测增加PIMask+TedsFntune；让公式道染走MathJax并对Ss...$s统一转换
5.结构化语义缺失
功能空缺
状态
标题分级
仅支持—级标题(mlner.eahedcs.l0)
nule-based，早贝精式调识(minar.read
目录/列表
代码块识别
圳末支持（gub.com）
仍在TODo列表（gibab.cm)
几何图形/化学式
6.输出一致性与重复字段
·VLM模式偶尔生成重复块、字段名冲突（github.com）
JSON顺序不稳定。影响下游RAG/QA索引
7.文件与运行环境限制
改进方向：为公式检测增加 PIMask+TedsFintune；让公式谊染走MathJax并对$$..Ss统一转换。
5.结构化语义缺失
功能空缺
状态
标题分级
目最/列表
nule-based。 早见格式爆识 (minenu,re.dhdcs
代码块识别
尚末支持（ghub.com)
仍在 T00o列表（grhab.cem)
几何图形/化学式
6.输出一致性与重复字段
·VLM模式偶尔生成重复块、字段名冲突（github.com）
·JSON顺序不稳定，影响下游RAG/QA索引
7.文件与运行环境限制
·16GB（推荐32GB）RAM&6GB+VRAM，超规格文档易超时（github.com）
8.社区TODO与路线图
官方README“TODO”中仍列出闽读顺序模型化、索引/列表识别、表格识别增强、标题分类、代码块识别、化学
式/几何形状识别等任务（github.com）。最新版2.1.0刚加入多语PP-OCRv5、全局配置文件、显存优化等。但上
述功能依然开发中或待社区PR。
9.快速改进清单
1.二阶段表格解析：TableDet一TableRec 替换rule-based合井，提高跨页/合并单元格准确度。
2.可插拔OCR：拆分为mlcro-service，真正关闭OCR时绕过显存占用。也可以直接接入多模态LLM
3.阅读顺序校正器：Graph-based或RoBERTa-order微调，专攻多栏/竖排。
4.标题/代码块：用LLM-aided分类（项目已内置Qwen2.5-32B接口，可在post-process 里调）。
5.LIcense梳理：将YOLO-AGPL 部分替换为Apache-2.0的 PP-YOLOE or RT-DETR，降低合规风险。
6.输出一致性：统一mlddle_son→schema-enforced JsON，再映射Markdown，减少字段重复。
7.小语种数据增补：引入publly avallable OCR-Sulte 语料+合成数据，提升拉丁/阿语准确率。
