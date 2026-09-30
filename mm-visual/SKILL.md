---
name: mm-visual
description: |
  Use as the main MM Visual Skills entrypoint when the user does not explicitly name a downstream visual skill,
  asks for article illustrations, covers, data visuals, evidence visuals, style collection, or is unsure which visual skill to use.
  Trigger for "$mm-visual", "mm-visual", "帮我配图", "这篇该怎么配图", "把这种风格收进去", and broad visual-workflow requests.
  Understand the user's output goal, choose exactly one active downstream skill when possible, and continue execution when requested.
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

<!-- MM Visual Skills · portable skill entry | https://github.com/menghaoran214-lang/mm-visual-skills -->

# MM Visual

## Purpose

`mm-visual` 是 MM Visual Skills 的统一入口。

用户不需要记住仓库结构，只需要描述最终想得到什么。总控负责理解目标、选择最窄的视觉 Skill，并在用户要求执行时继续推进。

如果用户已经明确点名某个下游 Skill 且输入足够，则直接使用该 Skill，不再经过总控。

## Active Routes

| 用户目标 | 路由 | 典型输出 |
| --- | --- | --- |
| 给文章、公众号、博客、长推文、Notion、项目复盘或方法论做正文配图 | `$mm-article-illustration` | 认知锚点、shot list、精确图位、逐张配图、截图/表格建议 |
| 收集新的正文配图视觉风格 | `$mm-article-illustration` 的 Style Registry | 新 Style Preset |
| 判断文章哪些位置应该用真实截图 / 证据图 / 表格 | `$mm-article-illustration` | 非生成图建议 |
| 封面 / 首图 | 尚未启用 | 未来独立 Skill |
| 数据图 / 对照图 / 总结图 | 尚未启用 | 未来独立 Skill |

## Workflow

1. 用一句话重述用户真正想得到的视觉结果。
2. 判断它属于哪个稳定任务，而不是只看“图片”“配图”等关键词。
3. 选择一个主 Skill；只有必要验证时才增加第二个步骤。
4. 如果用户要求执行，继续进入下游 Skill，不要只给路由建议。
5. 如果所需下游 Skill 尚未安装，明确告诉用户要安装哪个 Skill，不要假装已经可调用。
6. 交付前检查结果是否符合用户的输出目标，而不是只检查形式。

## Routing Rules

- 用户直接发完整文章并要求配图：路由到 `$mm-article-illustration`。
- 用户明确说“正文图”“文章配图”“这篇该怎么配图”：路由到 `$mm-article-illustration`。
- 用户说“把这种风格收进去”：不要新建 Skill；进入正文配图 Style Registry。
- 用户点名 S01 / S02 等风格时，直接使用指定 Style Preset。
- 用户未指定视觉风格时，由下游 Skill 根据文章内容与 Style Registry 自动选择。
- 不要因为出现“图”“图片”关键词就机械路由；优先判断最终输出。
- 尚未启用的封面、数据视觉等任务，不要伪装成已存在 Skill；说明当前状态即可。

## Core Architecture

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

## Output Contract

只路由时：

```text
我理解的目标：
推荐 Skill：
理由：
下一步：
```

执行时，直接报告下游 Skill 的实际结果、生成/建议内容、验证结果和仍需用户补充的真实素材。
