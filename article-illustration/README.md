# MM 正文配图

> 从文章里找出真正值得被理解的那一步，再选择合适的视觉风格把它画出来。

`$mm-article-illustration` 用于文章、公众号、博客、长推文、Notion、项目复盘和方法论的正文配图。

它不会机械地“每段配一张图”，而是先找**认知锚点**，再判断某个位置应该使用：

- 机制说明图
- 表格 / 对照图
- 真实截图 / 证据图
- 或者干脆不配图

## Chat / Codex 直接安装

直接把这句话发给支持 GitHub Skill 安装的 AI：

```text
帮我安装这个 skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/article-illustration
```

如果你希望先装统一入口，再由入口路由视觉任务：

```text
帮我安装这个 skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/mm-visual
```

建议两个一起安装。

> `mm-visual` 负责路由，但不会凭空下载尚未安装的下游 Skill。

## 工作方式

### 配图规划

```text
$mm-article-illustration 先不要生图。分析下面文章，找出最值得配图的位置，输出 shot list，并告诉我哪些地方更应该放真实截图、表格或证据图。
```

### 直接生成

```text
$mm-article-illustration 给下面文章做正文配图。先确定认知锚点和图位，再选择最适合的 Style Preset，逐张生成，不要拼图。
```

### 指定风格

```text
$mm-article-illustration 这篇使用 S01 橘猫机制说明书。
```

### 收藏新风格

```text
$mm-article-illustration 分析这张参考图，把这种视觉语言收进 Style Registry；不要新建 Skill。
```

## Style Registry

正文配图的“任务能力”和“视觉风格”分开管理。

- Skill 负责：文章分析、认知锚点、图位、生成和 QA
- Style Preset 负责：画面具体长什么样

当前：

### S01 · 橘猫机制说明书

适合：

- 抽象机制
- 工作流
- 项目复盘
- 方法论
- 输入 → 处理 → 输出
- 卡点 / 风险 / 认知转折

核心视觉语言：

- 橘猫操作员
- 黑针织帽、圆黑墨镜、黑高领
- 白底 / 暖白底、大量留白、细黑线稿
- 橙色表示流程
- 蓝色表示操作 / 解释批注
- 红色仅表示真实风险
- 一图一个认知锚点
- 允许一点冷幽默，但先保证理解

完整风格规则见 `styles/S01-orange-cat-explainer/`。

## 每种风格的标准结构

```text
Sxx-style-name/
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

`preview.png` 是视觉主锚点；`examples/` 用于展示典型任务。文字规则和视觉示例一起决定风格，不应只看其中一个。

## 使用原则

正文配图应该让图解释文字中最难理解的那一步，而不是把整篇文章做成一张总结海报，也不是为了“看起来丰富”而平均塞图。
