# 【RL强化学习】GRPO概念图解+手撕损失+训练

- Source Root: `note`
- Source Path: `2026-04-09 01_34_13-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 7

【RL强化学习】GRPO概念图解+手撕损失+训练
本文讨论了GRPO（Grouped Relative Pollcy Optimization）的概念，与PPO的区别，训练过程及训练境程，关键要点包括.
1.GRPO在做一件什么事
一句话理解GRPO、PPO、DPO区别
GRPO
一组prompt经过LLM生成N个结果，每个结果打分，超过平均的被接受，反之被拒绝
Odd
一组prompt进过LLM生成1结果，对结果打分，和上一个的自己比较，有优势被接受，反之被拒绝
Od0
提前构造好了拒绝和接受的数据，模型参数往接受的方向调整
Reference
KL
Model
PPO
Reward
Policy
Model
GAE
Model
Value
Trained
Model
Models
Frozen
KL
GRPO
Models
Reference
Model
Poliey
Reward
02
F2
Model
0G
与PPO的两个核心区别
1.RewardModel不用训练，面是基于规则
-传统的RewardModel需要通过数据训练来学习奖励函数，而基于规则的RewardModel直接依赖于人工设定
的规则，无需训练。（A：在没有groundtruth的场景，比如写作等，也是通过人类标注来训练reward
model)
2.不用训练ValueModel去估计优势
-传统强化学习需要训练ValueModel来估计状态或动作的价值（如V(s）或Q（s,a)）。从而计算优势
(Advantage）。在某些方法下，可以直接便用策略梯度或基于规则的方式，而无需训练Value Model进行估
计。
M niouaN 5owhL
（A：在没有groundtruth的场景，比如写作等，也是通过人类标注来训练reward
的规则，无需训练。
model)
2.不用训练ValueModel去估计优势
-传统强化学习需要训练ValueModel来估计状态或动作的价值（如V(s）或Q（s,a)）。从而计算优势
(Advantage）。在某些方法下，可以直接使用策略梯度或基于规则的方式，而无需训练Value Model进行估
计。
Question: If α > 1, then the sum of the real solutions of √a √a + x = x is equal to
Response: <think>
To solve the equation √a √a +x = x, let's start by squaring both --
(√a-Va+x)
=x²=a-√a+x=x².
Rearrange to isolate the inner square root term
（a-x²)²=a+x=→a²=2ax²+（x²）)²=a+x=→x-2ax²-x+(a²-a）=0
Wait, wait. Wait. That's an aha moment I can flag here.
Let's reevaluate this step-by-step to identify if the correct sum can be *
We started with the equation
x=x+D-D
First, let's squareboth sides
a-√a+x=x²=√a+x=a-x²
Next, I could square both sides again, treating the equation: --
Deepseekr1Zero在训练后出现在推理过程中的自我反思调整的”Aha时刻”
2、图解GRPO训练
2.1模型准备
这里我们发现，只有3个model，比ppo少一个，且在rewardmodel用策略构建情况下，显存占用相对于PPO节约
50%
m1Actormodel
1.每一个step训练究成后
Folcy Mode
model的参数会更新。
S1模型准备
m2ref_model
model、ref_model
1.Actor Mod在训练一开始的时候的参数状
态，训练过程一直不变，用来计算L取度
reward策略（返图分数）
防止RLHF的训练距离已经有不错表现的模型
离太远
m3reward_model
2.4GRPO梯度更新
·输入查询q：输入查询9到策略横型（如上图所示），生成组内多个输出o_1，0_2.0_G
·计算奖励 R(og)）：将每个输出oj 输入到奖励模型R（-)），获得奖励 R（oi)，R（o2),R(oG)。
计算群体统计量
R(oj)
奖励均值PHG：PG
(R(o,)-μc)²
奖励标准差G：0G
R(o)-μG
·计算即体相对奖励A：对组内每个样本0，计算联体相对奖励：4
G+（
计算群组奖验
1.01红也）是序列长度，以第景生成为民，为
2.温得是一个promp生建的第结果，表示一个生成序列的个aken
3.注条生成多列的得分分图为0.1.0.2-0.8，那么0.1-0.4的为负优用，0.508的为正优势，优勇的计算的要划
009
[这里根据如图所示计算奖励之后，是直接将整个奖励值同步到每一个生成的token上，而不是像PPO需婴通过
value model去估计每个tokne的优势]
·计算提失函数L（0)：对每个样本0，计算基于4的损失：L,（0）=-1ogπg（olq）·49
·计算KL散度
[A这里根据如图所示计算奖励之后，是直接将整个奖励值同步到每一个生成的token上。而不是像PPO需要通过
value model去估计每个tokne的优势]
·计算损失函数L（0）：对每个样本0，计算基于4²的损失：L（0）=-logg（oq）·49
计算KL散度
iu
·更新目标函数JGRFO：将组内所有样本的损失取平均值，并加入KL散度惩罚
βDxL(=lo)
JGRro(0)
-1
梯度更新
Velogxs（oq)
基于目标函数$）_（GRPO)$，计算梯度：VJGRTO
BVsDxL
。使用优化器（如Adam）更新参数：0←0+aVaJGRro
2.5手撕损失GRPO损失函数
def grpo_loss(pi_logprob, pl_ref
len_of)
eps1lon - 0.2
beta - 0.01
bs, seq_len - pl_logprob.shape
skip计算采样的条条样本长度
len_ol - torch.tensor([len_ol] * g
设定eask，仅对response 计算loss
mask - torch.zeros(bs, seq_len)
mask[:, input_len:] - 1
10
11
12
# GRPO 1oss
13
ratio - torch.exp(pi_logprob)
ratio_clip - torch.clamp(ratio, 1 - epsilen, 1 + epsilon)
14
advantage - advantage.unsqueeze(dia - 1) [a, b, c] -> [a], [b], [<]]
15
policy_gradient - torch.minimus(ratio * advantage , ratio_clfp * advantage)
16
12
GRPO loss
ratio = torch.exp(pl_logprob)
13
ratio_clip - torch.clamp(ratlo, 1 - epsllen, 1 + epsllon)
14
15
advantage - advantage,unsqueeze(dlm - 1) ▪ [a, b, c] -> [a], [b], [c]]
policy_gradient - torch.minlmus(ratlo * advantage , ratlo_clip * advantage)
16
k1 - grpo_kl(pl_1ogprob, pl_ref_logprob)
17
18
loss - (policy_gradient - beta * k1) * mask
19
loss - (-1 / group_nus ) * (1/len_ol.unsqueeze(dim - 1)) * 1oss
20
21
loss - 1oss.su=()
22
return loss
23
3、GRPO训练流程
from modelscope Inport AutoModelForCausalLR, AutoTokenizer
Inport re
fnport torch
from datasets Inport load_dataset, Dataset
from transformers Inport AutoTokenizer, AutoHodelFerCausalLH
from trl iaport GRPOConfig, GRPOTrainer
1.横型准备
10
model_name - "./Qwen2,5-0.5B-Instruct*
11
model - AutoModelForCausalLH,fro=_pretrained(
12
model_name
13
torch_dtype=auto"
14
15
oane_=de"esrap
16
17
tokenizer
AutoTokenizer,fron
18
19
2.数照准备
20
21
fron datasets Inport load_dataset
22
data - load_dataset('gsm8k*)
23
24
##此处定义思考teaplate
25
SYSTEM_PROMPT -
26
Respond Iin the following format
27
28
<reasoningx
29
</reasoningx
38
TE
canswer>
32
EE
</answer>
34
35
XHL_COT_FORMAT -
36
<reasoning)
('role':*systen', *content*: SYSTER_pROHPT)
56
{[,uopasanb,]x ,auaquoo, ',Jasn, +,a[ou,}
57
58
59
([,Jansue,Jx)uansueqseupeqxa : , Jansue
J) # type: Ignore
60
61
return data # type: Ignore
62
这里处理的目的是把思考过程，答离分别结构化提取出来
63
dataset=get_gsmgk_questlons()
64
65
66
67
3.Reward量略定义
68
69
答室亮全正确得2分（是接期要求的x1格式，且是整数，且答室正确），晋则0分
70
def correctness_reward_func(prompts, completlons, answer, **kwargs) -> list[float]
71
responses - [completion[o][*content’] for conpletien In coepletions]
72
73
[auquoo,][t-][o]sadsoud - b
extracted_responses - [extract_xnl_ansmer(r) fer r In responses]
74
print('-**2o, f"Question:\n(q)*, f"\nAnsmer:An{answer[e]}”
75
f"\nResponse:\n{responses[o])*, f"VnExtracted:\n(extracted_responses[o]]")
return [2.o If r *- a else 0.o for r, a In zip(extracted_responses, answer)]
76
答室是整数（是<answer></answer>得xn1格式，且是整数）得o.5分，香则0分
77
def Int_reward_func(completions, **kuargs) -> 1ist[float]
78
responses - [conpletion[o][′content’] for conpletion In coepletions]
79
extracted_responses - [extract_xal_answer(r) fer r In responses]
80
return [0.s If r.isdigit() else o.o for r In extracted_responses]
81
答度严格符合<reasoning[reasoning]</reasoning><answer>[ansver]</answer>的格式 (终行也要正
82
确）得0.5分，晋则0分
def strict_format_reward_func(completlens, **kvargs) -> list[float]
83
84
-Reward function that checks If the coapletien has a specific format."*
pattern - r"*creasoning>\n,*7\n</reasening>\n<answer>\n,*?\n</answer>\ns"
85
responses - [conpletion[o]["content°] fer coepletion In coepletions]
86
matches - [re.match(pattern, r) for r In respenses]
87
suny"pemausunoo
train/rewards/strict_format_reward_func
train/rewards/sof_format_reward_func
0.006
8.004
train/newards/int_neward_func
3gowngsmw
return [2.e If r - a else 0.e for r, a In zlp(extracted_responses, ansn
答室是整数（是<answer></answer>得xml格式，且是整数）得o.5分，否则0分
def Int_reward_func(completlons, **kuargs) -> list[float]
78
responses - [completion[e][*content*] for conpletlon In coepletions]
79
extracted_responses - [extract_xml_ansmer(r) for r In responses]
$0
return [e.5 If r,lsdigit() else 0.o for r In extracted_responses]
81
答室严格符合<reasoning>(reasoning]</reascning><answer>[ansaer]</answer>的格式 （(终行也要正
82
确）得0.5分，否则0分
def strict_format_reward_func(completlons, **kvargs) -> list[float]
83
84
""-Reward function that checks If the conpletion has a specific format.""
pattern - r"<reasoning>\n,*?\n</reasoning>\n<answer>\n.*?\n</answer>\ns"
85
responses - [completlon[o]["content°] fer conpletion In coepletions]
86
87
matches - [re,match(pattern, r) for r In responses]
train/rewards/strict_format_reward_func
train/rewards/sof_format_reward_func
0.012
10T
1.5k
train/rewards/int_neward_func
train/rewards/correctness_reward_func
train/re
pps"pue
真诚点赞，手留余香
