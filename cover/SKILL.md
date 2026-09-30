---
name: mm-cover
description: |
  MM Visual Skills 的文章封面分类入口。用于根据文章主题、平台和内容结构选择封面风格 Skill。
  Trigger for "$mm-cover", "文章封面", "X Article 封面", "Twitter 长文封面", "给这篇文章做封面", and cover requests without a fixed style.
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  category: "cover"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# MM Cover

文章封面分类入口。职责是先判断文章要传达的核心冲突，再选择具体封面风格 Skill。

## Active Styles

- `$mm-cover-handdrawn-knowledge`：手绘干货风。适合教程、项目复盘、AI/Web3/商业分析、工具介绍、方法论和知识型长文。

## Routing

1. 先提炼“这篇文章最值得点击的一句话”。
2. 判断封面是观点型、教程型、对比型、产品型、复盘型还是研究型。
3. 用户未指定风格时，若内容属于知识型/干货型长文，默认优先路由到 `$mm-cover-handdrawn-knowledge`。
4. 用户明确点名某个封面风格时，直接进入对应风格 Skill。
5. 新出现且可稳定复用的封面视觉语言，创建独立风格 Skill，不塞进已有 Skill。

## Principle

> 封面首先是一张标题封面，其次才是一张信息图。

标题必须是第一视觉中心；视觉对象、IP、流程和装饰都为标题服务。
