# 带KV Cache的Transformer

- Source Root: `agent资料`
- Source Path: `S2-系统训练营/3-手撕Llama3/带kv cache的Transformer.ipynb`
- Source Kind: `ipynb`
- KB Type: `interview-topic`

# 带kv cache的Transformer

**课程为你提供两个版本的Transformer Decoder实现代码：一个带KV Cache优化，一个不带KV Cache，并进行性能对比。## 主要差异点：**

**1. KV Cache 机制：**
- 在`MultiHeadAttention`中，缓存每一层的Key和Value矩阵
- 新的推理步骤时，只需计算新token的K、V，然后与缓存的历史K、V拼接
- 避免了重复计算已处理过的token的attention

**2. 前向传播差异：**
- **带KV Cache**: 增量生成时只处理最后一个新token
- **不带KV Cache**: 每次都要处理完整序列

**3. 性能优化：**
- **时间复杂度**: 从O(n²)降低到O(n)
- **内存使用**: 用空间换时间，缓存历史计算结果

## 核心优势

1. **计算效率**: 避免重复计算，特别是在长序列生成时效果显著
2. **实际加速**: 在实际应用中通常能获得2-10倍的推理速度提升
3. **可扩展性**: 序列越长，KV Cache的优势越明显
