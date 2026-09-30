# Style Registry

这里管理“正文配图长什么样”。

Style Preset 不是独立 Skill。新增视觉风格时只扩展这里。

---

## S01 · 橘猫机制说明书 / Orange Cat Explainer

**状态：✅ 规则已定稿｜🖼 示例图待补**

### 最适合

- 抽象机制
- 工作流
- 技术解释
- 项目复盘
- 方法论
- 输入 → 处理 → 输出
- “为什么卡住 / 应该怎么做”类认知转折

### 不适合

- 高密度财务数据
- 大量参数对比
- 强证据型内容
- 必须展示真实产品 UI 的场景
- 纯情绪海报

### 核心特征

- 固定橘猫 IP
- 白底 / 暖白底
- 大量留白
- 细黑线稿
- 一图一个认知锚点
- 抽象内容物理化
- 橘猫必须参与关键动作
- 橙色 = 流程 / 流向
- 蓝色 = 操作提示 / 口语批注
- 红色 = 真正风险 / 警告
- 允许轻微冷幽默，但清晰度优先

### 示例图规范

每个 Style Preset 都必须具备视觉示例资产，用于：

- 帮助用户快速区分不同风格
- 作为生成时的视觉锚点，减少风格漂移
- 帮助系统判断某篇文章适合哪个 Style Preset
- 让公开仓库用户不用先读完整规则就能理解风格

S01 计划资产：

```text
S01-orange-cat-explainer/
├── preview.png
└── examples/
    ├── example-01-flow.png
    └── example-02-mechanism.png
```

最低要求：

- **1 张 `preview.png`：必须**
- **1–2 张 `examples/*.png`：推荐**
- 示例图必须代表这个 Style Preset 的“标准状态”，不能选择明显偏离风格的偶然好图
- 示例图不替代 `style-dna.md` 和其他文字规则，而是与规则一起作为视觉基准

目录：`S01-orange-cat-explainer/`

---

## 编号规则

新增风格按：

```text
S02-...
S03-...
S04-...
```

递增。

## 每个 Style Preset 必须包含

```text
Sxx-style-slug/
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

其中：

- `preview.png`：**必须**，风格主预览图，一眼看懂风格
- `examples/`：**推荐至少 1 张，最多通常 2–3 张**，展示不同正文任务下的应用
- `style-dna.md`：必须
- `prompt-template.md`：必须
- `composition-patterns.md`：必须
- `negative-rules.md`：必须
- `qa-checklist.md`：必须

## 注册要求

新增风格时必须写明：

- 最适合什么
- 不适合什么
- 视觉 DNA
- 信息密度
- 色彩职责
- 构图规则
- 禁止项
- 验收规则
- 主预览图路径
- 示例图路径
- 示例图分别代表什么典型场景

## 视觉示例选择原则

不要为了“好看”选示例图，要为了“代表性”选。

优先选择：

- 最能体现该风格核心视觉语言的图
- 最能体现典型正文配图用途的图
- 角色、线条、色彩、信息密度都处于标准状态的图

不要选择：

- 偶然生成得很精美但已经风格漂移的图
- 文字异常多的图
- 特殊构图导致用户误以为这是固定模板的图
- 与其他 Style Preset 太相似、无法区分的图
