# 【Agent实战-7】Function Call微调指南

- Source Root: `note`
- Source Path: `2026-04-09 01_28_57-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 8

【Agent实战-7】FunctionCall微调指南
本文讨论了基于最新模型在tunctionCall问题中始出的整容微调解决方置，包括分析模型在函数调用中出现的问题及原因.
以下内容是基于最新的model在functioncall问题中，给出相应的整套微调解决方案
1.什么情况下你提示词写到极致了tool调用还是出错？
2.应该怎么定位问题，基于问题构造数据？
3.如何搭建整套的数据评估和送代pipeline？
1.为什么需要微调FunctionCall能力
大型语言模型即使能力很强（如Qwen/Gemini/GPT等）。在工具函数调用上仍可能出现错误（即使最好的
model，在BFCL测试集中，多轮对话中工具调用准确率不足50%），因此有必要专门微调以提升函数调用的准确
Mutilus
Single Tum
Hler(A5T)
Uve (R5T) #
Muis sem #
Cot
Dval c
OenllAc
Oagl Ac
OveslL.Aec
Model
Mean
12.04
M4
66.5
45.12
71.78
6A.34
TL.71
TLB
80.3
1.3
11-20
7,.2
85.36
30.42
34.04
1-20户
PTH5
MM
0.32
JIP
长.12
%H
66T
45.38
75.79
69.25
72.22
1.8
112
SPT4.1:2028
85.35
68.83
71.78
68.73
90.11
接下来针对FunctlonCallng的问题，分别举例（场景+问题分析）说明，特别是那种"即使写好了提示
词（提供了清断的函数定义），模型依然可能出错”的情况。
假设我们正在构建一个智能助手，它需要调用不同的API来完成任务。
通用系统提示词（SystemPrompt）框架
为了让例子更清晰，我们假设每次交互前，模型都会收到类似这样的系统提示
Ue(AST)
OvesllLAtt
Mede
OueallAo
OwenllAot
OvegllAox
6.4
H4
7.79
32.04
45.12
ILII
11-20P0
72.22
85.36
29
83.4
30.32
666T
T2.22
15.79
68.25
T41-S
接下来针对FunctionCalling的问题，分别举例（场景+问题分析）说明，特别是那种"即使写好了提示
词（提供了清断的函数定义），模型依然可能出错”的情况。
假设我们正在构建一个智能助手，它需要调用不同的API来完成任务
通用系统提示词（SystemPrompt）框架
为了让例子更清晰，我们假设每次交互前，模里都会收到类似这样的系统提示
代码快
你是一个AI助手。你可以使用以下工具（盈政）来帮助用户，请仔细阅读盈政描述和参数说明，当停认为需要调用基个盈
可用工具列表
//这里会列出具体场景下的函政定义
1.1模型存在函数调用偏差：挑错函数、重复调用同一函数
·场景：用户规查询天气，然后又问了关于日历的问题。
•可用工目(Functions Provided in Prompt)
*a44ean'*a3, 1,ooru
parameters”:{
"type": "object"
"propertles": {
"date”: ("type": "string”.
10
“requdred”: ["city", “date"]
11
12
个AI助手，你可以使用以下工具（鱼数）来帮助用户，请仔细阅读通数描述和参数说明，当你认为需要得用基个通
可用工具列表
//这里会列出具体场最下的尚数定文
1.1模型存在函数调用偏差：挑错函数、重复调用同一函数
·场景：用户想查询天气，然后又问了关于日历的问题。
·可用I具(Functions Provided in Prompt)
parameters”:{
"type": "object"
"propertfes": {
“城市省称，例如：北京”）。
"string"。 "description"
"city":("type"
"date”：("type”：“string"。“description"：“日期， 格式 mmY-H-DD. 可以是“today”。
10
11
12
13
14
15
": “check_ calendar_availability"
16
17
parameters”:(
"type": "obyect"
18
“propertles”:(
19
"date”: ("type": "string", "descriptlon": “查调的日期. 格式 YY-mH-DD. ")
20
"start_time”: ("type":“string", "descriptlon":“开始时间, 格式 HH:mH. “)
21
“end_time”：("type：“string”, “descrlptlon°:“括束时间， 格式 HH:M,“}
22
23
24
25
27
·用户对话
a.User：“明天北京天气尔么样？”
8aeu)(papdx) 1y “q
\"tomorrow\")")
c。（假设API返回结果后，AI正常回复了天气）
d.User：“那我明天下午2点到4点有空吗？
·AI (Erroneous): (“name”:“get_weather", “arguments":“{\"city\":\"t京\"
"date\"：\"tomorrow\")"）（错误地重复调用，或者理解为再次询问天气细节）
重复调用（即使上一个函数与当前童图无关）：如果模型有一种“粘性”，倾向于重复使用最近讨论过的实体
相关的函故，即使意图已改变。
·原因分析：即使函数定义清晰。模型可能因为”天气“这个主题在对话中更突出，或者对”明天“这个时间词的上
下文关联产生了偏差，未能准确切换到check_calendar_availability。或者，横型对”有空吗“的理解不
够精确，没有将其强关联到日历功能。
1.2.复杂场景下出错：过度依赖函数名称字面意思，忽略描述细节，函数用途相似时
混淆
·场景：用户想了解某款产品的”用户评价”，但系统有两个与产品信息相关的函数。
▪可用I具 (Functions Provided in Prompt)
代码快
*_stre1op1onpoud 1a8, :,aoru
“description”：“获取产品的详细信息，包括规格、主要功载。价格。盲方描述等。“
parameters":(
"type":"object"
“properties":{
"product_name”：("type"："string”。“description":“产品名称或ID")
10
requfred°:["prc
11
12
13
14
15
"description”：“联取指定产品的用户评价和评分。“
16
parameters”: (
"type”: "object"
17
“properties":(
18
“(a. +uoaduosap. *uns, 1,ads_) i_oeu1onpoud
19
“min_rating": ("type": “Integer", "descriptlon": “可选。 最低评分情选 (1=5)”, "mininun
20
21
22
23
24
25
·用户对话
User：我坦看看智能音箱X1这款产品怎么样，大家都怎么说？
可能出现的错误（误选函数)
模型可能因为”产品怎么样“和get_produ
Huct_details函故名中的detalls都与了解产品相关，而忽略了
·原因分析
函数用途相似：两个函故都用于获取产品信息，只是侧重点不同。
过度依转名称/高频词：“product”和“怎么样”（howlsIt）可能让模型倾向于选择更通用的
get_product_details。
键。但惯型可能没有给予足够的权重，或者在处理较长问句时丢失了后半部分的核心意图。
。偏见：如果在i训l练数据中，get_product_details被调用的频率远高于get_product_reviews，模
型可能形成一种优先选择前者的信见。
1.3.参数使用错误：漏填必要参数、参数格式不符、凭空猜测参数
·场景：用户根预订会议室，但没有提供完整信息
·可用工具(Functions Provided in Prompt)
代码快
"description"：“预订一个会议室。
parameters": (
"type": "object"
"properties": (
"start_time”: ("type":"string"。 "description": “开始时间, 24小时制。 格式 H:MH")
10
"duration_mdnutes”：(“type”：“integer”，“descriptlon”：“会议时长，单位分钟")
11
12
13
required*: ["room_id"
14
15
16
·用户对话
User：“帮我订一下101会议室，明天下午用。“
·可能出现的错误（参数错误）
。漏填必要参数（duration_minutes）：用户没有说会议要开多久
{\"roon_id\"：\"Room-101\",\"date\"：\"[明天的日期]\",\”start_tine\"
\“14:eo\*)*) (少 duration_minutes)
·理想行为：AI应该追问：“好的，请问会议室101明天下午2点开始，您需要预订多长时间呢？“
凭空精测参数：横型可能会自己猜测一个时长，比如默认1小时。
用户网话
User：“我下周去抗州，想找找西湖区有没有适合雨天逛的室内集市或者手工艺品市场？最好是那种当地人
会去的。“
·可能出现的错误（因缺乏领域经验）
。无法准确映射到**poi_type**：**“室内集市”、“手工艺品市场”可能不是模型在其通用训练数据中常
见的poi_type。即使find_points_of_interest的描述提到了类型筛选，横型也可能不知道如何将用
户的描述映射到已知的或者可接受的poi_type枚举值（如果API后端有固定牧举的话）。它可能会
{\"city\"：\"杭州\"，\"district\"：\“西湖区\"}"}（忽略了类型筛选，因为无法处理）
· AI (Erroneous - guessing type): ["name”: *find_points_of_interest", “arguments*: "
{\"city\"：\"抗州\",\"district\"：\"西湖区\",\"poi_type\”：\"market\"}"}（可能猫了
无法处理组合意图和隐含条件：“适合雨天逛的”隐含了需要查询天气，然后根据天气情况推荐室内场所。
模型可能不会主动想到先调用get_weather_forecast_for_travel，或者不知道如何结合两个API的结
果。“当地人会去的”这种主观性强的筛选条件，通用模型基本无法直接通过参数实现，除非API本身支持这
种标签。
AI（Erroneous-只执行部分）：可能只调用find_points_of_interest，完金忽略天气和”当地人的偏
好。
原因分析
。通用模里（如Qwen基础版）的训练数据主要集中在常见任务和通用知识上，对于特定垂直领域（如深度旅
行规划、专业医疗咨询等）的函数和用户意图，它没有足够的经验”。
即使函数定义在提示词中给出，模型也只是“看到”了定义，但缺乏通过大量相似场景的训练来”学会“如何灵
活、准确地使用这些特定领域的工具，尤其是当涉及到多工具协作或理解领域内隐酶表达时。
2.如何进行FunctionCall微调
核心理念：通过高质量，有针对性的数据，“教会”模型在特定场景下如何正确，可靠地进行Functlon
Calling.
2.1针对性数据集构造策略
比如针对上文列出的四个主要问题来构造数据
A.针对”函数调用偏差（挑错函数。重复调用）“的数据集
·目标：帮助模型区分意图相似但应调用不同函数的情况：道免在对话上下文中不必要地重复调用同一函数。
·数据构造方法
歧义消除样本
·用户输入（User)）：我想知道明天上海的天气，然后帮我看看我日程上有没有空。“
·预期助手行为（Assistant)
参数格式化样本
DDTHH:MM:SS°)
·User：“帮我安排一个会议，主题是周会，时间是下周三下午3点。”
·Assistant:(“nane”:“schedule_neeting",“argunents":“(\"title\”:\"周会\”
"date_tine\”：\“[计算出的下周三下午3点的Iso格式日期时间]\"}"}
可选参故处理样本
·函数: search_products(keyword: str, category: Optional[str] = None, min_price
Optional[int] = None)
User：“搜一下蓝牙耳机”
·Assistant: [“name”: “search_products”, “arguments": “(\"keyword\”: \“蓝牙耳机\")")
（只提供必要参数）
·User：“在”数码“分类下搜”蓝牙耳机”，价格至少100块”
·Assistant: {“nane”:“search_products”, “arguments”:“{\“keyword\:\“蓝牙耳机\"
\"category\"：\"数码\"，\"min_price\"：100）"）（提供了可选参数）
避免凭空猜测参数
User：“帮我查直订单，“（没有订单号）
·Assistant（正确行为-追问）：“您好，请提供一下订单号，我为您查询。“
·对应的训练样本
代码快
]:,salessou
(”"role”：“systen”，“content”：“[包含query_order图政定义，需要order_id]”]
(“”role”：“assistant”，“content”：“您好，请提供下订单号，我为您查端。“)
D.针对“现有数据不足（特定领域函数调用经验缺乏）“的数据集
·目标：弥补模型在特定领域（如旅行、电商、医疗等）的FunctionCalling经验。
·数据构造方法
领域术语映射
领域：旅行-机票预订
·函数： find_flights(departure_city: str, arrival_city: str, departure_date: str
cabin_class: Optional[str] = 'econony*)
下个月10号
品北京飞绍务
口语化
识别模式：哪些类型的函数调用更容易出错？用户用什么样的表达方式时模型更容易混清？
3.3数据增强与迭代（DataAugmentation&Iteration）
基于错误分析的结果，进行针对性的数据增强
1，补充缺失场景：如果发现模型在某一类函敌调用或某一类用户装达上表现不佳，就专门构造或收集更多这类样
本，例如，如果横型老是漏掉duration_ninutes参数，就增加更多需要追问或明确提取该参故的样本。
2.增加多样性
同义词替换：对用户输入中的关键词进行同义词替换（查订单”>“订单状态”、“我的订单呢”）。
。句式变换：将陈述句改疑问句，主动改被动等。
。引入噪声（少量）：适度引入错别字、口语化表达、不完整句子，提高模型鲁棒性。
。参数值泛化：替换地名、人名、日期、产晶名等，使其不局限于训练数据中的特定值。
3.田雄负样本挖程（HardNegative Mining）
找到那些模型很容易错误调用盈数的”诱导性”用户输入（但实际上不应该调用），并将其作为负样本（即
assistant的回复是文本而不是function_call）加入训练集。
例如，用户说：“你知道怎么订机票吗？“模里可能错误地想调用book_flight，但正确的回答应该是“是
的，我可以帮您预订机票。请告诉我您的出发地、■的地和目期。“
4.利用模型自身
对于模型出错的ca5e，人工修正其输出，形成新的正确样本加入训练集。
。有时可以让模型对一个正确的FunctlonCal生成多个不同的用户提间方式（需要人工审核）。
5.重新训练与评估：用增强后的数据集重新微调模型，并再次进行评估，观察各项指标是否有提升，特别是之前
出错较多的地方。
循环：这个“评估->错误分析->数据增强->重新训练"的过程是一个持续的循环。直到模型在目标场
景下的FunctionCalling能力达到满意水平。
真诚点赞，手留余香
