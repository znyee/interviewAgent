# DeepSeek R1 Distilled Llama 8B微调实战

- Source Root: `agent资料`
- Source Path: `S2-系统训练营/9-微调实战/DeepSeek R1 Distilled Llama 8B微调实战.ipynb`
- Source Kind: `ipynb`
- KB Type: `interview-topic`

# Unsloth Fine-tuning DeepSeek R1 Distilled Llama 8B

在这个notbook中，将演示如何使用Unsloth在医学数据集上微调DeepSeek-R1-Distill-Llama-8B模型。

1、在内蒙B区（要与数据盘在同一个大区）租用实例，将模型文件、llamafactory解压到autodl-tmp目录下，将数据文件复制到autodl-tmp目录下
这里模型文件、数据文件已经上传好，下载地址为
- 模型（huggingface）：https://huggingface.co/unsloth/DeepSeek-R1-Distill-Llama-8B/tree/main
- 数据（huggingface）：https://huggingface.co/datasets/FreedomIntelligence/medical-o1-reasoning-SFT/tree/main

## 按照99天第5天内容下载模型和数据集

## 环境准备

## 模型加载

**模型选择方法**
- 选择一个与您的使用案例相符的模型
- 评估您的存储、计算能力和数据集
- 选择模型和参数
- 选择基础模型还是指令模型

## 训练前模型推理

## 数据集准备

医疗数据集： https://huggingface.co/datasets/FreedomIntelligence/medical-o1-reasoning-SFT/
华佗o1的训练数据集

## 模型训练

使用Huggingface TRL's SFTTrainer

**report_to 参数用于指定训练过程中报告的目的地，可以设置为以下几种值：**

"none"：不报告任何信息。这通常用于不需要进行外部监控的本地训练。

"wandb"：将训练日志、模型等信息发送到 Weights & Biases (wandb)，一个用于机器学习实验管理和可视化的平台。如果你希望在训练过程中查看图表、损失函数变化等信息，并跟踪模型的训练过程，选择 wandb。

"tensorboard"：将训练日志发送到 TensorBoard，以便在本地或远程访问并可视化训练过程。可以通过启动 tensorboard 服务器来查看训练日志。

"comet"：将训练日志发送到 Comet，这是一个类似于 Weights & Biases 的机器学习实验跟踪平台。

"mlflow"：将训练日志发送到 MLflow，一个开源的平台，用于管理机器学习生命周期。

"neptune"：将训练日志发送到 Neptune，这是另一个机器学习实验管理平台。

## 微调后的评估
