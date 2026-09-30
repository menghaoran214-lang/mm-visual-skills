---
name: mm-visual
description: |
  MM Visual Skills 总入口。用于正文配图、封面、数据图、证据图等视觉任务的总路由。
  Trigger for "$mm-visual", "帮我配图", "做封面", "做数据图", "不知道用哪个视觉 Skill", and broad visual-workflow requests.
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# MM Visual

`mm-visual` 是整个视觉 Skill 集合的总入口。

## Architecture

```text
MM Visual Skills
├── 正文配图
│   ├── mm-article-illustration      # 分类总入口
│   └── mm-article-orange-cat        # 风格 Skill
├── 封面
│   ├── mm-cover                     # 分类总入口
│   └── mm-cover-handdrawn-knowledge # 手绘干货风
├── 数据图
│   └── future data visual style Skills
└── 其他视觉任务
```

核心规则：

> 一个稳定视觉风格 = 一个独立 Skill。

分类入口负责选风格；具体风格 Skill 负责生成与 QA。

## Active Routes

| 用户目标 | 路由 |
| --- | --- |
| 正文配图，但未指定风格 | `$mm-article-illustration` |
| 正文配图，明确要橘猫机制说明书 | `$mm-article-orange-cat` |
| 文章封面，但未指定风格 | `$mm-cover` |
| 文章封面，明确要手绘干货风 | `$mm-cover-handdrawn-knowledge` |
| 收藏新的正文视觉风格 | `$mm-article-illustration`，并创建新风格 Skill |
| 收藏新的封面视觉风格 | `$mm-cover`，并创建新风格 Skill |
| 数据图 | 尚未启用对应分类 / 风格 Skills |

## Routing Rules

- 用户未指定正文风格：先进入 `$mm-article-illustration`。
- 用户明确点名“橘猫机制说明书”：直接进入 `$mm-article-orange-cat`。
- 用户未指定封面风格：先进入 `$mm-cover`。
- 用户明确点名“手绘干货风”：直接进入 `$mm-cover-handdrawn-knowledge`。
- 新的稳定风格：创建独立 Skill，不再作为 Preset 塞进已有 Skill。
- 新的任务大类：可以创建分类入口 Skill。
- 不要因为出现“图”字就机械路由，优先判断用户最终要的是哪类视觉结果。
