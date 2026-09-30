# MM Visual Skills

> One visual entrypoint, many independent visual style Skills.

小Meng的视觉 Skills 总仓库。

**Current version: v0.9.0**

## 核心架构

```text
mm-visual-skills
├── mm-visual                  # 全局总入口
├── article-illustration       # 正文配图分类入口
├── article-orange-cat         # 正文风格 Skill：橘猫机制说明书
├── cover                      # 文章封面分类入口
├── cover-handdrawn-knowledge  # 封面风格 Skill：手绘干货风
└── future-data-style-*        # 未来：数据图风格 Skills
```

核心规则：

> **一个稳定、可复用的视觉风格 = 一个独立 Skill。**

分类入口负责识别任务和选择风格；具体风格 Skill 负责生成、编辑和 QA。

## 当前 Skills

| Skill | 类型 | 作用 |
| --- | --- | --- |
| `$mm-visual` | 全局总入口 | 在正文、封面、数据图等视觉任务之间路由 |
| `$mm-article-illustration` | 正文配图分类入口 | 找认知锚点、图位，并选择正文风格 Skill |
| `$mm-article-orange-cat` | 正文风格 Skill | 橘猫机制说明书 |
| `$mm-cover` | 封面分类入口 | 提炼核心冲突并选择封面风格 Skill |
| `$mm-cover-handdrawn-knowledge` | 封面风格 Skill | 手绘干货风文章标题封面 |

## 手绘干货风 Preview

![手绘干货风](./cover-handdrawn-knowledge/assets/preview.png)

核心原则：

> **标题封面为主，插画与信息图为辅。**

> **统一的是品牌语言，不是模板。**

详细规则与更多样例见：

`cover-handdrawn-knowledge/`

## 安装整套

如果当前 AI 支持从 GitHub 仓库安装 Skill Collection，直接发：

```text
帮我安装这个 Skills：
https://github.com/menghaoran214-lang/mm-visual-skills
```

整套安装 = 安装仓库根目录下所有包含 `SKILL.md` 的 active Skills。

## 单独安装

正文总入口：

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/article-illustration
```

橘猫机制说明书：

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/article-orange-cat
```

封面总入口：

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/cover
```

手绘干货风封面：

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/cover-handdrawn-knowledge
```

## 一键本地安装 / 更新

Windows PowerShell：

```powershell
irm https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/bootstrap.ps1 | iex
```

macOS / Linux：

```bash
curl -fsSL https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/bootstrap.sh | bash
```

安装脚本会自动扫描仓库根目录下所有包含 `SKILL.md` 的目录，因此以后新增风格 Skill 不需要再改安装器。

默认目标目录：

```text
~/.codex/skills
```

## 使用示例

不知道用哪个：

```text
$mm-visual 给这篇文章配图。
```

正文自动选风格：

```text
$mm-article-illustration 分析这篇文章，找出最值得配图的位置，并自动选择合适的正文风格 Skill。
```

直接用橘猫：

```text
$mm-article-orange-cat 给这篇文章做正文配图。
```

封面自动选风格：

```text
$mm-cover 给这篇文章做封面。
```

直接用手绘干货风：

```text
$mm-cover-handdrawn-knowledge 根据这篇文章生成 X Article 横版封面。
```

## 风格 Skill 标准结构

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

每种风格至少应该有：

- 1 张 `preview.png`
- 1–3 张代表性 example
- 完整视觉 DNA
- Prompt 模板
- 构图模式
- 禁止项
- QA

## 版本与发布

正式更新时：

```text
修改 Skill
→ 更新 CHANGELOG / README
→ 最后修改 VERSION
→ GitHub Actions 自动创建 Tag / Release
```

详见 `RELEASING.md`。

## Public repository 注意

不要提交 API Key、账号密码、未打码私人截图或其他敏感信息。
