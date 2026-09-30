# Visual Assets

这个目录保存本 Skill 的视觉锚点。

正式标准结构：

```text
assets/
├── preview.png
└── examples/
    ├── example-old-vs-new.png
    └── example-x402-bazaar.png
```

三张基准图分别代表：

- `preview.png`：复杂机制 + 橘猫操作员 + 白底黑线稿 + 橙色流程箭头 + 蓝色手写批注
- `example-old-vs-new.png`：左右对照型构图，验证“对比场景”下的风格稳定性
- `example-x402-bazaar.png`：单机制服务交互型构图，验证“输入 → 服务 → 返回结果”场景

## 生成优先级

1. 视觉样本
2. Fixed IP
3. style-dna.md
4. composition-patterns.md
5. prompt-template.md

视觉样本不是装饰，而是风格锚点。没有样本时只能按文字规则近似；有样本时不得自行漂成彩色信息图。
