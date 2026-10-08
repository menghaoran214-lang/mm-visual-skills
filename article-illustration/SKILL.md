---
name: mm-article-illustration
description: |
  正文配图总入口。用于中文或英文文章、公众号、博客、长推文、Notion 文档、项目复盘和方法论的正文配图。
  Trigger for "$mm-article-illustration", "正文配图", "文章配图", "这篇怎么配图", "找配图位置",
  and requests to choose or route to a specific article-illustration style Skill.
metadata:
  author: "menghaoran214-lang"
  collection: "MM Visual Skills"
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
  compatibility: "Codex and any agent that supports SKILL.md"
---

# MM Article Illustration

这是“正文配图”分类的总入口，不负责定义某一种固定画风。

它负责：

1. 阅读文章并找出真正值得配图的认知锚点；
2. 判断哪些位置适合机制图、表格/对照图、真实截图/证据图或纯文字；
3. 从正文配图风格 Skill Registry 中选择最合适的风格 Skill；
4. 用户点名某个风格 Skill 时直接路由过去；
5. 用户要求执行时继续推进，而不是只给推荐。

## Active Style Skills

先读：`styles/registry.md`

当前：

- `$mm-article-orange-cat`：橘猫机制说明书

以后新增正文配图风格时，新增独立根级 Skill，并在 registry 里登记。

## Workflow

1. 完整阅读文章。
2. 区分：
   - 机制图
   - 表格 / 对照图
   - 真实截图 / 证据图
   - 不配图
3. 选择 2–4 个真正值得画的认知锚点，不平均分布。
4. 形成 shot list。
5. 根据文章类型与认知任务，选择一个正文风格 Skill。
6. 如果用户明确指定风格，则直接使用对应风格 Skill。
7. 用户要求生成时，先执行对应风格 Skill 的素材完整性和视觉输入预检；若参考图不可读或生成工具不能接收参考图，**停在错误状态并说明阻断原因**，不得改用其它画风、纯文字画图或假装生成成功。预检通过才继续生成。
8. 输出：
   - 正文机制图清单
   - 精确插入位置
   - 其他真实截图 / 表格 / 证据图建议

## Cognitive Anchor Selection

优先画：

- 新机制第一次出现
- 输入 → 处理 → 输出
- 难以脑补的因果关系
- 抽象概念拟物化
- 关键前后变化
- 瓶颈 / 风险边界
- 强隐喻

不要画：

- 每段简单复述
- 纯情绪
- 纯转场
- 已经有真实截图更能证明的内容
- 只有塞大量文字才能解释的内容

## Shot List Contract

每张图至少包含：

- 图名
- 核心认知任务
- 对应原文位置
- 精确插入位置
- 推荐风格 Skill
- 角色动作 / 构图方向
- 主要道具
- 建议标注
- 推荐比例
- 为什么值得画

## Adding a New Article Style

当用户说“把这种风格收进正文配图风格库”时：

1. 分析视觉 DNA；
2. 判断是否与已有风格 Skill 重复；
3. 如果是稳定、可复用的新风格，则创建新的独立根级 Skill；
4. 新 Skill 至少包含：
   - `SKILL.md`
   - `README.md`
   - `agents/openai.yaml`
   - `references/`
   - `assets/`
5. 在 `styles/registry.md` 登记；
6. 不再使用 Style Preset 目录。
