# Qwen3 (4B) GRPO

- Source Root: `agent资料`
- Source Path: `S2-系统训练营/10-RLHF实战/Qwen3_(4B)_GRPO.ipynb`
- Source Kind: `ipynb`
- KB Type: `interview-topic`

### 安装依赖

### Unsloth

目标：通过使用 OpenR1 的数学数据集，将 Qwen3-4B-Base 转换为一个推理模型，方法是使用 GRPO。

我们首先对模型进行预微调，使 GRPO 不再尝试匹配格式 —— 这样可以加快 GRPO 的训练速度。

### GRPO 聊天模板
由于我们使用的是基础模型，应该设置一个聊天模板。你也可以自定义自己的聊天模板！

DeepSeek 使用 <think> 和 </think>，但这不是必须的 —— 你可以根据需要进行自定义！

建议至少设置一个 system_prompt（系统提示词），用于引导模型的回答。

我们在下面创建了一个简单的聊天模板。请注意，add_generation_prompt 包含了在生成提示前添加 <start_working_out>，用于引导模型开始其推理过程。

Let's see how our chat template behaves on an example

### 格式预微调
我们现在使用 NVIDIA 的 Open Math Reasoning 数据集 的一个子集，该子集已被过滤，仅保留高质量的 DeepSeek R1 推理轨迹。

我们将仅筛选大约 59 个样本，用于“预热”/预微调模型，使其理解我们自定义的 GRPO 格式。

以下model或dataset若设置后无法加载，则直接从modelscope/huggingface拉取，路径改为储存路径即可，拉取教程见第一周课程文档

我们看一下效果

我们把长度大于1/2最大长度的过滤掉，为了节约资源

然后我们token化数据集并且转化为hf的数据集格式

开始微调！

我们看一下微调的效果

### 数据准备
<a name="Data"></a>

我们用 Hugging Face's [Open R1 Math dataset](https://huggingface.co/datasets/open-r1/DAPO-Math-17k-Processed). You can also utilize OpenAI's famous [GSM8K dataset](https://huggingface.co/datasets/openai/gsm8k)

Let's look at the first row

In GSM8K, ee notice all answers like about have a ####, so we extract it. But for the Open R1 dataset, we can skip the below.

Let's map the dataset! and see the first row

用正则来提取答案

We verify it works

We now want to create a reward function to match the format exactly - we reward it with 3 points if it succeeds

If it fails, we want to reward the model if it at least follows the format partially, by counting each symbol

这个 `check_answer` 函数的评分逻辑用于评估模型生成的答案（`completions`）与真实答案（`answer`）之间的匹配程度，其核心逻辑如下

---

### 总体流程

1. 获取提问内容（主要用于定位任务）。
2. 提取模型回答中匹配格式的部分（通过 `match_format` 正则表达式）。
3. 将提取出的回答与真实答案进行对比，打分。
4. 返回每个样本的得分列表 `scores`。

---

### 每个回答的评分标准

#### 1. 完全正确

```python
if guess == true_answer:
    score += 5.0
```

* 模型输出与标准答案完全相同（包括空格），得 **5 分**。

#### 2. 去掉空格后匹配

```python
elif guess.strip() == true_answer.strip():
    score += 3.5
```

* 答案在去除前后空格后匹配，得 **3.5 分**（容错空间更大，格式不要求严格）。

#### 3. 数值接近

```python
ratio = float(guess) / float(true_answer)
```

* 如果是数值型答案（如数学题），会判断其相对误差

| 相对误差范围 | 分数 |
| ----------- | ---- |
| 90% \~ 110% | +2.0 |
| 80% \~ 120% | +1.5 |
| 超出此范围 | -2.5 |

#### 4. 非法值或完全错误

```python
if guess is None:
    scores.append(-2.0)
except:
    score -= 4.5
```

* 如果正则匹配失败或无法转换为数值，说明答案格式错误，扣 **2.0 到 4.5 分不等**。

---

### 🔚 输出

返回一个列表 `scores`，每个元素对应一个样本的得分。

---

### ✅ 示例总结

| 模型输出 | 真实答案 | 得分说明 | 分数 |
| ----------- | ------ | --------- | ---- |
| `"42"` | `"42"` | 完全匹配 | 5.0 |
| `" 42 "` | `"42"` | 空格容忍匹配 | 3.5 |
| `"43"` | `"42"` | 相对误差 <10% | 2.0 |
| `"50"` | `"42"` | 相对误差 <20% | 1.5 |
| `"100"` | `"42"` | 相对误差太大 | -2.5 |
| `"abc"` | `"42"` | 无法转换为数值 | -4.5 |
| `None`（未提取） | `"42"` | 无结果/正则没匹配 | -2.0 |

我们现在准备主函数，它将打印出生成的回复和真实答案。同时，还会准备另一个奖励函数，该函数通过 float 将文本转换为浮点数，并判断其是否相同。

过滤了10%的长文本

<a name="Train"></a>
### Train the model

Now set up GRPO Trainer and all configurations!

And let's run the trainer! If you scroll up, you'll see a table of rewards. The goal is to see the `reward` column increase!

You might have to wait 150 to 200 steps for any action. You'll probably get 0 reward for the first 100 steps. Please be patient!

| Step | Training Loss | reward | reward_std | completion_length | kl |
|------|---------------|-----------|------------|-------------------|----------|
| 1 | 0.000000 | 0.125000 | 0.000000 | 200.000000 | 0.000000 |
| 2 | 0.000000 | 0.072375 | 0.248112 | 200.000000 | 0.000000 |
| 3 | 0.000000 | -0.079000 | 0.163776 | 182.500000 | 0.000005 |

<a name="Inference"></a>
### Inference
Now let's try the model we just trained! First, let's first try the model without any GRPO trained

And now with the LoRA we just trained with GRPO - we first save the LoRA first!

Verify LoRA is actually trained!

Now we load the LoRA and test

可以看出，在经过了grpo之后的模型表现更好
