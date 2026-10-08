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

## 强制视觉素材预检（不可跳过）

本 Skill 属于 **参考图驱动型风格**。生成之前必须执行以下门禁，并阅读 references/asset-loading.md：

1. **取到真实图片字节**：读取 assets/preview.png、assets/examples/example-old-vs-new.png、assets/examples/example-x402-bazaar.png。仅看到文件名、链接、Skill 文字或目录清单不算读取成功。
2. **先验文件完整性**：若可执行 Python，运行 python3 article-orange-cat/scripts/validate_assets.py（或在 Skill 根目录运行 python3 scripts/validate_assets.py）；全部 PASS（含 SHA-256）才继续。无法运行时，也必须借助可用解码器逐张验证 PNG 能被打开，不得跳过。
3. **真正看见参考图**：把验证通过的真实图像提供给当前视觉模型/生图工具，亲自检查橘猫 IP、线条和留白；GitHub URL、README、文字描述或工具返回的 base64 字符串本身都不能代替视觉输入。
4. **确保生成工具可使用样图**：实际传入 reference image / image edit / image-to-image 等支持的图像输入；若当前工具不能接受或确认引用样图，只能说明限制，不能宣称已经按参考图精准复刻。
5. **失败立即阻断**：任意参考图缺失、格式损坏、不能查看，或工具不支持传入参考图片时，停止生图并报告具体文件与修复建议。不得悄悄降级为纯文字绘图、生成普通漫画、手绘 SVG、借用封面 Skill 样例或编造“已按母版”。

**恢复状态（2026-10-08）：** 3 张原始参考 PNG 已从原先安装的插件归档恢复到 GitHub；预检同时校验 PNG 结构与固定 SHA-256 防止错图替换。此步骤不等于生图完成：每次仍须实际看到母版、将其作为图像输入传入生成工具，并对首张风格探针进行对照验收。详见 assets/README.md。

## 必读参考

生成或编辑前必须读取：

- `references/asset-loading.md`（预检与故障处理）
- `references/style-dna.md`
- `references/composition-patterns.md`
- `references/prompt-template.md`
- `references/negative-rules.md`
- 交付前读取 `references/qa-checklist.md`
- **必须先真实打开并审查参考图**，把可用的原图作为生成的视觉输入；即便文件存在，只要无法解码/无法给生成模型看到，也视作不合格，禁止生成

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
3. 执行强制视觉素材预检，成功解码、实际看见、并确认生图工具可接收参考图片后，才允许继续；否则停止生成。
4. 从构图模式中选择最适合的一种，但不要机械套旧图。
5. 设计橘猫的主动动作和 2–3 个主要道具。
6. 将真实参考图片作为视觉输入，并用 prompt template 补充当前认知任务、道具和动作；不要用纯文字取代视觉输入。
7. 每个认知锚点独立生成，不拼图。
8. 先只生成第一张作为风格探针，与原始参考图逐项对照验收；不合格最多定向重试一次，仍不合格则停止。通过后再逐张生成并逐张验收；彩色信息图、卡片海报、复杂背景等漂移均视为失败。
9. 真实截图能更好证明的内容，不用插画伪装成证据。

## 输出

规划时输出：核心认知任务、画面动作、道具、标注、比例。

生成时：逐张生成并说明对应文章图位；不要长篇解释视觉理论。
