# MM Visual Skills

> One visual entrypoint, many reusable styles.

小Meng的个人视觉 Skill 总仓库：统一管理正文配图、封面、数据图、证据图与可扩展视觉风格库。

## 设计目标

这个仓库不采用“一个视觉风格 = 一个 Skill”的方式。

它把两件事分开：

- **Skill**：解决稳定任务，例如正文配图、封面、数据视觉。
- **Style Preset**：定义视觉长什么样，例如橘猫机制说明书、未来新增的 S02 / S03。

因此以后新增视觉风格，只需要扩展 Style Registry，不需要增加新的调用入口。

## 当前结构

```text
mm-visual-skills/
├── README.md
├── mm-visual/
│   ├── SKILL.md
│   └── agents/openai.yaml
└── article-illustration/
    ├── SKILL.md
    ├── agents/openai.yaml
    ├── qa-checklist.md
    └── styles/
        ├── registry.md
        ├── STYLE_PRESET_TEMPLATE.md
        └── S01-orange-cat-explainer/
            ├── style-dna.md
            ├── prompt-template.md
            ├── composition-patterns.md
            ├── negative-rules.md
            └── qa-checklist.md
```

## 最简单调用

不知道该用什么时：

```text
$mm-visual 把这篇文章配好图。
```

正文配图：

```text
$mm-article-illustration 分析下面文章，找出最值得配图的位置，给出图位并生成。
```

指定风格：

```text
这篇用 S01 橘猫机制说明书。
```

收藏新风格：

```text
把这张参考图分析后收进正文配图风格库。
```

## 当前 Style Preset

### S01 · 橘猫机制说明书

用于把抽象、晦涩、流程化内容翻译成“橘猫正在操作”的可视机制图。

核心规则：

- 固定橘猫 IP：黑针织帽、圆黑墨镜、黑高领
- 白底、大留白、细黑线稿
- 一图一个认知锚点
- 抽象关系转成物理动作
- 橙色 = 流程
- 蓝色 = 操作批注
- 红色 = 风险
- 可以有轻微冷幽默，但先保证理解
- 禁止漂成海报、密集信息图或整篇总结图
- 比例根据内容选择 16:9 / 4:3 / 3:4 等

## 扩展原则

以后新增 S02、S03 时，只增加新的 Style Preset 并更新 `styles/registry.md`。

当某种“任务”已经稳定独立，例如封面生成或数据视觉，再新增对应 Skill。

## Public repository 注意

不要提交 API Key、账号密码、未打码私人截图或其他敏感信息。
