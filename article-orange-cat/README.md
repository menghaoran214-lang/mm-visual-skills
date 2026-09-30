# 橘猫机制说明书 · 正文配图 Skill

> 一个风格就是一个 Skill。

这是 MM Visual Skills 的正文配图风格 Skill：`$mm-article-orange-cat`。

它专门把抽象机制、流程、卡点、技术关系和项目复盘，画成“橘猫正在操作一个系统”的白底手绘机制说明图。

## 单独安装

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/article-orange-cat
```

## 快速调用

```text
$mm-article-orange-cat 给下面这篇文章做正文配图。每张只解释一个机制，橘猫必须参与关键动作。
```

## 视觉基准

固定目标：

- 纯白 / 暖白背景，大面积留白
- 黑色手绘线稿为主
- 固定橘猫：黑针织帽、圆黑墨镜、黑高领 / 黑衣服
- 一图一个认知锚点
- 橙色 = 猫 / 流程 / 少量重点
- 蓝色 = 手写操作 / 解释批注
- 红色 = 真正风险
- 绿色 = 正确 / 通过时少量使用
- 一张图独立生成，不拼六宫格 / 九宫格
- 先解释清楚，再加一点冷幽默

## 明确禁止

- 彩色天空、草地、景观背景
- 渐变色卡片
- 彩色 UI 信息图
- 大标题 Banner
- 六宫格、多面板总图
- 普通可爱卡通猫
- 3D / 写实 / 电影感

## Visual Assets

标准结构：

```text
assets/
├── preview.png
└── examples/
    ├── example-old-vs-new.png
    └── example-x402-bazaar.png
```

生成时应优先参考这些视觉样本，再读取文字规则。视觉样本用于锁定“整体观感”，文字规则用于补充边界和语义。
