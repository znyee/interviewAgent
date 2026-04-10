# 【微调13】Function Calling 如何微调

- Source Root: `note`
- Source Path: `2026-04-09 01_32_42-Greenshot.png`
- Source Kind: `ocr-image-group`
- KB Type: `interview-topic`
- Page Count: 11

【微调13】Functioncalling如何微调
张飞W
本文讨论了在FunctionCal问题中，大型语言模重在工具函数调用上可脱出现的描误，以及针对这些问题进行微属的解决
以下内容是基于最新的model在functioncall问题中，给出相应的整套微调解决方案
1.什么情况下你提示词写到极致了tool调用还是出错？
2.应该怎么定位问题，基于问题构造数据？
3.如何搭建整套的数据评估和送代pipeline？
1.为什么需要微调FunctionCall能力
大型语言模型即使能力很强（如Qwen/Gemini/GPT等）。在工具函数调用上仍可能出现错误（即使最好的
model，在BFCL测试集中，多轮对话中工具调用准确率不足50%），因此有必要专门微调以提升函数调用的准确
Mutilus
SingleTum
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
7.78
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
MM
0.32
JIP
长.12
%H
66T
243.14
45.38
75.79
69.25
72.22
1.8
L.12
SPT4.1:2028
85.35
68.83
71.78
68.73
90.11
接下来针对FunctlonCallng的问题，分别举例（场景+问题分析）说明，特别是那种"即使写好了提示
词（提供了清断的函数定义），模型依然可能出错”的情况。
假设我们正在构建一个智能助手，它需要调用不同的API来完成任务。
通用系统提示词（SystemPrompt）柜架
为了让例子更清晰，我们假设每次交互前，模型都会收到类似这样的系统提示
72.22
8.TT
搜下来针对Function Calling的问题，分别举例（场景+问题分析）说明，特别是那种“即使写好了提示
词（提供了清断的函数定义），模型依然可能出错”的情况。
假设我们正在构建一个智能助手，它需要调用不同的API来完成任务。
通用系统提示词（SystemPrompt）框架
为了让例子更清晰，我们假设每次交互前，模型部会收到类似这样的系统提示
代码快
你是一个AI助手。你可以使用以下工具（鱼数）来帮助用户，请仔组阅读盈数描述和参数说明，当停认为需要调用基个盈
可用工具列表
//这里会列出具体场景下的盈政定义
1.1模型存在函数调用偏差：挑错函数、重复调用同一函数
场景：用户根查询天气，然后又问了关于日历的问题。
可用工具 (Functions Provided in Prompt)
代码快
parameters": (
"type”: "object"
"properties": (
"city"：("type”："string”，“descriptlon"：“城市名称，例： 北京”)
“date”：{"type”：“string”，“descriptlon：“日期，格式 WmY-mH-DD. 可以是‘today”，“tom
10
required”: ["city", “date"]
11
12
13
14
"name": “check_calendar_avallability”
15
"descrlption”：“查询指定日期和时间股日历是否有空用。“
16
17
parameters":{
"type”: “object"
18
19
"properties":(
"date”：{"type”：“string”， “descriptlon：“查调的日期，格式 vVY-H-DD.“}
20
"start_time”: {"type": “string”, “descriptlon": “开始时间， 格式 H:m.。 “)
21
22
“end_time”：{"type”：“string”，“descriptlon"：“括束时间， 格式 H：mH.“}
23
24
start_tine
25
17
parameters":{
18
"type":"object"
"properties": (
19
"date”：{"type"："string”，"description":“查词的日期，格式 YYY-mH-DD."}.
20
"start_time”: ("type": "string”。 "description": “开始时间, 格式 HH:mH, “}。
21
"end_time”: {"type”: “string”, “description": “结束时间, 格式 HH:m, “)
22
23
24
"end_time"]
"start_time"
25
26
27
·用户对话
a.User：“明天北京天气怎么样？”
e)(px) q
\"tonorrow\")")
c.（假设API返回结果后，AI正常回复了天气）
d.User：“那我期天下午2点到4点有空吗？“
·可能出现的错误（偏差-挑错函数或重复调用）
·挑错函数：尽管用户期确问”有空吗？”（指向日历），模型可能因为上下文的”明天“和之前的天气查询。*
错误地再次调川**get_weather，或者尝试从天气信息中推断是否有空（这是不可能的）。
"date\"：\"tomorrow\"}"}（错误地重复调用，或者理解为再次询问天气细节）
重复调用（即使上一个函数与当前意图无关）：如果模型有一种“粘性”，倾向于重复使用最近讨论过的实体
相关的函数，即使意图已改变
·原因分析：即使函数定义清晰，模型可能因为”天气“这个主题在对话中更突出，或者对”明天“这个时间词的上
下文关联产生了偏差，未能准确切换到check_calendar_availability，或者，损型对”有空吗“的理解不
够精确，没有将其强关联到日历功能。
1.2.复杂场景下出错：过度依赖函数名称字面意思，忽略描述细节，函数用途相似时
混淆
·场景：用户规了解某款产品的“用户评价”，但系统有两个与产品信息相关的函数。
可用工目(Functions Provided in Prompt)
"descrlptlon”：“获取产品的详细信息，包括规格、主要功能、价格，官方描述等。“
"parameters": (
"type": “object"
1.2.复杂场景下出错：过度依赖函数名称字面意思，忽略描述细节，函数用途相似时
混淆
·场景：用户想了解某款产品的“用户评价”，但系统有两个与产品信息相关的函数。
·可用工具(Functions Provided in Prompt)
“seop1npud1a3, :]
"descrlptilon”：“获取产品的详细信息，包括规格。主要功能、价格、盲方描述等。“
parameters": (
'12[qo, 1,adk.
"properties: (
1_odk_) 1_aeu"1onpoud
1θ
11
12
13
*safaau ponpod 1al. 1,aoru
14
15
16
parameters”: (
17
"type":"object"
"properties": (
18
"product_name": ("type": "string", "description": “产品名称aRID")
19
"min_rating": ("type": “integer", "description": “可选, 最低评分情选 (1-5)”, "minimu”
20
21
22
23
24
25
·用户对话
User：“我坦看看智能音箱X1这款产品怎么样，大家都怎么说？
可能出现的错误（误选函数）
。模型可能因为”产品怎么样和get_product_details通数名中的”detalls都与了解产品相关，而忽略了
sangue,stre4opnpoudo8:oueu} (snouou) Iv
能音箱x1\"}"}
·原因分析
函数用途相似：两个函数都用于获取产品信息，只是侧重点不同。
。过度依赖名称/高频词：“product”和“怎么样"（howisit）可能让模型倾向于选择更通用的
"start_tiEe”: ("type”: "string”， “description°;"H, 24小时制， m式 HH:H)
10
“duration_minutes"：{"type”：“Integer"，“description”：“会议时长，单位分钟"}
11
12
"required*: ["room_id", "date", “start_time", “duration_minutes"]
13
14
15
16
用户对话
User：“帮我订一下101会议室，明天下午用。“
·可能出现的错误（参数错误）
。漏填必要参数（duration_minutes）：用户没有说会议要开多久。
{\"roon_id\"：\"Room-101\",\"date\"：\"[明天的日期]\",\"start_tine\"
(snuuoeunp)0
·理组行为：AI应该追问：“好的，请问会议室101明天下午2点开始，您需要预订多长时间呢？“
凭空精测参数：模型可能会自己猜测一个时长，比如默认1小时。
· AI (Erroneous - guessing): (*nane*: *book_neeting_roon", “arguments*
{\"room_id\":\"Roon-101\", \"date\":\"[明天的日期]\", \"start_tine\":\"14:00\"
\"duration_minutes\°: 60)"}
。参数格式不符（如果用户说法更随意）
·User：“帮我订101会议室，明天下午两点到三点，“
·AI（Erroneous-wrong format for duration）：可能错误地将“三点”理解为end_tine而不是计
算出duration_minutes，或者错误地特两点”传入start_tine但格式不是H:（例如传入
“两点”而不是“14:00°）。
101\，1"date\”：\"[明天的日期]\"，\"start_time\”：\"下午两点\”
duration_minutes\”：\*一小时\）"）（参数值格式和类型错误）
原因分析
模型在信息不全时，没有被很好地训练去主动澄清或询问，而是倾向于”尽力而为”地尝试调用。
对于时间、日期等结构化数据的自然语言理解和转换能力不足，即使函数定义了格式，模型也可能无法将口
语化的表达准确转换为所需的格式。
1.4.现有数据不足：特定领域函数调用经验缺乏
·场景：在一个定制的旅行规划应用中，用户想查询特定类型的冷门景点，并结合天气API.
·可用工具(Functions Provided in Prompt)
fnltnf Ev
语化的表达准确转换为所需的格式。
1.4.现有数据不足：特定领域函数调用经验缺乏
·场景：在一个定制的旅行规划应用中，用户想查询特定类型的冷门景点，并结合天气API
▪可用工具(Functions Provided in Prompt)
"name*: “find_points_of_interest"
“description”：“查找腊定城市的兴理点，可以按类量神选，创如：“museum'，‘park'，‘historic_site
parameters°: {
"type":"object"
"properties": {
“（） uadp*Busad) adod
“district”：{"type”：“string”，“description”：“区域或行政区（可选。用于更精确查战）”}
10
11
12
"required”: ["city"]
13
14
15
name": "get_weather_forecast_for_travel"
16
“description”：“获取旅行目的地的末来几天天气预报，以辅助规划户外活动。“
17
"parameters*: (
18
19
"type”:"object"
20
“properties":(
21
"start_date”: ("type”: "string", “description": “开始日期 wY-m-Do°)
22
“days”：{"type”：“integer"，“description”：“查闻末来几天，默认3天”）
23
24
“required°: ["location", “start_date"]
25
26
27
·用户对话
User：我下周去杭州，想找找西湖区有没有适合雨天延的室内集市或者手工艺品市场？最好是那种当地人
会去的。
·可能出现的错误（因缺乏领域经验）
无法准确映射到*poi_type：“室内集市”、“手工艺品市场”可能不是横型在其通用训练数据中常
见的poi_type。即使find _points_of_interest的描述提到了类型筛选，横型也可能不知道如何将用
户的描述映射到已知的或者可接受的poi_type枚举值（如果API后端有固定枚举的话）。它可能会
·用户对话
。User:“我下周去抗州，想找找西湖区有没有适合雨天延的室内集市或者手工艺品市场？最好是那种当地人
会去的
·可能出现的错误（因缺乏领域经验）
。无法准确映射到**poi_type**：*“室内集市”、“手工艺品市场”可能不是模型在其通用训练数据中常
见的poi_type。即使find_points_of_interest 的描述提到了类型筛选，横型也可能不知道如何将用
户的描述映射到已知的或者可接受的poi_type枚举值（如果API后端有固定枚举的话）。它可能会
squnuesauaquygosugodpus。 auu) :(adAy Guuo - snoouou) Iy
{\"city\"：\“杭州\"，\"district\"：\"西湖区\")"）（忽略了类型筛选，因为无法处理）
squaanaue。*sauequygosugodpur.oueu,) (odAy bussno - snouou) Iv *
{\"city\":\“抗州\",\district\:\"西湖区\",\"poi_type\:\"market\"}")（可能精了
一个泛化的“market"，但不满足”室内”、“手工艺品"的特质）
无法处理细合意图和隐含条件：“适合雨天逛的”隐含了需要查询天气，然后根据天气情况推荐室内场所。
横型可能不会主动想到先调用get_weather_forecast_for_travel。或者不知道如何结合两个API的结
果。“当地人会去的”这种主观性强的筛选条件，通用模型基本无法直接通过参数实现，除非API本身支持这
种标签。
AI（Erroneous-只执行部分）：可能只调用find_points_of_interest，完全忽略天气和”当地人的偏
好。
原因分析
。通用模型（如Qwen基础版）的训练数据主要集中在常见任务和通用知识上，对于特定垂直领域（如深度旅
行规划、专业医疗咨询等）的函数和用户意图，它没有足够的经验”。
即使函数定义在提示词中给出，模型也只是“看到”了定义，但缺乏通过大量相似场景的训练来”学会“如何灵
活、准确地使用这些特定领域的工具。尤其是当涉及到多工具协作或理解领域内隐嗨表达时。
2.如何进行FunctionCall微调
核心理念：通过高质量，有针对性的数据，“教会“模型在特定场景下如何正确，可靠地进行Functlon
Calling.
2.1针对性数据集构造策略
比如针对上文列出的四个主要问题来构造数据
A.针对”函数调用偏差（挑错函数。重复调用）“的数据集
·目标：帮助模型区分意属相似但应调用不同函数的情况：道免在对话上下文中不必要地重复调用同一函数。
·数据构造方法
核心理念：通过高质量、有针对性的数据，“教会“模型在特定场景下如何正确、可靠地进行Function
Calling.
2.1针对性数据集构造策略
比如针对上文列出的四个主要问题来构造数据
A.针对”函数调用偏差（挑错函数、重复调用）“的数据集
·且标：帮助模型区分意图相似但应调用不同函教的情况：道免在对话上下文中不必要地重复调用同一函数。
·数据构造方法
歧义消除样本
·用户输入（User)：我想知道明天上海的天气，然后帮我看看我日程上有没有空。“
·预期助手行为（Assistant)
1. {"nane": “get_weather", “arguments": “(\"city\": \"上海\", \"date\*
tonorrow\)"）（第一次调用）
2.（假设天气API返回后）
3.{"name”: “check_calendar_availability", “arguments": "{\"date\"
"tomorrow\"）"）（第二次调用，注意函数已切换）
上下文敏感样本（避免重复）
·User（上一轮）：“天北京天气如何？“
·Assistant（上一轮）：（调用get_weather 并返回结果）“即天北京靖朗，气温15-25度。
·User（本轮）：“邮后天呢？“
r\）。squue
User（本轮-测试重复调用场景）：“好的知道了，你叫什么名字？“
·Assistant（本轮-正确，不应调用天气）：“我是一个AI助手，“（而不是再次调用get_weather）
相似触发词，不同函数
·函故A：search_knowledge_base（query：str）（描述：搜素内部知识库文章）
函数B：search_web（query：str）（描述：在互联网上搜索信息）
·User：“帮我查一下大语言模型微调方法”。“（假设这个信息在知识库里有权或文档）
·Assistant: [name”:“search_knowledge_base”, “arguments”:“{\"query\”:\*大语言模型
微调方法\"Y"）
·User：“帮我查一下今天最新的科技新闻”。
·Assistant：（“nane”：“search_web”，“arguments"：“{\”query\”：\"今天最新的科技新闻
1")")
B.针对“复杂场景下出错（误解函数描述，名称偏见。相似函数混淆）“的数据集
目标
强制模型更仔细
而不是仅凭名称或部分关键词做判断
·函数B: change_user_shipping_address(user_id: str, address_id: str
neu_address_details：object）（描述：修改用户的**收货地址**.）
· Assistant: ("nare*: "change_user_shipping_address*, "arguments*: “(\"user_id\′: \
[current_user_id]\"，...)}"}（即使update_user_profile名称更泛化，但描述区分了用途）
C.针对”参数使用错误（漏填、格式不符、凭空猜测）“的数据集
·目标：提高参数提取的准确性和完整性，遵守格式要求，并在信息不足时学会追问而不是猜测。
数据构造方法
。参数完整性与追问样本
·函数：book_flight（origin：str，destination： str，date：str）（所有参故都是required)
User：“我想订一张去上海的机票。“
或清测)
·对应的训练样本
代码快
nessages*: [
“].)
（“role”：“assistant”，“content”：“好的，请问忽想从哪里出发，以及哪一天出行呢？"）//注
参数格式化样本
·函数：schedule_neeting(title:str, date_time:str)（date_time格式要求：YYYY-MM-
DDTHH:MM:55°)
·User：“帮我安排一个会议，主题是周会，时间是下图三下午3点。
\"date_tine\”：\“[计算出的下同三下午3点的Iso格式日期时间]\"}"}
可选参数处理样本
·函数: search_products(keyword: str, category: Optional[str] - None, min_price
Optional[int] =None)
User：“搜一下”蓝牙耳机”
·Assistant: (name”:“search_products", “arguments*:“(\*keyword\°:\“蓝牙耳机\")")
（只提供必要参数）
User：“在“数码”分类下搜“蓝牙耳机”，价格至少100块”
·Assistant: ["nane": “search_products"
·Assistant:(“nane”:“schedule_neeting",“argunents":“{\"title\":\"周会\”
"date_tine\”：\"[计算出的下周三下午3点的Iso格式日期时间]\"}”}
可选参数处理样本
Optional[int] - None)
·User：“搜一下蓝牙耳机”
·Assistant:("nane”:“search_products",“arguments":“(\"keyword\°:\"蓝牙耳机\")")
（只提供必要参数）
User：“在”数码“分类下搜”蓝牙耳机”，价格至少100块”
·Assistant: {“nane”:“search_products”, “arguments":“(\"keyword\*:\“蓝牙耳机\"
\"category\"：\"数码\"，\"min_price\"：100)"）（提供了可选参数）
避免凭空猜测参数
·User：“帮我查直订单，“（没有订单号）
·Assistant（正确行为-追问）：“您好，请提供一下订单号，我为您查询。“
·对应的训练样本
代码快
] :_salessou
(”role”：“systen”，“content”：“[包含query_order函数定义，需费order_id]”}。
(”role”：“assistant”，“content”：“您好，请提供一下订单号，我为思查询，“}
D.针对“现有数据不足（特定领域函数调用经验缺乏）“的数据集
·目标：弥补模型在特定领域（如旅行、电商、医疗等）的Function Calling经验。
·数据构造方法
领域术语映射
·领域：旅行-机票预订
·函数： find_flights(departure_city: str, arrival_city: str, departure_date: str
cabin_class: Optional[str] = *economy′)
*first')
Assistant: {"nane”: “find_flights", “argunents": “(\"departure_city\": \"t京\"
"arrival_city\”:\"组约\", \"departure_date\:\“[下个月10号的YYY-H-0D格式]\"
\"cabin_class\": \"first\")")
多轮领域对话流
·横拟用户在特定领域完成一个完整任务的对话流程，其中可能涉及多次、多种函数调用。
2.数据来露
人工摄写（GoldenData)：由领域专家或了解业务的人员根据函数定义，扭写高质量的用户输入-预期助手
行为“样本对。这是最可靠但成本最高的方式。覆盖上述提到的各种针对性情况。
。利用现有日志（如果可用）：如果有真实用户与系统的交互日志（即使是旧系统或人工客服），可以清洗、标
注后作为数据来源。需要注意数据脱敏。
。LLM辅助生成：硬用更强大的LLM（如GPT-4）根据盈数定义和一些示例（few-shotprompting）来生成多
样化的用户提问和对应的FunctionCallJSON，这一步生成的数据必须经过严格的人工审核和修正。
模板化生成：对于一些结构固定的参数提取。可以使用模板生成大量数据。
3.数据格式：遵循微调接口要求的格式，如OpenAI的JSONL格式。
1{“messages°: [("role": "systen", “content”: "You are a helpful assistant sith access to the
2 {"messages": [{"role”: "systen", “content": ".."}, ["role”: "user”, “content": “Tell me a j
4，初步平衡：确保正样本（需要调用函数）和负样本（不需要调用函故，普通聊天或追问）的比例大致合理，各
个函故被调用的频率也应有所体现。
3.2模型微调与评估（Fine-tuning&Evaluation【重点！！】
1.数据集划分：将构建好的数据集划分为训练集（Tralning Set）、验证集（Validation Set）和测试集
（TestSet），测试集必须严格保密，用于最终评估模型性能，不能在训练过程中使用。
2.模型微调：使用训练集对基础模型（如Qwen）进行微调。
3.评估脂标
。Function SelectionAccuracy：损型选择调用馨个函数的准确率。
。Argument Precision/Recall/F1 Score：参数提取的准确性。
Presence:必要参数是否都提取了？
·Correctness：参数值是否正确？
·Format：参数格式是否符合JSONSchema?
。No-CallAccuracy：模型在不应该调用函数时，正确地不调用函数的准确率。
。End-to-EndTaskSuccessRate:对于需要多轮或复杂逻辑的场景，整个任务是否成功完成（这
通常露要人工评估或更复杂的自动化测试框架）。
。Hallucination Rate(for parameters）：横型捏造参数的频率。
4.错误分析（ErrorAnalysis-至关重要！）
在验证集和测试集上运行模型，人工审查**模型出错的样本
分类错误类型：是挑错了函数？是参数漏了？是参数值错了？是格式不对？还是不该调用时调用
了?
。识别模式：哪些类型的函数调用更容易出错？用户用什么样的表达方式时模型更容易混滑？
