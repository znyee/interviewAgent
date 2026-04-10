# 【RL强化学习】DPO概念图解+手撕损失+训练

- Source Root: `note`
- Source Path: `2026-04-09 01_33_51-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 15

【RL强化学习】DPO概念图解+手撕损失+训练
本文讨论了强化学习中DPO（Direct Preferenoe Optimizaton）的概念，训随方法、代码实现、数据售构适，训炼示例及
1、DPO在做一件什么事
模型生成），直接调整模里参数，让模型越来越倾向生成人类偏好的“好答案”回答。
PPO本质上是让模型生成答案，rewardmodel根据生成实时打分（reward），根据打分结果结合3个
损失调整模型参鼓，让模型倾向于生成获得更多reward的回答
Direct Preference Optimization (DPO)
rning from Human Feedback (RLHF)
Label rewards
LM policy
reward model
final LM
preference data
maximum
Uilkelihood
reinforcement learning
Uikelihood
传统方法（RLHF-PPO）的复杂流程
■先训练奖励模里（学评分标准）
再让模型参加"考试”（生成回答)
根据奖励模型打分（考试分数）
■用复杂强化学习调整横型（PPO算法）
DPO的训练原理
直接把步家简化为
■拿一对人类标注的【好答案vs坏答案】
对比两个答案的概率差异
调整模型参数。让好答案概率+坏答索概率！
举个通俗刚子
假设用户问：“如何做蛋糕？
·传统方法：先训练一个美食评委（奖励模型），让评委给不同做法打分，再让图师（语言模型）根据评分改进
配方
·DPO方法：直接拿【正确配方Vs错误配方】的对比，告诉厨师：“看到没？这种加鸡蛋的顺序才对，那种会烤焦
的别学！“
数学角度不同点
s1提前准备好的偏好数据
选择这组数据
拒绝这组数据
2.2准备好两个模型
s2准备好2个模型
别开始训练时和PoicyMode相同，但是
过程中进行训练的模型
参数冻结不参与训练，用来约束Policy
Model不要离初始参数太远
2.3计算loss
s3计算损失
此时我们并不需要看输入“天空是什么顾色的”之后两个model分别生成什么的，只需要看“天空是
新蓝色的“与“太阳是红色的“这些oken在两个模型中对应的生成率是多少
具体实现方法是直接章偏好数据中生成序列的每一个oken的ic直接去查logit值
CDPo(; πet)=B(z)~
）βlog（2)
logα
πg（3|z)
mer(ye|z)
πer(n|z)
2.3DPOLoss分析
训练Loss如下
[-）a)()
相关符号的解释
π(y[z)
πer（3|z)
2.3DPOLoss分析
训练Lo55如下
相关符号的解程
sigmold通数
β：超参数。一般在0.1-0.5之间
Ue：某条偏好数据中好的response，w就是win的意思
斯：基条偏好数据中差的response，就是loss的意思，所以偏好数据也叫comparision data
t（y|z）：给定输入x，当前policymodel生成好的response的累积概率（每个tokne的概率求和，具体看代码）
Ta(（rz）：给定输入x，原始损型（referencemodel）)生成坏的response的累职概率
开始训练时，referencemodel和policymodel都是同—个模里，只不过在训练过程中referencemodel不会更新权
为了方便分析，我们把log里的分式展开，然后P设为1，并且暂时不看前面的log_sigmoid，那么上面的loss可以简
化为
[log p(3) log Prr()] [log p(3) log Prr(3)]
由于最初loss前面是有个负号的。所以优化目标是让本简化公式最大，即我们帮望左半部分和右半部分的margin越
大越好，左半部分的含义是goodresponse相较于没训练之前的累积概率差值，右半部分代表badresponse相较于
没训练之前的累计概率差值，如果这个差值，即margin变大了，就意味着
1）左边变大，右边变小，理想情况。goodresponse概率提升，badresponse概率下降
2）左边变小，右边更小，goodresponse概率下降，但是badresponse概率下障的更多，生成的时候还是倾向
于good response
3）左边变的更大，右边只大了一点点。和2）同理
所以这个loss颜有一种对比的感觉。
3、可运行最小代码
思考题
1、这部分最后loss计算了为什么是0?
2、在计算了loss之后应该如何选代？
为了方便分析，我们把log里的分式展开，然后P设为1，并且暂时不看前面的log_slgmold，那么上面的loss可以简
化为
[log p(3u) log Prer(y)] [log p(3) log Prer(r)]
由于最初loss前面是有个负号的。所以优化目标是让本简化公式最大，即我们帮望左半部分和右半部分的marglin越
大越好，左半部分的含义是goodresponse相较于没训练之前的累积概率差值，右半部分代表badresponse相较于
没训练之前的累计概率差值，如果这个差值，即margin变大了，就意味着
1）左边变大，右边变小，理想情况。good response概率提升。badresponse概率下降
2）左边变小，右边更小，goodresponsc概率下降，但是badresponse概率下隐的更多。生成的时候还是候向
于good response
3）左边变的更大，右边只大了一点点，和2）同理
所以这个loss额有一种对比的感觉。
3、可运行最小代码
思考题
1、这部分最后loss计算了为什么是07
2、在计算了loss之后应该如何这代？
fnport torch
Import torch.nn.functional as F
fros transformers Inport LlamaForCausalLM, LlamaConfig
from copy inport deepcopy
torch,manual_seed(e)
1f _name_
"_nain.
超参数
beta - 0.1
10
加截模型
policy_model - LlamaForCausalLH(config=Llama
11
ab_size=1ee0, nu=_hidden_layers=1, hi
12
reference_nodel - deepcopy(policy_model)
13
14
# data
prompt_ids - [1, 2, 3, 4, 5, 6]
15
good_response_ids - [7, 8, 9, 10]
16
对1oss用加修改可以应对一个good和多个bad的情况
17
bad_response_ids_1ist - [[1, 2, 3, 0], [4, 5, 6, e]]
18
19
转换成模型输入
28
Input_ids - torch.LongTensor(
21
[prompt_ids + good_response_ids, *[prompt_ids + bad_respot
22
ise_ids for bad_response_ids 1
23
labels 提前做个shift
24
labels - torch.LongTensor(
25
print(len(logits[0]))
35
per_token_logps - torch.gather(loglts.log_softmax(-1), dim=2, Index=labels.u
36
(sdotuaxoad)aud a
37
al1_logps - (per_token_logps * 1oss_mask)-sum(-1)
38
print(al1_logps)
39
暂时写死第一个是goodresponse的概率
40
policy_good_logps, policy_bad_logps - all_logps[:1], all_logps[1:]
41
42
计算 reference model的log prob
43
with torch.no_grad()
44
logits - reference_model(Input_ids)[*loglts"][:, -1, =]
45
per_token_logps - torch-gather(loglts-log_softmax(-1), dim-2, Index=labels.
46
al1_logps - (per_token_1logps • 1oss_mask) -sm(-1)
47
暂时写死第一个是goodresponse的威率
48
49
reference_good_logps, reference_bad_logps - all_logps[:1], al1_logps[1:]
50
计算1oss，会自动进行广播
51
52
logits - (policy_good_logps - reference_good_logps) - (policy_bad_logps
loss - -F.logsigmoid(beta • 1ogits)-mean()
53
S4
print(loss)
4、DPO训练
4.1数据集构造
4.1.1开源的DPO数据集
在huggingface或modelscope中搜索DPO，然后找到适合你场景震求的数据集
Huging Face
kys
训练鼓据格式
Caky
训炼数据格式
"task_category": "xxx"
"pronpt": "xxx"
"xxx, +_auauos_}] +_uasou>
"role”: “user")
{"content": "x*”
"role": "assistant"}]
"rejected": [{"content": “xx"
"role°: “usee")
10
{"content":“xxx"
"role": "assistant"}]
11
"fd": “xx"
12
13
4.1.2自己构造
方法一：拒绝采样
·拒绝采样方法原理
通过当前模型生成候选响应，利用奖励模型筛选优质/劣质样本，直接构建对比训教据。核心步蛋如下
1.生成候选响应
·输入：给定一个提示（prompt）
·过程
便用当前横型（提议分布）生成*N个候选响应**（response)
通过调整tenperature参数控制生成多样性
设置do_sample=True启用随机采样，确保响应多样性
2.评分与筛选
·奖励模型评分
将生成的N个响应输入预训练的奖励模型（RewardModel，RM）
1.生成候选响应
·输入：给定一个提示（prompt）
·过程
使用当前模型（提议分布）生成“N个候选响应（response）
通过调整teaperature参敌控制生成多样性
设置do_sanple-True启用随机采样，确保响应多样性
2.评分与筛选
艾励模型评分
将生成的N个响应输入预训的奖励损型（RewardModel，RM）
。获得每个响应对应的标量分数（reward score）
数据筛选
Choscn响应：选择得分最高的响应（Top1）
Reject响应：选择得分最低的响应（Bottom1）
3.构造对比数据
·为每个prompt生成一个数据对
代码快
1 (prompt, chosen_response, reject_response)
·目标：让模型学习到chosen_response优于reject_response
·关键设计细节
1.提议分布与目标分布
提议分布：当前模型自身的输出分布
·目标分布：通过奖励模型筛选的优质响应分布（理想的语言模型输出）
2.多次采样的作用
·通过生成N个候选响应（N次采样），相当于在提议分布中放大搜察空间
提高捕提到高质量响应的概率（更接近目标分布）
3.奖励模型的核心角色
作为质量评判标准
·初期：筛选出符合基础质量要求的响应
·后期：推动模型输出更精细化的优质内容
·与传施方法的对比
特性
人工标注方法
拒地采样方法（DPO）
数据来源
模型自生成+奖励模型筛选
人工标注对比数案
·依赖奖励模型质量：若RM存在偏差，会导致错误优化方向
·探索效率问题：当模型初始质量较低时，可能难以生成有效候选响应->需要进行数据合成或多模型
采样
图示如下
生成不同的回答，进行打分
0.1
0.9
0.6
0.3
方法二：多模型对比采样
·核心思组
当SFT（监督微调）模型能力较醒时，通过引入多个不同能力/风格的模型生成响应，道免单一模型生成低质量
数据导致训练前渍。
·实施步骤
1.模型选择
选取3-4个不同特性的模型：·不同参数量（如7B/13B/70B）·不同训练目标（SFT/RLHF/DPO）·不同厂
商 (如Ulama/Mistral/DeepSeek)
2.响应生成
·对网一prompt，用所有选定模型生成响应
关键参数设置
temperature-8.1低题机性（文本生成任务）
max_new_tokens=512
3.质量筛选
使用API模型（如GPT-4o/Claude3）进行两阶段评估
初步过滤：剧除明显错误/无息义响应
1.
2.对比排序：对剩余萌应进行质量排序
数据构造
teaperature=@：1低顾机性（文本生成任务）
max_new_tokens=512
3.质量筛选
使用API模型（如GPT-4o/Claude3）进行两阶段评估
1.初步过滤：剧除明显指误/无意义响应
2.对比排序：对则余响虚进行质量排序
4.数据构造
·每组保留
chosen_response -最优响应
reject_response-最差响应
注意事项
模型差异控制
确保模型间能力差距不超过2个量吸（如7BVs13B可用，7Bvs70B不推荐）
游免同源模型（如Llama2-7B与Llama2-13B）组合使用
API使用技巧
对复杂任务添加评分标准
评估提示示例
请根际以下标准评分（1-10)
1.逻辑连贯性（权重40%）
2.事实准确性（权重30%）
3.表达简性（权重30%）
方法三：合成数据构建
核心思想
通过结构化数据生产和严格质量控制，人工构建高质量慎好数据集。
实施流程
1.技能库建设
三圾分类体系
级分类：领域
prompt·清晰明确的指令
chosen·专家验证的优质回答
reject·人工构适的典型措误回答
3.数据扩增
Prompt生成模板
编程类模板示例
请用(语言)实现(功能}，要求[的束条件}“
自动生成参数组合
1anguage - ["Python", "Java", “C++"]
“二叉树迪历”，“HTTP套户缺”]
func-[“快速排序”
4.响应生成
使用混合模型生成候选
if任务复杂度>调值
使用GPT-4/Claude 3生鼠
else
便用本地SFT模型生成
5.质量控制
双重校验机制
1.自动过滤
重复检测（相似度>98%别除）
基础辑法检查（代码/公式）
2.人工审核
专家技分类抽样审查（5-18%样本）
措误样本追离修正生成链路
方法对比
多模型对比采样
合成致钢构建
维度
数据质量
依赖API模型判断力
人工可控的高精度数案
双重校验机制
1.自动过滤
重复检测（相似度>90年剔除）
基础雷法检查（代码/公式）
人工审核
专家接分类抽择审查（5-100样本）
指误样本组离修正生晟链路
方法对比
维度
多损型对比采样
合成数理构建
依赖API模型判新力
数据质量
人工可控的高精度数据
人力级本为主
成本
API调用成本较高
适用阶段
模型中期优化
冷瘤动/关键能力建设
优势场景
开放域对话对齐
专业领域知识对齐
选代速度
快（自动化流程）
侵(人工介入多）
4.2DPO训练示例代码
数据格式
代码快
data = [
“prompt”：“你好，请介招—下transformers库？“。
“chosen”：“Transformers是一个强大的目然语言处理库，支持-”
“rejected”：“不清是”
““零置一。dd
"rejected”：“量子力学就是科学，没哈好说的。
10
11
ZT
13
示例代码
inport torch
Import math
from torch.utils.data Import Dataset
"rejected”：“不清楚”
置一
"rejected”：“量子力学就是科学，没啥好说的。“
18
11
12
13
示制代码
Import torch
import math
from torch.utils.data import Dataset
from transformers Import (
AutoTokenizer
AutoModelForCausalLH
Trainer
TrainingArguments
default_data_collator
10
11
Import torch.nn.functlonal as
12
13
14
1.构造示例数据
15
16
example_data = [
17
“prompt”：“你好，请介招—下transformers库？”
18
“chosen”：“Transforers是一个开的目然语言处理库，支持多种预训练模型_“
19
2e
"rejected”:“不如道"
21
22
23
24
“rejected"：“量子力学就是一个很神秘的理论吧”
25
27
这里再加更多数据
28
29
3θ
2.数据模板&数据集
31
32
33
34
class DPODataset(Dataset)
35
DPO数据售：输入包含prompt。chosen、rejected。我们在这里进行
36
（propt +chosen）与（propt +rejected）的拼接，井存铺它们的
37
Input_ids 和 attention_mask 以便后续训练使用。
38
39
4e
def __init__(self, data_list, tokenlzer, max_length=512)
22
23
24
“chosen”：“量子力学研究微观垃子在原子和亚原子尺度下的行为-”
"rejected"：“量子力学就是一个很神秘的理论吧”
25
26
27
这里再加更多数据
28
29
38
31
2.数据模根&数报售
32
33
class DPoDataset(Dataset)
34
35
DPO数据集：输入包含proapt。chosen、rejected。我们在这里进行
36
（propt + chosen）与（prompt +rejected）的期接，并存铺它们的
37
Input_ids 和 attention_mask 以便后续训练使用。
38
39
def __init_(self, data_list, tokenizer, max_lengtha512)
48
41
super()._init_()
self.data_1ist = data_list
42
43
self.tokenizer = tokenizer
self.max_length = max_length
44
45
46
self.processed - []
47
for Iten in self.data_list
prompt = Iten[*prompt*]
48
49
[uasoup_jaag - uasou
rejected - iten[*rejected°]
58
51
模板期接：你可以根据实际露求替换
52
chosen_text = f"间：: (prompt}\n董: (chosen)*
53
54
rejected_text = f"间: (prompt)\n董: (rejected)
55
chosen_enc = tokenizer(
56
chosen_text
57
max_length=self.max_length
58
59
truncation=True
6e
61
rejected_enc - tokenizer(
62
rejected_text
63
max_length=self.max_length
64
truncatlon=True
65
66
67
self.processed.append((
"chosen_input_ids": chosen_enc[“Input_ids*]
68
"chosen_attentlon_mask": chosen_enc[*attention_mask"]
69
"refected_input_ids": rejected_enc[*Input_ids*]
7e
"rejected_attentlon_mask*: rejected_enc["attention_mask*]
71
72
}）
73
（）p
74
return len(self.processed)
75
76
使用保留的偏好数据（未被训练使用的数据），计算模型对”偏好回答”（chosen）的似然概率是否显著高于
“被拒绝回答”（rejected）。
(）本
。与基线模型（如未经DPO训练的原始模型）进行对比，通过人类或奖励模型（RewardModel）判断生成结果
的优劣。
·奖励模型打分（如有）
。使用独立的奖励模型对生成结果打分，验证DPO模型是否输出更高奖励值的回答。
3.安全性与可靠性
·有害内容检测
使用分类器（如PerspectiveAPI）或人工审核，检测模型是否生成有害、偏见或敏感内容。
·校准度（Calibration）
验证模型是否过度自信（如通过ExpectedCalbration Error,ECE）。
4.任务特定性能
·根据具体任务设计指标
。问答任务：准确率、事实一数性（Factual Consistency）。
。对话任务：上下文连贯性、用户意图理解。
·代码生成：通过单元测试通过率评估功能正确性。
5.人类评估(Gold Standard)
·设计双盲实验，让标注员对比DPO模型与基线模型的输出，从多个堆度（如偏好、有用性、安全性）进行AB测
4.3.2评估步骤建议
1.明确评估目标
。确定主要优化方向（如安全性、偏好对齐、生成质量）或者领域中明确的接受/拒绝偏好
2.构建测试集
。包含多样化的输入样本，覆盖边缘案例（comercases）和常见场景。
。确保测试集与训练数据无重叠（避免数据泄漏）
3.自动评估
。批量生成结果。计算自动指标（如奖励模型打分、BLEU等）。
4.人工评估
抽样评估关键样本，设计标准化评分表以减少主观偏差。
5.分析结果
。对比DPO模型与基线模型的差异，统计显著性检验（如t-test）。
6.送代优化
。根据评估结果调整或改进偏好数据质量。
②实际工程中，一般是构造评测集basellne，所有的优化（不管是st，rhf还是其他优化策略）都会在评测集
上测试，测试通过后进行人工评估
·校准度（Calibration）
验证横型是否过度自信（如通过Expected Calbration Error,ECE）。
4.任务特定性能
·根据具体任务设计指标
问答任务：准确率、事实一致性（Factual Consistency）。
对话任务：上下文连贯性、用户意图理解。
。代码生成：通过单元测试通过率评估功能正确性
5.人类评估(Gold Standard)
·设计双盲实验，让标注员对比DPO模型与基线模型的输出，从多个维度（如偏好、有用性、安全性）进行AB测
4.3.2评估步骤建议
1.明确评估目标
确定主要优化方向（如安全性、偏好对齐、生成质量）或者领域中明确的接受/拒绝偏好
2.构建测试集
包含多样化的输入样本，覆盖边缘案例（comercases）和常见场景。
确保测试集与训练数据无重叠（道免数据泄漏）。
3.自动评估
·批量生成结果，计算自动指标（如奖励模型打分、BLEU等）。
4.人工评估
抽样评估关键样本，设计标准化评分表以减少主观信差。
5.分析结果
对比DPO模型与基线模型的差异，统计显著性检验（如t-test）。
6.选代优化
根据评估结果调整或改进偏好数据质量。
实际工程中，一般是构造评测集baseline，所有的优化（不管是st、rhf还是其他优化策略）都会在评测集
上测试，测试通过后进行人工评估
真诚点赞，手留余香
