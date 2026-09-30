# MM Visual Skills

> One visual entrypoint, many reusable styles.

小Meng的个人视觉 Skill 总仓库：统一管理正文配图、封面、数据图、证据图与可扩展视觉风格库。

**Current version: v0.2.0**

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
├── scripts/
│   ├── install-or-update.ps1
│   ├── install-or-update.sh
│   ├── check-update.ps1
│   └── check-update.sh
├── mm-visual/
│   ├── SKILL.md
│   └── agents/openai.yaml
└── article-illustration/
    ├── SKILL.md
    ├── agents/openai.yaml
    ├── qa-checklist.md
    └── styles/
        ├── registry.md
        ├── STYLE_PRESET_TEMPLATE.md
        └── S01-orange-cat-explainer/
            ├── style-dna.md
            ├── prompt-template.md
            ├── composition-patterns.md
            ├── negative-rules.md
            └── qa-checklist.md
```

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
4. 只替换本仓库管理的 `mm-visual` 和 `mm-article-illustration`，不会删除其他 Skills。

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
0.2.0
```

每次正式更新同时维护：

- `VERSION`
- `CHANGELOG.md`
- README 中的版本说明

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
