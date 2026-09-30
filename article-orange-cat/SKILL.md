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
- 若 `assets/preview.png` 与 `assets/examples/` 已存在，**必须优先把它们作为视觉锚点**；文字规则只用于补充，不得自行重新发明画风

## 视觉优先级

生成时按以下优先级执行：

1. 已归档视觉样本（preview / examples）
2. Fixed IP
3. Style DNA
4. Composition Patterns
5. Prompt Template

若文字规则与视觉样本观感冲突，以视觉样本的整体风格为准，但不得违反安全或任务边界。

## 固定视觉身份

橘猫操作员：

- 橘色猫
- 黑色针织帽
- 圆形黑墨镜
- 黑色高领 / 黑衣服
- 简化、扁平、编辑说明书插画感
- 不强调写实毛发
- 默认不加入雪茄等非必要元素
- 猫必须参与关键动作，不能只在角落摆 pose

## 生成原则

- 纯白 / 暖白底为默认背景，画面绝大部分保持留白
- 黑色手绘线稿是主要视觉语言
- 一图一个机制 / 动作 / 认知任务
- 优先 2–3 个核心道具
- 抽象关系转成物理动作
- 橙色 = 猫本体、流程 / 流向、少量重点
- 蓝色 = 手写解释 / 操作批注
- 红色 = 真正风险 / 警告
- 绿色仅在明确表达“正确 / 通过 / 可行”时少量使用
- 可以有轻微冷幽默，但清晰度优先
- 比例按构图选择 16:9 / 4:3 / 3:4 等
- **每个认知锚点必须独立生成一张图**
- **禁止为了效率把多个正文图拼成六宫格、九宫格或多面板总图**

## 工作流

1. 接收上游 shot list 或用户指定的文章段落。
2. 把当前唯一认知任务提炼成一句话。
3. 先读取 visual assets（若已存在），再读取参考规则。
4. 从构图模式中选择最适合的一种，但不要机械套旧图。
5. 设计橘猫的主动动作和 2–3 个主要道具。
6. 使用 prompt template 组织生成提示。
7. 每个认知锚点独立生成，不拼图。
8. 按 QA Checklist 验收；出现彩色信息图、卡片海报、复杂背景等漂移时直接判失败并重做。
9. 真实截图能更好证明的内容，不用插画伪装成证据。

## 输出

规划时输出：核心认知任务、画面动作、道具、标注、比例。

生成时：逐张生成并说明对应文章图位；不要长篇解释视觉理论。
