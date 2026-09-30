---
name: mm-article-illustration
description: |
  用于中文或英文文章、公众号、博客、长推文、Notion 文档、项目复盘和方法论的正文配图。
  先识别认知锚点和具体插图位置，再从 Style Registry 选择风格；还必须判断哪些地方更应该使用真实截图、证据图、表格或保持纯文字。
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# MM Article Illustration

## Goal

正文配图不是装饰，也不是把整篇文章压缩成一张海报。

它的任务是：

> 找出读者最容易“卡一下”的抽象内容，把它翻译成更容易理解的视觉画面。

## Default workflow

1. 完整阅读文章。
2. 区分四类内容：
   - **机制图**：新机制、流程、抽象关系、认知转折、隐喻。
   - **表格/对照图**：分类、参数、职责、成本、结构化对比。
   - **真实截图/证据图**：收益、后台、产品存在、开发过程、真实操作、来源证据。
   - **不配图**：纯过渡、纯态度、纯 CTA、已经足够直观的段落。
3. 从全文选出真正值得画的认知锚点。默认 2–4 张，不平均分布。
4. 读取 `styles/registry.md`，选择最适合当前文章的 Style Preset。用户点名风格时优先使用指定风格。
5. 先形成 shot list：每张图只讲一个认知任务。
6. 用户要求生成时，每张独立生成，禁止拼成九宫格或一张大图。
7. 输出固定三部分：
   - 正文机制图清单
   - 每张图的精确插入位置
   - 还需要补充的真实截图、表格、证据图及位置
8. 按 `qa-checklist.md` 与当前 Style Preset 的 QA 验收。

## Cognitive anchor selection

优先画：

- 一个新机制第一次出现
- 一个输入 → 处理 → 输出流程
- 一个难以脑补的因果关系
- 一个抽象概念需要拟物化
- 一个关键前后变化
- 一个明确瓶颈/风险边界
- 一个强隐喻（例如“先让小船下水”）

不要画：

- 每一段的简单复述
- 纯情绪
- 纯转场
- 已经有真实截图更能证明的内容
- 只有把大量文字塞进图里才能解释的内容

## Shot list contract

每张机制图至少包含：

- 图名
- 核心认知任务
- 对应原文句子/段落
- 精确插入位置
- 推荐 Style Preset
- 角色动作
- 主要道具
- 建议标注词
- 推荐比例
- 为什么值得画

## Ratio

比例不强制统一。

根据实际构图选择 16:9、4:3、3:4 或其他合理比例，不为了统一比例破坏画面表达。

## Style selection

风格定义在 `styles/registry.md`。

用户未指定时：
1. 先看文章类型。
2. 再看认知任务。
3. 选择最能解释内容的视觉风格，而不是“最好看”的风格。
4. 如果两个风格都适合，可给出最多 2 个候选；通常直接选择，不增加用户负担。

## Collecting a new style

当用户提供参考图并说“收进风格库”时：

1. 区分“内容元素”和“可迁移视觉语言”。
2. 提取风格 DNA：背景、线条、材质、色彩、构图、字体/标注、角色使用方式、信息密度、幽默程度。
3. 判断是否与已有 Style Preset 重复。
4. 新增一个递增编号的 Sxx Style Preset。
5. 必须创建：
   - `style-dna.md`
   - `prompt-template.md`
   - `composition-patterns.md`
   - `negative-rules.md`
   - `qa-checklist.md`
6. 更新 `styles/registry.md`。
7. 不因为新增风格而新增 Skill。

## Output contract

### 一、正文机制图
列出真正需要生成的图。

### 二、精确图位
必须写清放在哪一句/哪一段后，以及原因。

### 三、其他图片
列出真实截图、表格、证据图、对照图等，并说明具体位置和作用。
