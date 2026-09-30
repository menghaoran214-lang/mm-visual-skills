# Article Illustration Style Skill Registry

这里登记“正文配图”分类下的独立风格 Skills。

规则：

> 一个稳定、可复用的视觉风格 = 一个独立 Skill。

不再使用 Style Preset 目录。

## Active Skills

### mm-article-orange-cat · 橘猫机制说明书

**状态：✅ 规则已定稿｜🖼 示例图待正式归档**

路径：

```text
/article-orange-cat
```

最适合：

- 抽象机制
- 工作流
- 技术解释
- 项目复盘
- 方法论
- 输入 → 处理 → 输出
- 卡点 / 风险 / 认知转折

不适合：

- 高密度财务数据
- 大量参数对比
- 强证据型内容
- 必须展示真实产品 UI 的场景
- 纯情绪海报

## 新增风格 Skill 标准

每种新风格至少包含：

```text
style-skill/
├── SKILL.md
├── README.md
├── agents/
│   └── openai.yaml
├── assets/
│   ├── preview.png
│   └── examples/
└── references/
    ├── style-dna.md
    ├── prompt-template.md
    ├── composition-patterns.md
    ├── negative-rules.md
    └── qa-checklist.md
```

其中：

- `preview.png`：主预览图
- `examples/`：1–3 张典型示例
- `references/`：风格规则
- `SKILL.md`：触发条件、工作流、输出与边界
- `README.md`：公开安装和使用说明

新增后必须同时更新本 registry 和根 README。
