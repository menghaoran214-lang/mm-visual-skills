# MM Visual Skills

> One visual entrypoint, many independent visual style Skills.

小Meng的视觉 Skills 总仓库。

**Current version: v0.10.4**

## 30 秒选 Skill

| 我要做什么 | 推荐调用 | 预览 |
| --- | --- | --- |
| 一篇文章需要正文配图、自动判断图位 | `$mm-visual 给这篇文章配正文图，并标出插入位置` | [橘猫机制说明书](./article-orange-cat/assets/preview.png) |
| 想画白底线稿橘猫机制图 | `$mm-article-orange-cat 根据这段内容生成机制图` | [橘猫示例](./article-orange-cat/assets/examples/example-x402-bazaar.png) |
| 需要知识长文标题封面 | `$mm-visual 给这篇文章做封面` | [手绘干货风](./cover-handdrawn-knowledge/assets/preview.png) |
| 指定手绘干货封面风格 | `$mm-cover-handdrawn-knowledge 根据文章生成横版封面` | [封面预览](./cover-handdrawn-knowledge/assets/preview.png) |
| 数据图 / 证据图 | 先说明数据或真实截图需求，**目前没有独立稳定的风格 Skill** | 暂无 |

**依赖与质量边界：** 这些是 `SKILL.md` 工作流，默认安装到 Codex 的 `~/.codex/skills`；其他支持相同格式的客户端可指定自己的 Skills 目录，但发现与调用方式因客户端而异。生图必须由当前客户端提供相应的生图能力；**橘猫正文风格必须把真实参考图作为图片输入**。Canva MEDIA 链路是一条已验证的可选实现，不是唯一方式；若客户端无法传入真实参考图片，需明确提示阻断，不能悄悄退化为纯文字仿画。

风格仍在逐步验证：**能安装、能生成，不等于首次生图就稳定通过视觉 QA**。这里不会为了增加数量把未验证的新风格标为正式可用。

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

## 橘猫正文质量要求

生成前必须实际解码并传入橘猫参考 PNG；再分别做**原文语义校验**与**风格视觉校验**。完整技术门禁见 [article-orange-cat/references](./article-orange-cat/references/)；素材恢复、Canva 测试历史见 [CHANGELOG](./CHANGELOG.md) 与 [asset-loading](./article-orange-cat/references/asset-loading.md)。参考图输入成功不等于最终作品验收成功。

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

## 推荐安装：先看脚本，再安装

安装器自动扫描仓库根目录包含 `SKILL.md` 的目录。**先完整下载仓库、查看脚本和 dry-run 预览，再执行安装**，比直接执行远程脚本更可审计。

macOS / Linux（首次安装）：

```bash
git clone https://github.com/menghaoran214-lang/mm-visual-skills.git "$HOME/.mm-visual-skills-source"
bash "$HOME/.mm-visual-skills-source/scripts/install-or-update.sh" "$HOME/.codex/skills" --dry-run
bash "$HOME/.mm-visual-skills-source/scripts/install-or-update.sh" "$HOME/.codex/skills"
```

Windows PowerShell（首次安装）：

```powershell
git clone https://github.com/menghaoran214-lang/mm-visual-skills.git "$HOME\.mm-visual-skills-source"
& "$HOME\.mm-visual-skills-source\scripts\install-or-update.ps1" -DryRun
& "$HOME\.mm-visual-skills-source\scripts\install-or-update.ps1"
```

`git clone` 只用于第一次；以后在已有源目录下运行安装脚本，它会用 `git pull --ff-only` 拉取更新。若脚本尚未创建源码目录，dry-run 会停止并提示先克隆；dry-run **不会拉取更新，也不会修改目标安装目录**。

非 Codex 兼容客户端：把示例中的 `~/.codex/skills` 或 PowerShell 的 `-TargetDir` 换成该客户端的 Skills 目录，例如：

```bash
bash "$HOME/.mm-visual-skills-source/scripts/install-or-update.sh" "/path/to/other-client/skills" --dry-run
```

```powershell
& "$HOME\.mm-visual-skills-source\scripts\install-or-update.ps1" -TargetDir "D:\YourAgent\skills" -DryRun
```

**安装保护：** 遇到不属于本仓库的同名 Skill，安装器会拒绝覆盖；旧版仓库安装且 `SKILL.md` 内带本仓库 `metadata.source` 的目录视为可迁移的旧版；成功更新会在目标目录 `.mm-visual-skills-backups/` 保留旧文件以供人工回滚。如果要恢复，请先移走新版本对应的 Skill 文件夹，再把备份内同名文件夹和版本标记恢复到安装目录。首次安装也会创建备份目录，但没有旧版文件可恢复。

仍提供 [bootstrap.sh](./scripts/bootstrap.sh) 和 [bootstrap.ps1](./scripts/bootstrap.ps1) 供确认信任此仓库后的一键运行；**不推荐未经检查直接使用 `curl | bash` 或 `irm | iex`**。

## 检查并同步更新

安装后不需要手动 `git pull`。更新脚本会读取本地版本标记，与 GitHub `main` 的 `VERSION` 比较；只有版本不同才会询问是否同步全部由本仓库管理的 Skills。

Windows PowerShell（交互检查，发现新版本后确认更新）：

```powershell
$script = irm https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/check-update.ps1; & ([scriptblock]::Create($script))
```

Windows PowerShell（仅检查，不修改文件）：

```powershell
$script = irm https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/check-update.ps1; & ([scriptblock]::Create($script)) -CheckOnly
```

Windows PowerShell（适合计划任务或其他自动化的无交互更新）：

```powershell
$script = irm https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/check-update.ps1; & ([scriptblock]::Create($script)) -Yes
```

macOS / Linux：

```bash
curl -fsSL https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/check-update.sh | bash
```

仅检查：

```bash
curl -fsSL https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/check-update.sh | bash -s -- "$HOME/.codex/skills" check-only
```

无交互更新：

```bash
curl -fsSL https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/check-update.sh | bash -s -- "$HOME/.codex/skills" yes
```

每次安装/同步都会把当前仓库克隆或快进更新到 `~/.mm-visual-skills-source`，重新扫描仓库根目录的 `SKILL.md`，并更新 `~/.codex/skills/.mm-visual-skills-version`。新加入的根目录 Skill 会随下一次同步自动安装。更新完成后，如当前 AI 客户端没有立即发现新版本，请重启或重新加载 Skills。

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

## 仓库边界

仓库中暂存的 [Vibe Coding MCP registry](./.mcp-registry/vibe-coding-cn/server.json) 和发布 workflow 属于另一个项目，不属于任何可安装视觉 Skill。因其仍关联独立发布流程，本次不直接删除；待目标仓库与发布流程迁移完成后再清理，避免中断现有服务。

## Public repository 注意

不要提交 API Key、账号密码、未打码私人截图或其他敏感信息。
