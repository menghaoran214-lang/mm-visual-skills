---
name: mm-cover-handdrawn-knowledge
description: |
  手绘干货风文章标题封面 Skill。用于 X / Twitter Article、知识长文、教程、项目实测、AI/Web3/商业分析等横版封面。
  核心是“超强标题 + 手绘角色 + 一个真实业务对象 + 少量信息图 + 粗笔刷强调 + 高对比排版”，
  同时动态变化配色、背景、构图和橘猫动作，避免模板化和审美疲劳。
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  category: "cover"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# MM Cover · Handdrawn Knowledge

风格名：**手绘干货风**

## Core Principle

> 统一的是品牌语言，不是模板。

> 封面首先是一张“标题封面”，其次才是一张“信息图”。

默认适用于 X / Twitter Article 横版封面，默认比例约 **2.5:1**（如 2000×800、2500×1000）。

## 必读参考

生成前按需读取：

- `references/style-dna.md`
- `references/composition-patterns.md`
- `references/color-system.md`
- `references/ip-system.md`
- `references/prompt-template.md`
- `references/negative-rules.md`
- `references/reference-analysis.md`

交付前读取：

- `references/qa-checklist.md`

### Visual anchors

`assets/preview.png` 与 `assets/examples/` 已作为正式视觉锚点归档。

生成前必须优先观察视觉样本的**共同观感**，再用文字规则补充边界。样本用于锁定风格 DNA，不得被当成固定模板机械复刻。尤其禁止因为样本里出现了某种颜色、人物站位或三栏结构，就在后续每张图重复使用。

视觉优先级：

1. `assets/preview.png`
2. `assets/examples/`
3. Style DNA
4. Composition / Color / IP rotation rules
5. Prompt Template

## Fixed Brand DNA

固定的是：

- 超强中文标题排版
- 手绘线稿 / 马克笔 / 粗笔刷质感
- 编辑设计 Editorial + 商业信息图混合
- 橘猫 IP：橘色毛发、黑针织帽、圆黑墨镜、黑高领/黑卫衣
- 一个真实业务对象：手机、网页、UI、产品、Logo、图表或工具
- 少量箭头、批注、图标、流程
- 高信息密度但强层级

不固定的是：

- 配色
- 背景材质
- 橘猫站位
- 橘猫姿势
- 产品位置
- 信息图形式
- 标题行数与左右结构

## Workflow

1. 阅读全文，不立刻出图。
2. 提炼文章核心冲突：**“最值得点击的一句话是什么？”**
3. 把原始文章标题压成封面主标题 + 可选副标题。
4. 选 3–4 个最值得视觉化的关键词。
5. 确定一个主业务对象，不得同时塞多个竞争主视觉。
6. 为橘猫选择与内容相关的角色动作。
7. 根据文章题材选择构图、主色、背景材质。
8. 检查是否与最近封面在颜色、站位、动作上过度重复。
9. 生成。
10. 按 QA 验收；若标题不是第一视觉中心，直接重做。

## Information Density

一张封面只保留：

- 1 个核心主题
- 1 个主业务对象
- 3–5 个辅助信息点

不要把整篇文章压缩成一张总信息图。

## Hard Rules

- 标题必须是第一视觉中心。
- 橘猫必须参与表达，不只是站着摆 pose。
- 不连续复用“标题左 + 产品中 + 猫右”的同一模板。
- 不连续复用同一主色。
- 不连续复用同一姿势和同一表情。
- 若产品/UI 本身已足够解释主题，橘猫可以缩小为辅助角色。
- 如果 3 秒内看不懂主题，说明信息组织失败。
