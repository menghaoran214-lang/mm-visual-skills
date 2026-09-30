# 手绘干货风 · 文章标题封面 Skill

Skill：`$mm-cover-handdrawn-knowledge`

适合：

- X / Twitter Article 长文封面
- AI / Coding / Web3 / 工具教程
- 项目实测与复盘
- 商业方法论
- 平台对比
- 研究型知识文章

## 核心视觉公式

> **超强标题 + 手绘人物/IP + 一个真实业务对象 + 少量信息图 + 粗笔刷强调 + 高对比排版**

默认比例：约 **2.5:1**。

最重要的设计原则：

> **统一品牌语言，不固定模板。**

配色、背景、橘猫动作和站位必须根据主题动态变化。

## Visual Preview

主视觉锚点：

![手绘干货风 Preview](./assets/preview.png)

对比样例：

![手绘干货风 Red Example](./assets/examples/example-red.png)

这两张图不是固定模板，只用于锁定共同视觉 DNA：

- 标题必须是第一视觉中心
- 强关键词用主题色强调
- 一个真实业务对象帮助落地主题
- 橘猫参与表达但不能压过标题
- 少量流程、图标、批注作为辅助
- 配色、构图、站位、动作必须随主题变化

## 视觉规则

固定：

- 强中文标题
- 手绘线稿 / 马克笔 / 粗笔刷质感
- Editorial + 商业信息图混合
- 橘猫 IP 身份
- 一个真实业务对象
- 少量解释性信息图
- 强层级、高识别度

动态：

- 主色
- 背景材质
- 橘猫位置
- 橘猫姿势 / 表情
- 产品位置
- 构图类型
- 信息图形式

## 快速调用

```text
$mm-cover-handdrawn-knowledge 根据这篇文章生成 X Article 横版封面。
```

也可以指定：

```text
$mm-cover-handdrawn-knowledge
这篇用冷蓝科技配色，橘猫不要放右侧，优先做“标题封面”，不要做复杂信息图。
```

## 目录结构

```text
cover-handdrawn-knowledge/
├── SKILL.md
├── README.md
├── agents/
│   └── openai.yaml
├── assets/
│   ├── preview.png
│   ├── README.md
│   └── examples/
│       └── example-red.png
└── references/
    ├── style-dna.md
    ├── composition-patterns.md
    ├── color-system.md
    ├── ip-system.md
    ├── prompt-template.md
    ├── reference-analysis.md
    ├── negative-rules.md
    └── qa-checklist.md
```
