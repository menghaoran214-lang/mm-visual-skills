---
name: mm-article-orange-cat
description: |
  橘猫机制说明书正文配图 Skill。用于把文章中的抽象机制、工作流、技术关系、项目复盘、MVP、瓶颈、风险和认知转折，
  翻译成固定橘猫操作员参与动作的白底线稿机制图。Trigger for "$mm-article-orange-cat", "橘猫机制说明书",
  "橘猫正文配图", "用橘猫风格配图", and article illustration requests that explicitly select this style.
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  category: "article-illustration"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# MM Article · Orange Cat Explainer

这是正文配图分类下的一个独立风格 Skill。

它既定义“怎么画”，也负责在这个风格内完成生成与验收。上游 `$mm-article-illustration` 负责文章级图位与风格路由；用户直接点名本 Skill 时，可直接执行。

## 必读参考

生成或编辑前按需读取：

- `references/style-dna.md`
- `references/composition-patterns.md`
- `references/prompt-template.md`
- `references/negative-rules.md`
- 交付前读取 `references/qa-checklist.md`
- 若 `assets/preview.png` 与 `assets/examples/` 已存在，把它们作为视觉锚点

## 固定视觉身份

橘猫操作员：

- 橘色猫
- 黑色针织帽
- 圆形黑墨镜
- 黑色高领
- 简化、扁平、编辑说明书插画感
- 不强调写实毛发
- 默认不加入雪茄等非必要元素
- 猫必须参与关键动作，不能只在角落摆 pose

## 生成原则

- 白底 / 暖白底，大量负空间
- 细黑线稿
- 一图一个机制 / 动作 / 认知任务
- 优先 2–3 个核心道具
- 抽象关系转成物理动作
- 橙色 = 流程 / 流向
- 蓝色 = 操作提示 / 解释批注
- 红色 = 真正风险 / 警告
- 可以有轻微冷幽默，但清晰度优先
- 比例按构图选择 16:9 / 4:3 / 3:4 等

## 工作流

1. 接收上游 shot list 或用户指定的文章段落。
2. 把当前唯一认知任务提炼成一句话。
3. 从构图模式中选择最适合的一种，但不要机械套旧图。
4. 设计橘猫的主动动作和 2–3 个主要道具。
5. 使用 prompt template 组织生成提示。
6. 每个认知锚点独立生成，不拼九宫格。
7. 按 QA Checklist 验收；风格漂移时优先修角色、线条、留白和色彩职责。
8. 真实截图能更好证明的内容，不用插画伪装成证据。

## 输出

规划时输出：核心认知任务、画面动作、道具、标注、比例。

生成时：逐张生成并说明对应文章图位；不要长篇解释视觉理论。
