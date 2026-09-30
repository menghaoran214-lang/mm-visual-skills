# MM 正文配图

> 正文配图分类总入口：先找图位，再选择具体风格 Skill。

`$mm-article-illustration` 不代表某一种固定画风。它负责文章级分析和路由。

## 单独安装

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/article-illustration
```

## 当前正文风格 Skills

- `$mm-article-orange-cat`：橘猫机制说明书

单独安装橘猫风格：

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/article-orange-cat
```

## 使用方式

自动选风格：

```text
$mm-article-illustration 分析下面文章，找出最值得配图的位置，并自动选择最合适的正文配图风格 Skill。
```

指定橘猫风格：

```text
$mm-article-orange-cat 给下面这篇文章做正文配图。
```

收藏新风格：

```text
$mm-article-illustration 分析这张参考图。如果它值得长期复用，就创建一个新的正文配图风格 Skill 并登记到风格库。
```

## 架构

```text
正文配图分类
├── mm-article-illustration      # 总入口 / 路由
├── mm-article-orange-cat        # 风格 Skill
├── future-style-2               # 风格 Skill
└── future-style-3               # 风格 Skill
```

一个稳定风格就是一个独立 Skill。
