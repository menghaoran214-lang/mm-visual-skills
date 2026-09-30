# MM Visual Skills

> One visual entrypoint, many reusable styles.

小Meng的个人视觉 Skill 总仓库：统一管理正文配图、封面、数据图、证据图与可扩展视觉风格库。

**Current version: v0.7.0**

## 设计目标

这个仓库不采用“一个视觉风格 = 一个 Skill”的方式。

它把两件事分开：

- **Skill**：解决稳定任务，例如正文配图、封面、数据视觉。
- **Style Preset**：定义视觉长什么样，例如橘猫机制说明书、未来新增的 S02 / S03。

因此以后新增视觉风格，只需要扩展 Style Registry，不需要增加新的调用入口。

## 当前结构

```text
mm-visual-skills/
├── README.md
├── VERSION
├── CHANGELOG.md
├── RELEASING.md
├── .github/workflows/release.yml
├── scripts/
│   ├── bootstrap.ps1
│   ├── bootstrap.sh
│   ├── install-or-update.ps1
│   ├── install-or-update.sh
│   ├── check-update.ps1
│   └── check-update.sh
├── mm-visual/
│   ├── SKILL.md
│   └── agents/openai.yaml
└── article-illustration/
    ├── README.md
    ├── SKILL.md
    ├── agents/openai.yaml
    ├── qa-checklist.md
    └── styles/
        ├── registry.md
        ├── STYLE_PRESET_TEMPLATE.md
        └── S01-orange-cat-explainer/
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

## Chat / Codex 直接安装

安装逻辑固定为两层：

### A. 安装整套 MM Visual Skills

大多数用户直接安装整个仓库即可：

```text
帮我安装这个 Skills：
https://github.com/menghaoran214-lang/mm-visual-skills
```

整套安装的语义是：

```text
mm-visual-skills
├── mm-visual
└── mm-article-illustration
```

也就是把仓库根目录下所有包含 `SKILL.md` 的 active Skill 一起安装。

以后新增 `mm-cover`、`mm-data-visual` 等新的稳定 Skill 后，整套安装 / 更新也应该自动包含它们，不需要用户一个个补装。

### B. 只安装某一个子 Skill

如果用户只想要某个能力，可以直接安装对应子目录。

只安装视觉总入口：

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/mm-visual
```

只安装正文配图：

```text
帮我安装这个 Skill：
https://github.com/menghaoran214-lang/mm-visual-skills/tree/main/article-illustration
```

> `mm-visual-skills` 是 Skill 集合；`mm-visual` 是集合里的总控 Skill；`mm-article-illustration` 是具体子 Skill。三者不要混为一谈。

对于不支持“仓库根目录 = Skill Collection”安装语义的客户端，使用下面的一键安装脚本；脚本会自动发现并安装仓库根目录下所有包含 `SKILL.md` 的 Skill。

## 1 分钟安装

普通用户不需要先 clone 仓库。复制一条命令即可完成首次安装；以后重复执行同一条命令就是更新。

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/bootstrap.ps1 | iex
```

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/bootstrap.sh | bash
```

默认安装到：

```text
~/.codex/skills
```

安装脚本会自动扫描仓库根目录，安装所有包含 `SKILL.md` 的 active Skill。

当前包括：

- `mm-visual`
- `mm-article-illustration`

未来新增新的根级 Skill 后，无需修改安装脚本，也会被整套安装 / 更新自动发现。不会删除用户其他 Skills。

如果不是 Codex，而是其他支持本地 Skills 的 AI，可以继续使用下方“安装与更新”里的自定义目录方式。

## 最简单调用

不知道该用什么时：

```text
$mm-visual 把这篇文章配好图。
```

正文配图：

```text
$mm-article-illustration 分析下面文章，找出最值得配图的位置，给出图位并生成。
```

指定风格：

```text
这篇用 S01 橘猫机制说明书。
```

收藏新风格：

```text
把这张参考图分析后收进正文配图风格库。
```

## 安装与更新

### 推荐：Git 驱动安装

本地 AI / Agent 用户推荐使用仓库自带脚本。脚本会：

1. 首次使用时 clone 本仓库；
2. 后续再次运行时执行 `git pull --ff-only`；
3. 把可安装 Skill 同步到你指定的 Skills 目录；
4. 自动发现仓库根目录下所有包含 `SKILL.md` 的 Skill，并按其 `name:` 安装；
5. 只替换本仓库管理的这些 Skill，不会删除用户其他 Skills。

> 更新会覆盖这两个 Skill 目录里的本地手工修改。个人定制建议提交到你自己的 fork 或单独保存。

#### Windows PowerShell

默认目标目录为 `~/.codex/skills`：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-or-update.ps1
```

指定其他 AI 的 Skills 目录：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-or-update.ps1 -TargetDir "D:\path\to\skills"
```

#### macOS / Linux

默认目标目录为 `~/.codex/skills`：

```bash
bash ./scripts/install-or-update.sh
```

指定其他 Skills 目录：

```bash
bash ./scripts/install-or-update.sh "/path/to/skills"
```


### 检查是否有新版本

Windows：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check-update.ps1
```

macOS / Linux：

```bash
bash ./scripts/check-update.sh
```

如果发现版本不同，脚本会提示是否立即升级。

#### 一键升级，不再询问

Windows：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check-update.ps1 -Yes
```

macOS / Linux：

```bash
bash ./scripts/check-update.sh ~/.codex/skills yes
```

#### 只检查，不更新

Windows：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check-update.ps1 -CheckOnly
```

macOS / Linux：

```bash
bash ./scripts/check-update.sh ~/.codex/skills check-only
```

安装脚本会在目标 Skills 目录写入 `.mm-visual-skills-version`，用于记录当前安装版本。检查脚本会把本地版本与 GitHub 最新 `VERSION` 对比。

### 已经 clone 过仓库

也可以直接：

```bash
git pull --ff-only
```

但如果你的 AI 是从独立 Skills 目录加载，仍建议再运行安装/更新脚本，把最新版同步进去。

### 手动复制安装

如果用户只是从 GitHub 下载 ZIP，然后手动复制到 AI 的 Skills 目录，**以后不会自动同步**。需要重新下载覆盖，或者改用上面的 Git 更新方式。

## 版本检查

仓库根目录的 `VERSION` 是当前版本号：

```text
0.7.0
```

每次正式更新同时维护：

- `VERSION`
- `CHANGELOG.md`
- README 中的版本说明


## GitHub Tag / Release 自动发布

从 v0.3.0 开始，仓库使用 GitHub Actions 自动发布正式版本。

维护流程固定为：

```text
完成 Skill / Style 修改
→ 更新 CHANGELOG
→ 更新 README（如需要）
→ 最后修改 VERSION
→ GitHub Actions 自动创建 vX.Y.Z Tag
→ 自动创建对应 GitHub Release
```

这样每个正式版本都会被永久锁定，用户可以安装最新版，也可以回退到旧版本。

详细规则见 `RELEASING.md`。

## Style Preset 示例图标准

从 v0.5.0 开始，每种视觉风格都必须配视觉示例，方便用户快速区分，也用于减少后续生成时的风格漂移。

最低标准：

- **1 张 `preview.png`：必须**
- **1–2 张 `examples/*.png`：推荐**
- 示例图必须代表该风格的标准状态，不选“偶然生成得很好但已经偏风格”的图
- 新风格如果规则已经写完但还没有 preview，应标记为“规则已完成 / 示例待补”，不能标记为完全可用

以后新增 S02、S03 时都按这个标准执行。

## 当前 Style Preset

### S01 · 橘猫机制说明书

用于把抽象、晦涩、流程化内容翻译成“橘猫正在操作”的可视机制图。

核心规则：

- 固定橘猫 IP：黑针织帽、圆黑墨镜、黑高领
- 白底、大留白、细黑线稿
- 一图一个认知锚点
- 抽象关系转成物理动作
- 橙色 = 流程
- 蓝色 = 操作批注
- 红色 = 风险
- 可以有轻微冷幽默，但先保证理解
- 禁止漂成海报、密集信息图或整篇总结图
- 比例根据内容选择 16:9 / 4:3 / 3:4 等

## 扩展原则

以后新增 S02、S03 时，只增加新的 Style Preset 并更新 `styles/registry.md`。

当某种“任务”已经稳定独立，例如封面生成或数据视觉，再新增对应 Skill。

## Public repository 注意

不要提交 API Key、账号密码、未打码私人截图或其他敏感信息。
