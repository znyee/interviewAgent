# 【微调1】微调数据集模版

- Source Root: `note`
- Source Path: `2026-04-09 01_30_30-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 14

【微调1】微调数据集模版
aFactory数据集构造方式及官方文档中llar
本文讨论了Lam
a和qwen系列数据集的构适说明，关键要点包括：1.数据
一、llamafactory数据集构造
以下为对LlamaFactory中关于数据集构造方式的整理与说明。根据LlamaFactory的设计。其数据集的核心信息都
定义和管理在dataset_info.json中，使用时只需在该文件中进行配置井在主配置文件中指定所用的数据集名
称即可，LlamaFactory目前主要支持Alpaca格式与ShareGPT格式，并在它们的基础上扩展了对偏好数据集、
KTO数据集以及多模态数据集（图像。视频）等形式的支持。以下按不同格式、用途进行详细介绍
1.配置文件说明
在dataset_info.json中，可以为每个故据集进行如下配置（关键字段简介）
“数际集名称"：{
//选择从HuggingFace加载数集时使用
"hf_hub_url"
//选择从ModeLScope加载政集时使用
_Tun-qnys=
//选择使用本地数据加截牌本时使用
"script_url"
'uos-eep. +_aueu"eTT+
I/若未指定其它urL/script时，此项必填
//数酮集精式，可选aLpaca 威 sharegpt。默认alpoco
"formatting": "alpaca”
11是香为偏好数醒集。用于调练时的奖是模型/对比学习等
"ranking": false
"subset": null
//数据集子集名称
//使用的致解切分
"split": "train"
"folder": null
l/从Hugging Face 加载政前集时所在的文件夹各称
10
"num_samples": null
//指定该致旅集使用的样本数量
11
columns":{
12
//代表提示闻的表头名称
13
"pronpt": “instructior
"query": "input"
//代表用户输入的表头名称
14
//代表回答的表头名称
15
"response": "output"
//代表历史对话的表头名称
"history": null
16
代表系统提示的表头名称
"systen": null
17
//代表多轮对话消息列表的表头名称
18
"messages": null
//代表工具描述的表头名称
"tools": null
19
//代表图像输入的表头名称
"Images": null
20
"videos": null
//代表现须输入的表头名称
21
//代表更优回答的表头名称（用于偏好数照集）
"chosen": null
/代表更差回答的表头名称（用于偏好数显集）
23
"refected": null
//代表KTO标签的表头名称
"kto_tag": nul1
24
25
26
"tags": {
"role_tag": "fron"
l/在sharegpt 消息中表示发送者身份的健名
27
*anten, i_Sea"auoquoo.
//在sharegpt 消息中表示文本内睿的键名
28
//在sharegpt消息中表示用户角色的键名
num_sanples": null
11
12
"columns":{
"prompt"：“instructlon"，//f代c表提示词的表头名称
13
"query": "Input"
//代表用户输入的表头名称
14
"response": "output"
15
//代表国蓄的表头名称
"history": null
//代表历史对语的表头名称
16
"systen": null
//代表系统提示的表头名称
17
"messages": null
//代表多轮对证消息列表的表头名称
18
"tools": null
//代表工具械述的表头名称
19
"lmages": null
//代表图缘输入的表头名称
20
"videos": null
//代表视须输入的表头名称
21
"chosen": null
/代表更优国答的表头名称（用于偏好致照集）
22
//代表更差国蓄的表头名称（用于偏好数照集）
"refected": null
23
//代表KTO标签的表头名称
"kto_tag": null
24
25
"tags":{
26
l/在sharegpt 消息中表示发送者身份的健名
27
'wouy. +_Bea"atou
"content_tag": "value”
//在sharegpt 消息中表示文本内容的健各
28
//在sharegpt 消息中表示用户角色的键名
"user_tag": "human"
29
"assistant_tag": "gpt"
30
//在sharegpt消息中表示助手角色的健名
31
"-tte> uofasun,。 +_Sesa"uofasun
32
33
"system_tag": "systen"
34
35
·若指定了hf_hub_url或s_hub_url，则会优先从远端拉取数据：如未指定。使用script_url加载数
据脚本；若也来指定脚本，则最后使用本地的file_nae来加载数据。
·ranking指定是否是偏好数据集，即需要用到更优回答（chosen）与更差回答（rejected）。
columns用于指定各字段在故据集文件中的表头名（或者JSON的key）。
·若使用sharegpt格式，需要在tags中说明role与content等字段在源数据中的肤射关系。
2.Alpaca格式
Alpaca格式的数据集主要用于指令微调和预训练两种场景。并扩展到偏好数据集、KTO数据集及多模态等多种用
2.1指令监督微调数据集
数据示例
“Instruction"：“人英指令（必填）“
“Input"：“人英输入（选填）
"output”：“模型回答（必填）"
2.Alpaca格式
Alpaca格式的数据集主要用于指令微调和预训练两种场景，并扩展到偏好数据集、KTO数据集及多模态等多种用
途。
2.1指令监督微调数据集
数据示例
NOSC
"instruction"：“人奥情令（必填）“
“input"：“人曼输入(适填）“
“output"：“模型回答（必填）"。
"history”: [
“[.（始职）基回4一.。“（始到）期4一W]
[.（新职）最回4二W。‘-（站到）季期第二W_]
10
1.1
其中instruction会与input拼接后作为亮整的人类指令（如果input存在）。
output对应模型回答。
·若指定systen，则会披视为系统提示词。
·history若存在，则代表在局一次对话前的历史消息（指令+回答）。也会被纳入模型学习。
配置示例（在dataset_info.json中）
"dataset_name": [
uos[*enep. +oueu"elT+-
columns":{
"pronpt": "instruction"
"query": “Input"
"response": "output"
"systen": "systen"
"history": "history"
2.2预训练数据集
数据示例
{"text"
"docunent"}
{"text":“document"}
仅使用text列内容进行语言模型预训练。
配置示例
"dataset_name": (
"flle_name"
"data.js
"columns":(
"prompt":"text”
2.3偏好数据集（Alpaca格式）
用于奖励模型训练、DPO、ORPO或SimPO等对比学习场景，需要在JSON数据中提供更优的回答（chosen）和
更差的回答（rejected)。
数据示例
代码快
“instructlon"：“人美指令”
"Input"：“人婴输入”
"chosen"：“更优回答”
"rejected"：“更差回答”
配置示例
"dataset_name": {
uosf*erep. Iaueu'atT+
"ranking": true
“columns":{
“pronpt": “Instructlon"
"query": “Input"
"chosen": "chosen"
"refected": "rejected”
2.4KTO数据集
此类数据集需要额外提供kto_tag字段，表示人类对模型回答的反馈（通常为布尔值）。具体结构与sharegpt
中的对应方式类似，可参考后文介绍。
2.5多模态图像/视频数据集
与sharegpt中多模态数据类似，需要额外指定inages或videos字段，并在文本中使用<image>或
《video>标记，具体参见后文的sharegpt格式说明。
3.ShareGPT格式
ShareGPT格式的数据集采用一个conversations列（或messages列）来保存多轮对话，每个对话包含多条谓
息，每条消息带有发送者标识（human、gpt、observation，function_call等）。
3.1指令监督微调数据集
数据示例
代码快
"fron"
“value”：“人美令”
"function_cal1°
"fron"
"value”：“工具参数”
10
11
12
13
"observatlon"
"fron"
“value”：“工具活果”
14
15
16
17
"fron"
"gpt"
18
“value”：“模型回答”
19
20
"systen"：“系纳理示间（选辑）“。
21
“too1s"：“工具描述（选填）
22
23
24
此格式支持多种角色：human、gpt、observation、functlon_call等。
配置示例
JSON
}:_oweu1asesep_* T
"uosf-esep. :_meu"otT-
“formatting": "sharegpt"
"columns":{
"messages": "conversations
"systen": "system".
'tools": "tools"
3.2偏好数据集（ShareGPT格式）
数据示例
“fron": "huma
“value"：“人员令
"fron": “got"
"value"：“模型回答”
10
11
12
13
"fron": "human"
"value”：“人美令
14
15
16
"chosen":(
17
18
"fron": "gpt"
“value”：“优质回答”
19
20
21
"rejected":{
"fron": "gpt"
22
“value”：“努质国答”
23
24
25
26
配置示例
3.3KTO数据集
数据示例
JSON
"value"：“人员指令
"fron": "gpt"
10
value"：“模型回答”
11
12
13
kto_tag"
14
kto_tag表示人类反馈，是一个布尔值，True/False分别代表正反领或负反馈。
配置示例
"dataset_name": [
uos[-enep. ueu"T
"formatting": "sharegpt"
"columns": (
"messages": "corve
"kto_tag": "kto_tag"
3.4多模态图像数据集
数据示例
"conversations": [
"fron": "human"
"value”：“<image>人员指令”
"fron": “gpt”
18
"value”：“模型回答”
3.4多模态图像数据集
数据示例
JSON
] ±I
“fron": “hus
"value":“clmage>人类指令
"fron"
"gpt"
"value"
“模型回答”
10
11
12
"Images": [
13
“图像路径1"
14
“图像路径2
15
16
17
文本中的<inage>标记须与inages数量—对应。
配置示例
代码快
"dataset_name"
"f1le_name": "data.json”
"formatting": "sharegpt"
"columns": (
"con
"messages"
3.5多模态视频数据集
数据示例
“fron": “hur
3.5多模态视频数据集
数据示例
JSON
ersatlons
"fron": "human"
"value"：“<video>人类指令
"fron": “gpt"
"value"：“模型回答”
10
11
12
vldeos": [
13
视紧路量1"
14
15
“视续路径2”
16
17
同理《video>标记与videos数量对应。
配置示例
"dataset_name": [
"formatting": "sharegpt"
columns":{
"messages": "conversations
"videos": "videos"
3.60penAI格式
可以视为 sharegpt 的简化形式，messages 中可能包含 system、user、asslstant三种角色，例如
"role": "systen"
"content”：“票炫提示词”
“columns”:{
"videos": "videos"
3.60penAI格式
可以视为 sharegpt 的简化形式，messages 中可能包含 system、user、asstant三种角色。例如
JSON
] ±I
"role": "systen"
“content”：“系统提示同”
"role"
10
"content"：“人美指令
11
12
13
"role": "assistant"
“content"：“模型回答”
14
15
16
CT
18
配置信息中需要把role和content的名称相应地缺射到sharegpt所需字段
代码快
"dataset_name":(
"flle_name": "data. Json"
"formatting"
"sharegot"
"columns":(
"messages"
"tags":（
"role_tag": "role"
"content_tag":"content"
"user_tag": "user"
"assistant_tag": "assilsta
11
"system_tag":"system”
12
14
4.其他要点
·自定义数据集：如果想使用本地或第三方数据集，需要在dataset_info.json中新增相应的配置条目，并设
置“dataset：你的数据集名称”来指向它。
·history的用途：当进行指令微调（IFT）时，如果故据中包含历史消息，会将其拼接到上下文中，这些回答也
会被横型学习到。
·多模态：若使用图像或视频等多惯态，需要在J5ON中插入《image>/《video>标记，并确保与inages
/videos数组中的文件路径匹配。
·ranking：对比学习或奖励建模等场景（DPO、ORPO、RLHF等）需要一个带有更优（chosen）与更差
（rejected）回答的偏好故据集，如果ranking设为true，即表示此故据集包含偏好信息。
、按照官方文档构造数据集
在官方仓库中会详细说明数据集的构造方式，这里以llama和qwen系列为例，其他模型均能在官方repo中找到微
调数据格式
1.Qwen系列
README Apache-2.0 icense
adoocanow
Finetuning
Usage
Now we provide the official raining script, finetune.py , for users to finetune the pretraned moel for
downstream apliations in a simle fashon Additionall, we prvide shellscripts to laun inetuning with no
worres. This script supports the training with Deeppeed and SDP. The shelscripts that we provide use
auns aoeu esn pjnous nof pue guepfd po uosuan sele ag ajm sojuo aney Aeu ssu aqon) paedsdaeg
pydant ic<2.e ) and Peft. You can install them by
pip install “peft<0.8.0" deepspeed
To prepare your training dta youneed to pt althe samles intoalist nd saveit to ajsonfleEa sleis a
dictionary consisting of an id and alist for conversation, Below is a simple examplelist with 1 sample
"id": “identity_o”
"cenversations*: [
"fron"; “user"
"vatue”:“存好”
"from”: "assistant"
“value”：“我是一个适言模型，我叫通义千间。“
dictionary consisting of an id and alist for conversation,Below is a simple examplelist with 1 sample
"id*: *identity_"
nversations": [
"fros": “user"
"value”:“你好”
"from": “assistant"
“value”：“我是一个适言模型，我纠通义千间。“
2.llama系列
README Code of conduct
License
Instruction-tuned Models
The fine-tuned models were trained for dialogue applications, To get the expected features and performance fo
them, specificformating defined in ChatFormat needs to be followed: The prompt begins with a
<begin_of_text |> special token, after which one or more messages follow. Each message starts with the
>eo s lo e <>
double newline \n\n, the message's contents follow. The end of each message is marked by the <Jeot_1d|>
token.
Youcanalsdelyadditional lasifiestofitout inuts and otuts that areeme safeethellm
po aoupu no po sndno pue sndua o pap aes eppe omo jo auex ue o odauxooy
Examples usingllama-3-8b-chat
torchrun -nproc_er_node 1 exanple_chat_cosplet:ion.py \
-ckpt_dir Meta-LLana3-88Instruct/ \
tokenizer_path Meta-LLana38BInstruct/tokenizer,sodel
-max_seq_len 512 --max_batch_size 6
Llama 3 is a new technology that carries potential rsks with use. Testing conducted to date has not and could
not cover allscenarios. To help developers address these risks, we have created the Responsible Use Guie.
Issues
class ChatFormat
def _Init_(self, tokenizer: Tokenizer)
self.tokenizer - tokenizer
def encode_header(self, message: Message) -> List[Int]
tokens - []
tokens.append(self.tokenizer,special_tokens[*<|start_header_Id|>*])
os=False))
nd(self.tokenizer
1.bos=False
not cverall scenrios.Tohelp devlpers adresstheserisks, wehave created the Responsible Use Gui.
Issues
Python
1 class ChatFormat
def _init_(self, tokenizer: Tokenlzer)
self,tokenizer - tokenizer
def encode_header(self, message: Message) -> List[Int]
tokens - []
tokens,extend(self,tokenlzer,encode(message["role"], bos=False, eos=False)
tokens,append(self,tokenizer-speclal_tokens[<|end_header_Id|>"])
tokens,extend(self,tokenizer,encode("In\n", bos=False, eos=False)
10
11
return tokens
12
def encode_message(self, message: Message) -> List[Int]
13
tokens - self.encode_header(message)
14
15
tokens,extend(
self,tokenizer,encode(message["content"]-strip(), bos=False, eos=False)
16
17
18
tokens,append(self,tokenizer-special_tokens["<|eot_Id|>])
return tokens
19
20
21
code_dialog_pro=pt(self, dlalog: Dlaleg) -> List[Int]
def et
tokens - []
22
([<|axaafoujfaq]>_]suaxoa (efoads*ezguaxo1*tes)puadde suaxo
23
24
Botesp ut alesse Jof
tokens,extend(self,.encode_message(message))
25
an assistant messoge for the model to conplete
26
# Add the start of c
(([- +aueuo>, *-aueasjsse, a[o-])apeay aposua*,tes)puaxe suaxo1
27
28
return tokens
假设你使用的specal tokens是
《|start_header_id|>：[头部开始标记]
[/]:<|pfepeeypue|>
·《eot_id>：表示当前对话轮次结束。
JSON格式的的文本长这样
messages": [
{"role"：“systen”，“content”：“你是一个A工助手，善于国答技术阿题。“}。
Jojsuen5gaseur88nH2mmtl. 4,4uaqus, *,aueasTsse, 1atou_)
messages": [
{"role"：“system”，“content”：“你是一个AI助手，善于回答技术间题，“}。
“1。qna0)
监使用
满足官方文档的长这样
<|start_header_id|>system<|end_header_Id|>
你是一个AI助手，善于回答技术问题。<eot_id|>
<|start_header_id|>user<|end_header_Id]>
怎么微间1lama模型?<|eot_id|>
<|start_header_id|>assistant<|end_header_id]>
存可以使用HuggingFace的PEFT库或者直接用transfor
<|start_header_id|>user<|end_header_id]>
11
能理供个代码示例码?<|eot_id|>
12
<|start_header_id >assistant<|end_header_Id]>
标签部分长这样
<|start_header_id|>assistant<|end_header_Id]>
（期望模型从这里开始生成回复文本）<|eot_id|>
真诚点赞，手留余香
