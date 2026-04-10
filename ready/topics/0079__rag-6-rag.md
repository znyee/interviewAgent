# 【RAG实战-6】RAG评估

- Source Root: `note`
- Source Path: `2026-04-09 01_22_46-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 9

【RAG实战-6】RAG评估
本文讨论了针对金融保险公司的检素增强生度（RAG）问答系统制定全国评估方室的相关内春，通盖召回率/准确率、生成
制定一个全面的RAG系统评估方案。针对一家金融保险公司的问答系统，评估将通盖召回率/准确率、生
成答案的可信度。系统响应速度。可扩展性以及用户体验。
评估策略将包括
·召回率/准确率：使用BLEU、ROUGE、MRR等指标评估问答匹配情况。
·可信度：计算答案与支持文档的匹配度，例如检索文档的夏盖率。
·响应速度：记录系统的直询时间并进行统计。
·可扩展性：通过不同规模的数据集测试RAG系统的稳定性。
·用户体验：进行人工评估和反领收集。
基于Python手撕代码，展示如何在实际案例中实现这些评估。
1.RAG问答系统全面评估方案
针对金融保险公司的检素增强生成（RAG）问答系统，我们从多个维度制定全面的评估方案。包括召回/准确率、答
案可信度、响应速度、可扩展性和用户体验等。下面分别介绍每个维度的评估方法，并提供相应的Python代码示例
进行演示。
BLEU(双语评估研究）
ROUGE（面向召回的研究评估）
参考文本：“猫坐在垫子上”
参考文本：“隔坐在垫子上”
候选文本：“猫正坐在垫子上”
候选文本：“猫正垒在垫子上”
N元语法精确率
衡量N元语法重叠度（召回率）
·ROUGE-1:一元逐达重叠（理”“全”，等）
“一元语活：“雪”，“全”正里”“在”“量子”“上”
·如果候选文本较超则应用简超场罚
·ROUGE·2二元适法重叠（量星”*星在”等）
MRR（平均倒数排名）
Top-K召回率
查询：“法国的首都是什么？”
查询：“2024年最佳智能手机”
相关项目：A,B,C,D.E（共5项）
排名结果
1.巴称(正确）侧数排名= 1/1= 1.0
系统返回：A.F.C,G,B,H.LJ,D,K
2.星昂→倒数排名=1/2=0.5
·Top-3召尽率：25=0.4(AC在AB,C,D,E中)
MRR=所有查询的例数排名的甲均值
Top-10B显率: 4/5 = 0.8 (A,C,B,D在AB,C,D,E中)
mR(中均效)
查询：“法国的首都是什么？”
查询：“2024年最佳智能手机”
排名结果
相关项目：A,B,C,D,E（共5项）
1.巴容（正确）→侧数排名=1/1=1.0
系统返国:A,F,C,G,B,H,L,J, D,K
2.星昂-到数排名=1/2=0.5
To>-3召国率:25 =0.4(AC在AB,C,D,E中)
· Top-10日国率:4/5 = 0. (AC.B,D在AB.C.,D,无中)
MRR=所有查询的例数排名的平均值
计算示例
BLEU计算
MRR和Top-K计算
查询1：正确答案在第1位→1/1*1.0
参考：“在垫子上”
查询2：正确答案在第3位13=0.33
候选：“显坐在垫子上”
一元速法精确率：4/5=0.8
查询3：正确答案在第2位→1/2=0.5
MRR =(1.0 +0.33 +0.5)/3 =0.61
二元返达精确率：34=0.75
BP(黄短是罚)xp(1-4/5) = 0.82
Top-5日图率=（前5位中相关项日数）/
BLEU = BP x (P,xP;xP;xP)0.25
（所有相关项目总数）
1.1召回率/准确率评估
该维度评估RAG系统回答问题的正确性和检索相关性，主要包括
·答案准确率：比较生成的答案与标准答率的匹配程度，可使用自然语言处理中的评价指标如BLEU（衡量n元语
法匹配程度）、ROUGE（衡量召回的n元语法覆盖率）等来量化答案与参考答案的相似度。
·检索召回率：评估检索模块是否找到了包含正确答案的文档。例如计算Top-k召回率（正确答案所在文档是否
出现在前k个检索结果中）以及MRR（平均副数I名），以衡量正确文档在检索结果中的位置（MRR越高表示
相关文档排名越靠前）
下面的代码示例展示如何计算BLEU分数，ROUGE分数来评价答率准确率，以及计算检索结果的MRR和Top-
k召回率。在示例中，我们构造了一个问题的参考答案和系统生成答案，十算它们的BLEU和ROUGE；同时模拟
检索结果列表和相关文档ID来计算MRR和Top-3召回率。
import math
示例参考普宝和系统生成的答案（以金融保险问答为例）
reference_answer-“您的汽车保险可赔信医疗费用，车辆维修费，以及简三方损害赔信。”标准答案
generated_answer-“您的保单通常通盖车后的医疗费用、车辑损失，以及对菌三方的赔信。“系统生成答寓
计算BLEU分数（基于逐字/逐词匹配）
from nltk.translate.bleu_score Import sentence_bleu, SmoothingFunction
def tokenize_text(text)
将中文文本逐字分隔（去除标点）。用于计算BLEU/ROUGE。
对于英文可按空格分词。
10
11
12
import re
tokens - []
13
for ch in text
14
If re,match(r′[\u4eoo-\u9fff]', ch) or re.match(r*\w', ch)
15
tokens append(ch)
16
17
return tokens
18
ref_tokens = tokenlze_text(refer
from nltk.translate.bleu_score import sentence_bleu
7 + def tokenize_text(text)
将中文文本逐字分隔（去除标点）。用于计算BLEU/ROUGE。
对于英文可按空格分词。
18
11
12
Import re
tokens = []
13
for ch In text
14
1f re.match(r*[Vu4eoe-\uofff]。 ch) or
15
ch)
re.matcn(r
16
tokens.append(ch)
return tokens
17
ref_tokens = tokenize_text(reference_ansuer)
18
gen_tokens - tokenize_text(generated_ansHer)
19
计算8LEU（这里采用1-4元模型加权平均）。使用平清以道通免零分
28
chencherry - SmoothingFunction()
21
bleu_score = sentence_bleu([ref_tokens]. gen_tok
22
thod1)
print(f"BLEU分数： (bleu_score:.3f)")
23
计算 ROUGE-1 和 ROUGE-2 分数（F1值)
24
25 + def calc_rouge_f1(ref_tokens, gen_tokens, n=1)
26
生成n元gra列表
def ngrans(tokens, n)
return (*".join(tokens[1:i+n]) for I in range(len]
28
is)-n+1))
102
ref_ngrans = ngrans(ref_tokens, n)
29
38
gen_ngrans = ngrams(gen_tokens, n)
overlap = ref_ngrans & gen_ngrans
31
1f len(gen_ngrams) -= B or len(ref_ngrams)
32
33
return 0.0
34
precision - len(overlap) / len(gen_ngrams)
recall - len(overlap) / len(ref_ngrams) if len(ref_ngrams) 1- e else @
35
f1 = 0 if (precision+recall)=8 else 2 * precision * recall / (precision + recall)
36
return f1
37
rougei_f1 - calc_rouge_f1(ref_tokens, gen_tokens, n=1)
38
rouge2_f1 = calc_rouge_f1(ref_tokens, gen_tokens, n=2)
39
print(f-ROUGE-1 F1: (rouge1_f1:.3f), ROUGE=2 F1: (rouge2_f1::3f))
48
■模拟检素结果和相关文档ID列表，用于计算HR和Top-k召回率
41
42 + retrleved_docs_1ist = [
查询1的检索结果文档ID（按相关性排序）
43
[10, 3, 7, 2, 5]
查询2的检索结果文档ID
[6, 4, 9, 1, 8]
44
45
relevant_doc_1ds-[3，9]查询1和查简2各自的正确答鼠所在文档ID
46
计算HRR（平均删数排名）
47
48 + def mean_reciprocal_rank(retrleved_1ists, relevant_ids)
total_reciprocal_rank = 0.0
49
for docs, rel_id In zip(retrleved_1ists, relevant_ids)
50
51
rank = 0
52
for 1, doc_id In enumerate(docs, start=1)
53
if doc_id-rel_id:找到相关文档
rank - 1
54
55
break
56
If rank > 0
57
total_reciprocal_rank += 1.e / rank
return total_reciprocal_rank / len(relevant_ids)
58
nean_reciprocal_rank(retrleved_docs_list, relevant_doc_ids)
65
37
return f1
rougei_f1 - calc_rouge_f1(ref_tokens, gen_tokens, n=1)
38
rouge2_f1 - calc_rouge_f1(ref_tokens, gen_tokens, n=2)
39
print(f"RoUGE-1 F1: {rouge1_f1:.3f), ROUGE-2 F1: (rouge2_f1:.3f)")
48
模拟检素结果和相关文档ID列表，用于计算MRR和Top-k召回事
41
42 + retrleved_docs_1ist - [
查询1的检素结果文档ID（胺相关性排序）
43
[10, 3, 7, 2, 5]
查2的检素结果文档ID
44
[6, 4, 9, 1, 8]
45
relevant_doc_1ds-[3，9]查询n和直海2各自的正确答室所在文档ID
46
计算RR（平均创政排名）
47
48 + def mean_reciprocal_rank(retrieved_lists, relevant_ids)
total_reciprocal_rank = B.8
49
for docs, rel_id 1n zip(retrleved_lists, relevant_ids)
58 +
51
rank = θ
for 1, doc_id In enumerate(docs, start=1)
52
53
1f doc_id*rel_id:龙到相关文档
rank = 1
54
break
55
56
1f rank > θ
total_reciprocal_rank += 1.e / rank
57
return total_reciprocal_rank / len(relevant_ids)
58
mrr - mean_reciprocal_rank(retrleved_docs_list, relevant_doc_ids)
59
print(f"HRR: (mrr:-3f)²)
68
61
62
top_k = 3
hits = θ
63
64 + for docs, rel_id 1n zip(retrleved_docs_list, relevant_doc_ids)
1f rel_id In docs[:top_k]
65
66
hits += 1
recall_at_3 = hits / len(relevant_doc_1ds)
67
68print(f-Top-(top_k} 召国需: {recal1_at_3::2f)")
上述代码首先将中文答案逐字分词，然后计算BLEU分数（例如输出一个0~1之间的小数。值越高表示答案与参考
答案越接近），接着计算ROUGE-1和ROUGE-2的F1分数，用于评估答案对参考答案的夏盖率，随后，代码通过模
（输出Top-3召回率：1.00表示每个查询的相关文档都在前3个结果中），这些指标可以全面反映系统在答案
准确性和检索相关性方面的表现。
1.2生成答案的可信度评估
这一维度关注生成的答案在多大程度上有文档支持，以及答案内容和检索到的文档是否一致。可靠。具体包括
·答案与支持文档匹配度：验证生成答案中的关键信息是否能在检索文档中找到，可以计算答案和支持文档之间
的相似度或重合率，例如关键词重叠度。
·文档覆盖率：检查检索到的文档是否覆盖了回答所需的所有要点。如果答案涉及多个要点，评估这些要点是否
均能在提供的文档集合中找到依据。
下面的代码示例演示如何评估答案与支持文档的匹配程度，我们假设系统生成了一个答案以及相应的支持文档列
表，通过计算答案文本与检索文档文本的重叠情况来衡量可信度，这里使用简单的分词和集合重叠率来表示文档对
答案的覆盖率（即有多少比例的答案关键词出现在支持文档中）。
1.2生成答案的可信度评估
这一维度关注生成的答案在多大程度上有文档支持，以及答案内容和检素到的文档是否一致、可靠。具体包括
·答案与支持文档匹配度：验证生成答案中的关键信息是否能在检索文栏中找到。可以计算答案和支持文档之间
的相似度或重合率，例如关键词重叠度。
·文档覆盖率：检查检素到的文档是否覆盖了回答所需的所有要点。如果答案涉及多个要点，评估这些要点是否
均能在提供的文档集合中找到依据。
下面的代码示例演示如何评估答案与支持文档的匹配程度，我们假设系统生成了一个答率以及相应的支持文档列
表，通过计算答案文本与检索文档文本的重叠情况来衡量可信度。这里使用简单的分词和集合重叠率来表示文档对
答率的覆盖率（即有多少比例的答案关键词出现在支持文档中）。
Python
示例系统生成的答案和检素到的支持文档片段
generated_answer·“您的保单通常涵善车桐后的医疗费用，车辆损失，以及对简三方的赔信。
3 + supporting_docs = [
“相据保险条款，医疗费用和车辆损失在车构理路中可以获得路情。“。
另外，如果您对期三方适成损害，保险也会提供担应的赔付。
将支持文档合并为一个文本，便于整体匹配
combined_docs_text - "".join(supporting_docs)
简单分词（与前面相同的盈数）联取闻汇集合
answer_tokens = tokenize_text(generated_answer)
10
doc_tokens = tokenize_text(combined_docs_text)
12
answer_set = set(answer_tokens)
doc_set = set(doc_tokens)
13
计算答属中的词在文档中出现的比例（覆盖率）
14
common_tokens - answer_set & doc_set
coverage_ratio - len(common_tokens) / len(answer_set) if answer_set else 0.0
16
17print（f"支持文档对答属内者的盖罩：(coverage_ratio.2f）"）
在上面的示例中，我们将生成的答案和两个支持文档片段进行比较。代码统计了答案中有多少独特词汇出现在支持
文档里，并计算覆盖率。例如，输出的覆盖率可能是0.73（73%）。表示答案中约73%的词语能在提供的文档中
找到依据。这个指标越高，说明答案几乎完全基于检素到的内容，可信度越高。此外，在实际应用中还可以通过橙
查引用（如答案是否引用了支持文档的内容片段）或使用向量相似度计算答案和文档的语义匹配度，从而进一步评
估答案的可信可靠程度。
1.3系统响应速度评估
在金融保险业务场景中，用户提问往往帮望即时得到答案，因此系统的响应延退是关键指标，本部分评估RAG系统
处理查询的速度，包括
·平均响应时间：系统处理单个查向的平均用时。
·P95/P99延迟：95%和99%的请求在多少时间内完成（尾部延迟）。用于评估最慢响应的情况
·整体响应分布：可以会制响应时间分布图（如直方图）来了解大部分查询的延迟范围（本示例中不绘制图表。
仅说明指标）。
下面的代码示例横拟了多次查询的咱应时间数据，并计算平均响应时间以及P95、P99延迟。实际应用中，这些数据
可以通过记录系统每次查询的处理起止时间获得。
1.3系统响应速度评估
在金融保险业务场景中，用户提问往往希望即时得到答案，因此系统的响应延迟是关键指标，本部分评估RAG系统
处理查饲的速度，包括
·平均响应时间：系统处理单个查询的平均用时。
·P95/P99延迟：95%和99%的请求在多少时间内完成（尾部延迟），用于评估最慢响应的情况
·整体响应分布：可以绘制响应时间分布圆（如直方图）来了解大部分查询的延迟范围（本示例中不绘制图表
仅说明指标）。
下面的代码示例惯拟了多次查询的响应时间数据，并计算平均响应时间以及P95、P99延退。实际应用中，这些故据
可以通过记录系统每次查询的处理起止时间获得。
Python
1mport randon
模拟168次查询的响应时问（秒），这里用题机数模税实际的查询延迟
response_times - [random.uniform(e.1, e.3) for _ in range(1ee)]# 假设每次查国ABo.1-0.3秒
计算平均响应时间
average_time - sun(response_times) / len(response_times)
计期P95和P99延迟（先对时问排序，然后取第95%，99%位置的值）
response_times.sort()
[t - ((souasuodsau)uaT . 56e)sur]souasuodsau = os6d 8
[ - (（sougsuodsauu . 66e）u]saasuodsa - ou66d6
18print（f-平均响应时间：（average_time:.3f）秒")
11print(f"p95 i退: (p95_time::3f) 秒)
12 print(f"Pp99 延i退: (p99_time::3f) 秒")
上述代码将输出例如平均响应时间：0.200秒”，表示平均每次回答耗时0.2秒左右：以及“P95延退：0.28秒，P99
延退：0.29秒”等，用于表示95%请求在0.28秒以内返回，99%请求在0.29秒以内返回，通过这些指标，可以评估
系统在响应速度方面的一致性和稳定性，如果P99远高于平均值，说明少数查询存在是著延退，需要优化最慢路径
的性能。
1.4可扩展性评估
可扩展性评估旨在测试RAG系统在不同数据规模和负载下的性能表现，包括
·数据规模扩展：增大知识库或文档集规模，观察检索和生成性能的变化（如响应时间是否随故据量线性增长。
检索准确率是否保持稳定）。
·吞吐量：衡量系统每秒可处理的查词数（QPS）。以及在高并发情况下的性能表现。
下面的代码示例通过横拟不同规模的数据集来测试检素操作的耗时，从而推测可扩展性。我们假设检索操作的复杂
度随数据规模增加而提高，并测量每种规模下每查询的平均耗时和吞吐量（每秒查询数）。在实际系统中，可通过
压力测试工具并发发送查词来测量最大吞吐量
1import time
#不同的数集规模（文档数量）
dataset_sizes - [1e88, 10088, 100080]
for size In dataset_sizes
模拟一个包含s{ze个文档ID的检素空间（例如使用列表模拟）
1.4可扩展性评估
可扩展性评估旨在测试RAG系统在不同数据规模和负载下的性能表现。包括
·数据规模扩展：增大知识库或文档集规模，观察检索和生成性能的变化（如响应时间是否随数据量线性增长
检索准确率是否保持稳定）。
·吞吐量：衡量系统每秒可处理的查询数（QPS）。以及在高并发情况下的性能表现。
下面的代码示例通过模拟不同规模的数据集来测试检索提作的耗时，从而推测可扩展性，我们假设检索操作的复杂
度随数据规模增加而提高。并测量每种规模下每查询的平均耗时和吞吐量（每秒查询数）。在实际系统中，可通过
压力测试工具并发发送查询来测量最大吞吐量。
Python
inport tine
不同的数据集规损(文档数量）
dataset_sizes - [1000, 10000, 100000]
+ for size in dataset_sizes
损拟一个包含size个文档ID的检素空间（例如使用别表模拟）
data - 1ist(range(size)
0oT - saruanbases"anu
start_tine - time,time()
模拟检素：对每个查询在数据列表中查找一个不存在的ID（最坏情况道历整个列表）
for _ in range(nus_test_queries)
10
--（size+1）1ndata查询一个不在列表中的元素以模拟完整扫菌
11
end_tine - time,time()
12
total_tine - end_tine - start_tine
13
avg_time_per_query - total_time / num_test_querfes
14
throughput - nu_test_querles / total_time
15
print（f“数网集现模：《size:6d）条，平均查词邦时：{avg_time_per_query*10o:.3f]ms，香吐量：{thrt
16
运行上述代码，可以观察到题着数据集规模从1000增加到10000，横拟的平均查询耗时从约0.017毫秒增加到1.6
毫秒，每秒可处理的查询量从约5.9万降低到约618次。这反映了检索操作随数据增长而变慢，从而吞吐量下降的趋
势。在真实RAG系统中。如果使用了高效的索引结构（例如向量索引、倒排索引），性能下降可能不会如此明显
但仍需要通过测试不同故据规模来确保系统能够平稳扩展，当数据规模更大或并发查询更多时，我们也需要观察系
统的CPU、内存占用和网络IO，以发现潜在的瓶颈并进行优化。
1.5用户体验评估
用户体验评估侧重于系统给用户带来的主观感受和易用性，包括
·人工满意度评价：通过人工评估或用户反馈来打分，衡量用户对答案的满意度，例如收集用户评分（1-5分）或
对答案是否解决问题的二元反馈，以计算平均满意度分或满意率。
·答案可读性：评价生成答案表述的清晰易懂程度。可以使用可读性评分（如基于句子长度和词汇复杂度的指
标）来定量分析答案文本的可读性，确保答案语言简洁明了，便于用户理解。
下面的代码示例展示如何计算用户满意度的平均分，以及如何计算答案文本的可读性评分（使用英文文本的Flesc
阅读容易度作为示例）。在实际应用中，可读性也可以使用类似方法对中文文本进行评估（例如通过句子长度和专
业术语比例等指标）。
示例：用户对若干答案的满意度评分（1-5分制）
运行上述代码，可以观察到随看故据集规模从1000增加到100000，横拟的平均查问耗时从约0.017毫秒增加到1.6
毫秒，每秒可处理的直词量从约5.9万降低到约618次。这反映了检索操作随数据增长而变，从而吞吐量下降的趋
势。在真实RAG系统中，如果使用了高效的索引结构（例如向量索引、倒排索引），性能下降可能不会如此明显
但仍需要通过测试不同故据规横来确保系统能够平稳扩展。当故据规模更大或并发查询更多时，我们也需要观察系
统的CPU、内存占用和网络IO，以发现潜在的瓶颈并进行优化。
1.5用户体验评估
用户体验评估侧重于系统给用户带来的主观感受和易用性，包括
·人工满意度评价：通过人工评估或用户反馈来打分，衡量用户对答案的满意度，例如收集用户评分（1-5分）或
对答案是否解决问题的二元反馈，以计算平均满息度分或满意率。
·答案可读性：评价生成答案表述的清晰易懂程度。可以使用可读性评分（如基于句子长度和词汇复杂度的指
标）来定量分析答案文本的可读性，确保答案语言简洁明了。便于用户理解。
下面的代码示例展示如何计算用户满意度的平均分，以及如何计算答案文本的可读性评分（使用英文文本的Flesc
阅读容易度作为示例），在实际应用中，可读性也可以使用类似方法对中文文本进行评估（例如通过句子长度和专
业术语比例等指标）。
Python
春示例：用户对若干答案的满意度评分（1-5分制）
user_ratings-[5，4，5，3，4，4，5]收集的9用户满息度评分
average_rating - sum(user_ratings) / len(user_ratings)
print(f"用户满意度平均评分：[average_rating;,2f} 分（满分5分）“)
计期答家的可读性（FLeschReoding [dse，可用于英文文本）
e e Jage siso teipau sus Atredas Aorrod Jno, - axaaJansue
有统计句子数，单闻致和音节数束计算可读性
Inport re
sentences = re.split(r*[-1?]+*, answer_text)
sentences - [s for s In sentences If s.strip()] # 去除空句子
10
word_1ist - re.findall(r*\u+*, answer_text)
num_sentences - len(sentences)
num_words - len(word_1ist)
13
非租畸计算音节数：按元音片段计数（英文中用于近似音节）
14
Anor3vAnoree_ - stenoA
15
num_sy1lables - @
16
17 + for word In word_1ist
word_lower - word.lower()
18
19
syllables - 0
20
prev_vowel - False
21
for char in word_lower
If char in vowels
遇到薪的元音细合则算
23
个售节
24
If not prev_vowel
25
syllables += 1
prev_vowel - True
26
27
else
prev_vowel - False
28
简单调整：单闻以静音e站尾的，减去一个音节
29
If word_lower.endsuith(*e°) and syllables > 1
38
syllables -* 1
31
至少保证每个单闻前1个音节
32
num_sy1lables += max(sy1lables, 1)
33
19
syllables = 0
prev_vowel - False
20
21
for char in word_lower
22
If char In vowels
遇到新的元音绍合则算一个音节
23
If not prev_vowel
24
syllables + 1
25
26
prev_vowel - True
27
else
prev_vowel - False
28
简单调整：单词以静音e结尾的，减去一个音节
29
If word_lower,endswith(*e") and syllables > 1
30
31
syllables -- 1
32
至少保证每个单罚即1个音节
num_sy1lables +- max(sy1lables, 1)
33
34
计算FLesch阅读容易度得分（分数越高表示越容易阅读）
If nus_sentences > e and nus_words > @
35
ASL -num_words /nus_sentences平均每句单词数
36
ASW - nun_syllables / nus_words#平均每闻音节致
37
M5v . 98 - 15v . 510*t - 58*90z - a0s4259
38
print(f=答室可读性（Flesch得分）：{flesch_score:.2f}")
39
在这个示例中，我们首先计算了一组用户满意度评分的平均值，例如，若用户评分列表为[5,4,5,3,4,4,5]，则
输出”用户满意度平均评分：4.29分”，表示总体满意度较高。真实场晨中，我们可以进一步统计满意度评分的分布
（如满意（4-5分）比例）以评估用户体验。
接着，我们示范了如何计算答案文本的可读性。以上代码对英文答案文本计算了Flesch闷读容易度分数。例如。
输出结果可能是答案可读性（Hlesch得分）：16.10，Fesch得分在0-100之间，分数越高说文本越容易阅读（例
如日常英语对话可达到60-70以上，而16属于较难阅读的专业文本）。在金融保险场景下，我们希望答案措辞清
晰、行文简洁。如果可读性评分偏低，说期答案可能过于元长或专业术语过多，需要优化表达。在中文场景下，可
采用类似思路，如根据每句话的字数、专业术语占比等计算一个可读性指标。以确保回答让非专业用户也容易理
通过以上五个维度的评估（准确性、可信度、速度、扩展性和用户体验），我们可以全面衡量金融保险间答系统中
RAG模型的性能。这些评估方法相互配合，有助于发现系统的优缺点：既要确保答案准确且有依据，又要保证系统
运行高效。能够扩展，并最终让用户获得满意的使用体验。
