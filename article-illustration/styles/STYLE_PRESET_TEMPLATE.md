# Sxx · Style Name

## Positioning

一句话说明这种风格解决什么正文视觉问题。

## Best for

- ...

## Not for

- ...

## Preview

### Main preview

必须提供：

```text
preview.png
```

要求：

- 一眼能识别这个风格
- 能代表该 Style Preset 的标准状态
- 不使用已经明显偏离风格的偶然好图
- 既用于用户浏览，也作为后续生成时的视觉锚点

### Examples

推荐提供 1–2 张，通常不要超过 3 张：

```text
examples/
├── example-01.png
└── example-02.png
```

每张 example 都必须说明它代表什么典型任务，例如：

- flow：流程 / 输入处理输出
- mechanism：抽象机制
- risk：风险 / 卡点
- comparison：对照
- hidden-structure：隐藏结构

## Files

创建目录：

```text
Sxx-style-slug/
├── preview.png
├── examples/
│   ├── example-01.png
│   └── example-02.png
├── style-dna.md
├── prompt-template.md
├── composition-patterns.md
├── negative-rules.md
└── qa-checklist.md
```

## Visual asset rules

- `preview.png` 为必需资产
- `examples/` 推荐至少 1 张
- 示例图是“视觉基准”，不是装饰
- 示例图不替代文字规则
- 生成时优先同时参考视觉示例 + `style-dna.md`
- 新风格若尚未补 preview，不应标记为“完全可用”，应标记为“规则已完成 / 示例待补”

## Registration checklist

- [ ] 编号未重复
- [ ] 不是已有风格的小变化
- [ ] 已区分“画什么”和“怎么画”
- [ ] 已写明最适合 / 不适合
- [ ] 已保存至少一个参考来源或视觉描述
- [ ] 已加入 `preview.png`
- [ ] 已加入至少 1 张典型 example，或明确标记“示例待补”
- [ ] 示例图足够代表该风格，而不是偶然偏离
- [ ] 已在 `registry.md` 写明 preview / examples 路径
- [ ] 已更新 `registry.md`
