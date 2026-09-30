---
name: mm-visual
description: |
  小Meng视觉总控。用户不知道该调用哪个视觉能力，或直接给出文章、参考图、封面、数据图、证据图需求时使用。
  负责理解目标并路由到最窄的视觉 Skill；新增视觉风格时优先扩展 Style Registry，而不是新增 Skill。
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# MM Visual

## Purpose

这是 MM Visual Skills 的统一入口。

用户不需要记住整个仓库结构，只需要说想得到什么结果。总控负责识别视觉任务，并路由到对应 Skill。

## Active Routes

| 用户目标 | 路由 | 典型输出 |
| --- | --- | --- |
| 给文章、博客、长推文、方法论、项目复盘做正文配图 | `$mm-article-illustration` | 认知锚点、shot list、插图位置、逐张配图、截图/表格建议 |
| 收集新的正文配图风格 | `$mm-article-illustration` 的 Style Registry | 新 Style Preset |
| 封面 / 首图 | 预留 `cover` | 封面方案与成图 |
| 数据图 / 对照图 / 总结图 | 预留 `data-visual` | 数据视觉 |
| 单纯判断文章还缺哪些真实截图或证据图 | 当前由 `$mm-article-illustration` 一并处理 | 非生成图建议 |

## Routing rules

- 用户直接发完整文章并要求配图：路由到 `$mm-article-illustration`。
- 用户明确说“正文图”“文章配图”“这篇该怎么配图”：路由到 `$mm-article-illustration`。
- 用户说“把这种风格收进去”：不要新建 Skill；进入正文配图 Style Registry。
- 用户点名 S01 / S02 等风格时，直接使用指定 Style Preset。
- 用户未指定视觉风格时，由下游 Skill 根据文章内容与 Style Registry 自动选择。
- 不要因为出现“图”“图片”关键词就机械路由；优先判断最终输出。

## Core architecture

始终把“任务”和“风格”分开：

```text
用户目标
   ↓
$mm-visual
   ↓
稳定任务 Skill
   ↓
Style Registry
   ↓
具体 Style Preset
   ↓
生成 / 编辑 / 验收
```

新增视觉风格时，只新增 Style Preset。

只有出现新的稳定任务类型时，才新增 Skill。
