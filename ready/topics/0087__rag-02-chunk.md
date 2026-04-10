# 【RAG项目深挖-02】chunk切分模块

- Source Root: `note`
- Source Path: `2026-04-09 01_26_21-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 15

【RAG项目深挖-02】chunk切分模块
本文讨论了RAG项目中chunk切分模块的重要性，策暗清进，技术细节、优化思路等内容，关键要点包括：1.切分模块的
切分模块（Chunking），这个模块看似简单，但其实是RAG系统的核心瓶颈之一。面试官会重点考察你
对信息完整性vs检索精度这个trade-off的理解。
1.为什么切分很重要？（先讲清楚业务价值）
不要直接说"怎么做”，先说"为什么”
在保险RAG系统中，切分质量直接影响两个核心指标
1.检素召回率：chunk太大→噪音多，相似度计算不准：chunk太小→语义被割裂
2.答案质量：chunk边界不合理→关键信息被截斯，LLM无法正确理解
举个实际例子
·保险条款：“第3条责任范围：本保险承保但以下情况除外：（1）战争.（2）核福射..
如果切分点在”但以下情况除外之前→检素时只返回前半段→LLM会遗漏免责条款，给出错误答案
我们线上出过一次事故：用户间"核辐射在保障范围内吗”，系统回答”是”（四为chunk只包含“本保险承保.."）
导致客户投诉。所以我重新设计了语义感知的切分策略。
2.切分策略的演进（体现你的思考深度）
2.1三代方案对比
3.V3方案的技术细节（重点展开）
3.1切分策略的核心逻辑
Python
1 def semantic_chunking(parsed_doc)
基于文档结构的语义切分
模心思想
1.优先按“章节“切分（保首完整语义单元）
2.章节过长时，按”小节“切分
3.小节仍过长时，接”酸落”切分
4.特殊元素（表格/圆片）单独威chunk
10
chunks - []
11
12
Step1:识剧文档结构
13
后面详细讲
14
sections = extract_hferarchy(parsed_doc)
15
for section in sections
16
Step 2:计算章节tcken数
17
section_tokens - count_tokens(section.centent)
18
19
If section_tokens <= MAX_CHUNE_SIZE: # 1024
20
21
情况1：章节长度合适，直接作为chunk
chunks.append(create_chunk(sectien))
22
23
else
情况2：章节过长，递归切分
24
chunks,extend(split_1arge_sectin(sectlen)
25
26
# Step 3: 振如overlap
27
28
chunks = add_overlap(chunks, overlap_size=100)
29
38
return chunks
3.2关键技术点1：文档结构识别
如果说的”根据解析到的结构化信息”太模期了，要具体说怎么识别
问题：保险文档的结构很复杂
·有的用数字编号：1.+1.1+1.1.1
23
else
情况2：章节过长，通归切分
24
25
chunks,extend(spllt_large_sectlon(sectlon))
26
Step 3: 添overlap
27
chunks - add_overlap(chunks, overlap_size=100)
28
29
30
return chunks
3.2关键技术点1：文档结构识别
如果说的“根据解析到的结构化信息”太模期了，要具体说怎么识别
问题：保险文档的结构很复杂
·有的用故字编号：1.+1.1+1.1.1
·有的用中文编号：第一条+（一）+1.
有的用标题大小：标题1标题2+标题3
·还有混合编号：第3条保险责任+3.1基本责任+（1）身故保险金
我的解决方案：多策略融合
def extract_hlerarchy(parsed_doc)
提取文植层圾结构
优先级
1.法律端号（第x条）>数字编号（1.1）》字母响号（a）
2.字体大小：H1>H2> H3
3.缩证层级
黄略1：正则匹配常见编号模式
10
11
patterns = [
r'第[一二三四五六七八九十百]+条”
12
第三条
13
r'^\d+\.\d+\.\d+'
# 1.1.1
r'（[一二三四五]+）’
14
#()
15
p'^\d+\.'
16
17
18
策略2：利用解析模块输出的样式信息
# parsed_doc@含: font_size, bold, Indent_level
19
20
策略3：训练一个层级分类器（x08oost）
21
特征：号类型，字体大小、是否加租，缝进，位置
22
hlerarchy_level - hlerarchy_classifier-predict(features)
23
24
25
return bulld_tree(hierarchy_leve1)
3.3关键技术点2：超长章节的递归切分
“再进一步切分"太笼统，要说清是怎么切
Python
min_size=256)
超长章节的切分策略
原则：尽量保持语义完整性
chunks = []
黄略1：先芸试按”小节“切
10
subsections = section-get_subsections()
11
If subsections!
12
for sub in subsections1
1f count_tokens(sub) <= max_size
13
(qns)puadde*syunqp
14
else
15
16
递归切分
17
chunks.extend(split_large_section(sub))
18
return chunks
19
预略2：没有小节，按”段落“切
2θ
21
paragraphs = sectlon-get_paragraphs()
22
current_chunk = []
23
current_tokens = θ
24
for para In paragraphs
25
para_tokens - count_tokens(para)
26
27
关键判断：是否应该合井到当前chunk
28
29
If current_tokens + para_tokens <= max_size
current_chunk append(para)
3θ
31
current_tokens += para_tokens
32
else
33
保存当前chunk
1f current_tokens >- min_slze:道免太小的chunk
34
chunks -append(merge(current_chunk))
35
current_chunk - [para]
36
37
current_tokens = para_tokens
38
最后—个chunk
39
If current_chunk
4e
41
chunks.append(merge(current_chunk))
42
重暗3：单个股落仍超长，按句子切（最后手段）
43
44
chunks = [split_by_sentence(c) If count_tokens(c) >
_size else
45
for c In chunks]
46
47
return chunks
(eued)puadde*qunqquauun>
38
current_tokens += para_tokens
31
ZE
else
保存当前chunk
33
1f current_tokens >- min_size:避免太小的chunk
34
chunks.append(merge(current_chunk))
35
36
[eued] - qunysuauuns
37
current_tokens - para_tokens
38
39
最后个chunk
48
If current_chunk
41
chunks.append(merge(current_chunk))
42
黄略3：单个段落仍超长，按句子切（最后手段）
43
44
asa azgsxe < (2)suaoquno (2)uaquasAqatds] - sxun)
45
for c in chunks]
46
47
return chunks
关键优化：语义完整性检查
代码快
def should_serge(para1, para2)
判断两个段落是否应该合井
场景
#*（）.
2.转折句：paral-本保险承保..para2"但以下除外...应该合并
3.独立段落：paral-第3条...para2-简4条...不合井
规则1：如果para1以冒号/分号活尾，大概率是列表前导
10
(（. . *.. *. :.*.=,))uanspua*()dpus*reued I
11
12
return True
13
规则2：如果para2是列表项编号（1）、4、a
14
1f re,match(r*[ ((]\d+[) )]1~[4es]|[a-z].*, para2.strlp())
15
16
return True
17
18
规则3：如果para2以转折词开头
if para2.strip（）.startswith（（但”，“然面’，“除外’，“不包括“））
19
2θ
return True
21
22
规则4：用语义相似度判断（Sentence-BERT）
sinilarity - compute_simllarlty(paral, para2)
23
24
if similarity>0.75:高度相关
25
return True
26
27
return False
实际效果
simllarity - compute_similarity(para1, para2)
23
24
1f similarity >8.75:高度田关
25
return True
26
27
return False
实际效果
·优化前：23%的chunk在语义边界处截斯（人工抽检100个chunk）
·优化后：截斯率降到4%
3.4关键技术点3：特殊元素处理
原来我们讲"表格/图片作为单独整体"，但没说细节
表格的切分策略
问题：保险文档中的表格差异很大
·小表格：3行5列，300tokens→可以整体作为chunk
·大表格：50行10列，5000 tokens→超过了max_size
我的方案
def handle_table(table, max_size=1024)
表精的督能切分
table_tokens = count_tokens(table)
If table_tokens <= max_size
情况1：表情不大，整体作为chunk
return [create_table_chunk(table)]
10
11
else
情况2：大表幅，按“语义单元”切分
12
13
黄略A：如果表格有分组（如“基本责任"。“可选责任"）
14
If has_rou_groups(table)
15
16
return split_by_rou_groups(table)
17
黄略8：按固定行数切分，但保留表头
18
19
else
chunks - []
20
header - table.header
21
22
rows_per_chunk - estimate_rous_per_chunk(table, max_size)
23
for 1 In range(e, len(table.rous), rous_per_chunk)
24
25
chunk_rous - table.rous[i:f+rous_per_chunk]
关键：每个chunk都包含表头
26
16
用Deplot模型理取数据
data - deplot.extract(image)
17
18
return create_chunk(
content-f"图表数据：(data)
19
{uaed-afrug 1,qned afeuy. *,4ueqp. i,adAa.)-eaepeou
20
21
22
23
策略3：0CR提取文字
24
else
text = ocr.extract(image)
25
26
return create_chunk(content=text
3.5关键技术点4：Overlap策略
"overlap是100”，但没说为什么这么设置
Overlap的作用
防止关键信息被切分到两个chunk的边界，导致检索遗漏
举例
代码快
Chunk1：“..本保险承保息外仿害导数的身故或残疾
[边界]
Chunk 2：“，但以下情况障外：（1）战争..“
如果用户query=战争是否在保障范围”，相似度计算时
·Query向量和Chunk1：相似度低（Chunk1没提到"战争"）
·Query向量和Chunk2：相似度低（Chunk2缺少前文*承保什么”）
加入overlap后
代码快
Chunk1：“...本保险承保意外伤害导致的身故或残疾”
Chunk2：“...息外伤害导政的身故或理疾，但以下情况除外：（1）战争..”
现在Chunk2包含完整语义，检索准确率提升
Overlap大小的选择
我做了实验对比
rlap部分
现在Chunk2包含完整语义，检索准确率提升
Overlap大小的选择
我做了实验对比
检索召昌率
存储开销
检索速度
Overlap大小
0.79 Ix
0.84 1.05x
50 tokers
100tokens
0.89 1.1x
0.9 1.2x
200 tokens
0.91 1.3x
300 tokens
结论：100tokens是性价比最优点
·召回率提升显著（+10%）
存储只增加10%
·检索速度影响可接受
为什么不用更大的overlap?
Overlap越大，重复内容越多，会导致
1.检索时返回多个相似chunk（内容重复）
2.LLM的输入变长，增加或本
智能Overlap（我的优化）
固定overlap有个问题：可能在句子中间截断
我的改进：基于句子边界的overlap
def add_smart_overlap(chunks, overlap_tok
智能overlap：确保overlap边界是完整句子
result - []
for I, chunk In enumerate(chunks)
if 1 -- 0
result.append(chunk)
18
continue
11
获取前一个chunk的最后n个tokens
12
13
prev_chunk - chunks[1-1]
14
overlap_text - get_last_n_tokens(prev_chunk.content
overlap_tokens)
15
我的改进：基于句子边界的overlap
Python
def add_smart_overlap(chunks, overlap_tokens=100)
智能overlap：确保overlap边界是完整旬子
result - []
for l, chunk In enumerate(chunks)
if 1 -- 0
result,append(chunk)
10
continue
11
获取前—个chunk的最后n个tokens
12
prev_chunk - chunks[1-1]
13
14
overlap_text - get_last_n_tokens(prev_churk
15
关键：我到最近的句子边界
16
17
overlap_text = truncate_to_sentence_bc
18
19
20
new_content = overlap_text + chunk.content
result,append(create_chunk(nes_centent, ch
21
22
23
return result
24
25
def truncate_to_sentence_boundary(text)
26
截断到最近的句子边界
27
28
29
我到最后一个句号/问号/取号的位置
sentence_ends - ['-', *.
30
31
last_end = -1
for end In sentence_ends
32
pos - text.rfind(end)
33
If pos > last_end
34
35
last_end - pos
36
If last_end > 0
38
return text[last_end+1:]返回最后—个完整句子之脂的部分
else
39
returntext我不到甸子边界，返回原文
效果
·道免了87%的”句子被截断问题
·检索召回率从0.89提升到0.91
4.Chunk的元数据设计（容易被忽略但很重要）
面试官可能会问：chunk里除了文本，还存了什么？
用户问：“核辐射在保障范围内吗？”
2.Is_key_dause：用于检索加权
关键条款（责任、免责、费率）的权重x1.5
识别方法：关健词匹配+章节标题判断
3.prev/next_chunk_id：用于上下文扩展
如果检索到的chunk语义不完整，自动拉取前后chunk
例如：检索到”但以下除外：“，自动拉取前一个chunk的”承保范围”
5.切分质量评估（必须有量化指标）
5.1评估指标
定义
测量方法
目标值
人工标注+LM
语义完整性
chunk是否包含完整班义
>95%
判新
有效信息占比
关键民蒙盖率
信息密度
>70%
资试集QA评估
检索召国率
相关chunk被召回的比例
>90%
句子截新率
切分点是否在合理位置
<5%
5.2评估方法：QA测试
我构建了一个评估数据集
·200份保险文档
·每份文档人工编写10个问题（涵盖不同难度）
·共2000个QA对
评估流程
评估切分效果
recall_1ist - []
用当前切分方室检素
retrieved_chunks = retrleve(q, top_k=5)
10
判断ground truth chunk是否技召回
11
If gt_chunk In retrleved_chunks
12
Python
1 + def evaluate_chunking(questions
no_truth_chumks)
评估切分效果
recall_1ist - []
for q, gt_chunk In zip(questions。 ground_truth_chunks)
用当前切分方寓检素
retrieved_chunks = retrieve(q, top_k=5)
18
判断ground truth chunk是否被召回
11
If gt_chunk in retrieved_chunks!
12
recall_1ist.append(1)
13
14
else!
15
recal1_list.append(e)
16
recall - np.mean(recal1_1ist)
17
18
return recal1
结果对比
·V1圆定长度切分：召回率67%
·V2句子级切分：召回率74%
·V3语义感知切分：召回率91%
6.实际踩过的坑（体现经验）
坑1：chunk太小导致语义不完整
问题
初版系统设置dhunk_size=512，导致一些复杂条款被切碎
例如：“本保险承保意外伤害（定义见婧X条）。包括但不限于，但以下情况除外
切成3个chunk，LLM看不到完整逻辑，回答错误
解决
·增大chunk_size到1024
·对关键条款（责任、免责）设置更大的max_size（1536）
坑2：表格被切分后表头丢失
问题
大表格按行切分，每个chunk只包含部分行LLM看不到表头，不知道每列是什么
解决
·每个chunk都复制表头
坑2：表格被切分后表头丢失
问题
大表格按行切分，每个chunk只包含部分行LLM看不到表头，不知道每列是什么
解决
·每个chunk招复制表头
·在metadata中标注“这是表格的第X部分，共Y部分”
坑3：列表项被单独切成chunk
问题
Plaln Text
1Chunk N：“（1）战争、军事行助”
Chunk N+1:“（2）核辐时。核规炸”
每个chunk帮缺少”这是免责条软”的上下文
解决
·识别列表结构，将前导句和所有列表项合并
·如果仍超长，至少保留前导句
7.优化思路（展现你的技术视野）
1.Late Chunking （最新研究）
传统方法：先切分→再embedding Late Chunking：先整算embedding→再切分
优势：每个dunk的向量包含了全文的上下文信息
参考：Jlina AI的late chunking技术
2.语义切分（Semantlc Chunking)
不用固定长度，而是用语义相似度判断切分点
方法
·计算相邻句子的embedding相似度
·相似度突然下降的地方一切分点
适用场景：新闻、博客等语义边界明显的文档
3.动态chunk slze
不同文档员型用不同的chunk_stze
·技术文档：1024（需要完整代码块）
·法律文档：1536（条款复杂）
解决
·识别列表结构，将前导句和所有列表项合并
·如果仍超长，至少保留前导句
7.优化思路（展现你的技术视野）
1.Late Chunking （最新研究）
传统方法：先切分→再embedding Late Chunking：先整算embedding→再切分
优势：每个unk的向量包含了全文的上下文信息
参考：Jina AI的late chunking技术
2.语义切分（Semantic Chunking)
不用固定长度，而是用语义相似度判断切分点
方法
·计算相邻句子的embedding相似度
·相似度实然下降的地方→切分点
适用场景：新闻、博客等语义边界明显的文档
3.动bchunk size
不同文档类型用不同的chunk_size
·技术文档：1024（需要完整代码块）
·法律文档：1536（条款复杂）
·FAQ文档：512（问题独立）
4.Chunk的后处理
切分完成后，用LLM做一遍质量检查
·识别语义不完整的chunk→自动扩展
·识别信息密度低的chunk（全是"参见第X条"）→合井
Q1:为什么chunk_size选1024？
回答思路
我做了实验对比
选1024是因为
1.召回率最优(0.91)
2.答案质量显著提升（vs512）
以刀元网：用m效一通质重恒息
识别语义不完整的chunk→自动扩展
·识别信息密度低的chunk（全是"参见第X条"）一合井
Q1:为什么chunk_size选1024?
回答思路
我做了实验对比
选1024是因为
1，召回率最优（0.91)
2，答率质量显著提升（vs512）
3，成本可控（vs 2048)
4，保险条款平均长度在800-1200tokens，1024覆盖90%的场景
Q2：如何处理跨页的章节？
解析模块已经处理了跨页问题，输出是连续的文本流
但现们会保留page_num信息，用于答案离源
·检索到的chunk来自第5页和6页
告诉用户：“详见合同第5-6页”
Q3：如何避免重要信息被overlap覆盖？
Overlap是”前一个chunk的尾部+当前chunk的全部”不存在信息被覆盖，只是有重复
重复内容会导致检索时返回多个相似chunk，我们用MMR（Maximal Marginal Relevance）去重
9.总结：切分模块的核心价值
不要说：我用固定长度切分，overlap100”
要说：“我设计了基于文档结构的语义切分，通过层级分类器识别章节，用智能边界检测道免语义截斯，召回
辜从67%提升到91%”
不要说：“表格单独成chunk
要说：“大表格会按语义单元切分，每个chunk保留完整表头，避免LLM理解错误”
不要说：设置了overlap”
要说：“我用基于句子边界的智能overlap，避免了87%的句子截断问题，并通过实验确定100tokens是性价比
最优点
我做了实验对比
选1024是因为
1.召回率最优（0.91）
2，答案质量显著提升（vs512）
3，成本可控(vs 2048)
4，保险条款平均长度在800-1200tokens，1024覆盖90%的场景
Q2:如何处理跨页的章节？
回答
解析模块已经处理了跨页问题，输出是连续的文本流
但我们会保留page_num信息，用于答案离源
·检索到的chunk来自第5页和第6页
告诉用户：“详见合同第5-6页”
Q3：如何避免重要信息被overlap覆盖？
Overlap是”前一个chunk的尾部+当前chunk的全部”不存在信息被覆盖，只是有重复
重复内容会导致检索时返回多个相似chunk，我们用MMR（Maximal Marginal Relevance）去重
9.总结：切分模块的核心价值
不要说：我用固定长度切分，overlap100”
要说：我设计了基于文档结构的语义切分，通过层级分类器识别章节，用智能边界检测道免语义截断，召回
率从67%提升到91%
不要说：“表格单独成chunk”
要说：“大表格会按语义单元切分，每个chunk保留完整表头，道免LLM理解错误”
不要说：设置了overlap”
要说：我用基于句子边界的普能overlap，逝免了87%的句子截断问题，并通过实验确定100tokens是性价比
最优点
真诚点赞，手留余香
