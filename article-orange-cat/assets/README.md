# Visual Assets — 橘猫正文说明图原始参考样本

## ✅ 2026-10-08 已恢复并归档

从原先已安装的 MM Visual Skills 插件归档恢复三张原始 PNG（非重新生成、非风格近似替代），并写入 GitHub 同名路径。浏览器环境已实际成功解码、打开，内容符合橘猫固定 IP 与白底黑线稿风格。

| 参考图 | 尺寸 | 字节数 | SHA-256 |
| --- | --- | ---: | --- |
| `assets/preview.png` | 640×360 | 91,577 | `6ebfd1af04d21678bbfbd4df50b2068d5c9b95a920c1048f5b99d20e223fecf4` |
| `assets/examples/example-old-vs-new.png` | 640×480 | 127,102 | `dc1b6a0de0e3ac07020cca52eb169e26656badfa9aab1ec9df77313e3353d5cc` |
| `assets/examples/example-x402-bazaar.png` | 640×360 | 94,516 | `9636e0b03e2770addbea3c64284c9ba9eaf5f1307970907c9f8bd88efd62d2b7` |

## 风格职责

- `preview.png`：猫在笔记本电脑前操作机制图，白底黑线稿、橙色流程箭头、蓝色口语批注
- `example-old-vs-new.png`：猫在旧思路与新思路间参与对照说明
- `example-x402-bazaar.png`：猫在 x402 Bazaar 小亭旁解释输入、服务和结果流向

固定橘猫：橘色猫、黑针织帽、圆黑墨镜、黑色高领；不是写实漫画角色。每张图独立解释一个机制。

## 强制校验

在仓库根执行：

```bash
python3 article-orange-cat/scripts/validate_assets.py
python3 -m unittest discover -s article-orange-cat/scripts -p 'test_*.py' -v
```

该校验要求有效 PNG 数据结构与冻结 SHA-256 同时通过；GitHub Actions 在素材变更时自动运行，并阻止带损坏素材的新版本发布。

**校验限制**：PNG 合法和哈希匹配只代表母版文件没有被替换或损坏。生图时仍须实际向生图模型传入真实参考图，并逐张进行视觉 QA（参见 `references/asset-loading.md`）。

不允许用其它图片、SVG、纯文字生图替代这些原始视觉母版。若需要正式更换母版，先由用户确认新图，再同步更新 SHA-256 与示例说明。
