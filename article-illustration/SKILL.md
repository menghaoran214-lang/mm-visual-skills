---
name: mm-article-illustration
description: |
  用于中文或英文文章、公众号、博客、长推文、Notion 文档、项目复盘和方法论的正文配图。
  Trigger for "$mm-article-illustration", "正文配图", "文章配图", "这篇怎么配图", "找配图位置",
  "把这种风格收进配图风格库" and requests to turn abstract article ideas into understandable visual scenes.
  先识别认知锚点和具体插图位置，再从 Style Registry 选择风格；还必须判断哪些地方更应该使用真实截图、证据图、表格或保持纯文字。
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

<!-- MM Visual Skills · article illustration | https://github.com/menghaoran214-lang/mm-visual-skills -->

# MM Article Illustration

正文配图不是装饰，也不是把整篇文章压缩成一张总结海报。

它的任务是：

> 找出读者最容易“卡一下”的抽象内容，把它翻译成更容易理解的视觉画面。

## 先读参考

不要一次加载所有风格文件。按任务读取：

- **所有正文配图任务先读**：`styles/registry.md`
- **用户点名某个 Style Preset**：读取该 Style 目录下的 `style-dna.md`、`composition-patterns.md`、`prompt-template.md`、`negative-rules.md`
- **新增视觉风格**：读取 `styles/STYLE_PRESET_TEMPLATE.md`
- **交付前**：读取根目录 `qa-checklist.md` 与当前 Style Preset 自己的 `qa-checklist.md`
- **若 Style 目录存在 `preview.png` / `examples/`**：把它们作为视觉锚点，与文字规则一起使用

## 两种工作模式

### 1. 配图规划

当用户只是问“怎么配图 / 哪些地方要图 / 先分析”时：

- 先输出 shot list
- 不要擅自生成图片
- 同时指出真实截图、表格、证据图的位置

### 2. 直接生成

当用户明确要求生成时：

- 先快速确认认知锚点与图位
- 每个认知锚点单独生成一张
- 不把多张正文图拼成一张大图
- 生成后按当前 Style Preset QA 检查

## Default Workflow

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

## Cognitive Anchor Selection

优先画：

- 一个新机制第一次出现
- 一个输入 → 处理 → 输出流程
- 一个难以脑补的因果关系
- 一个抽象概念需要拟物化
- 一个关键前后变化
- 一个明确瓶颈 / 风险边界
- 一个强隐喻

不要画：

- 每一段的简单复述
- 纯情绪
- 纯转场
- 已经有真实截图更能证明的内容
- 只有把大量文字塞进图里才能解释的内容

## Shot List Contract

每张机制图至少包含：

- 图名
- 核心认知任务
- 对应原文句子 / 段落
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

## Style Selection

风格定义在 `styles/registry.md`。

用户未指定时：

1. 先看文章类型。
2. 再看认知任务。
3. 选择最能解释内容的视觉风格，而不是“最好看”的风格。
4. 如果两个风格都适合，可给出最多 2 个候选；通常直接选择，不增加用户负担。

## Collecting a New Style

当用户提供参考图并说“收进风格库”时：

1. 区分“内容元素”和“可迁移视觉语言”。
2. 提取风格 DNA：背景、线条、材质、色彩、构图、字体 / 标注、角色使用方式、信息密度、幽默程度。
3. 判断是否与已有 Style Preset 重复。
4. 新增一个递增编号的 Sxx Style Preset。
5. 按 `styles/STYLE_PRESET_TEMPLATE.md` 创建完整 Style Preset。
6. 更新 `styles/registry.md`。
7. 不因为新增风格而新增 Skill。
8. 未补主预览图时，状态必须标记为“规则已完成 / 示例待补”。

## Output Contract

### 一、正文机制图
列出真正需要生成的图。

### 二、精确图位
必须写清放在哪一句 / 哪一段后，以及原因。

### 三、其他图片
列出真实截图、表格、证据图、对照图等，并说明具体位置和作用。
