# 真实参考图输入适配

原图位于 `article-orange-cat/assets/`，通过 `scripts/validate_assets.py` 验证 PNG+SHA-256，实际查看像素。

优先用具有图片输入能力的原生图生图/图片编辑接口。必须能确认实际传入图片数据或图片素材 ID，不能仅在纯文本 prompt 写“参考 preview.png”。

**已经验证可用的 Canva 路径（2026-10-08）**：

1. 通过 Canva `upload_asset_from_url` 导入公开 GitHub 原始 PNG 链接，而不是尝试临时上传 URL（后者在本次环境返回 403）。
2. 已验证的三个 Canva MEDIA ID：`preview.png = MAHXaryBs_c`，`example-old-vs-new.png = MAHXasxA1ek`，`example-x402-bazaar.png = MAHXasJhDYk`。ID 属于当前 Canva 连接账户，不可假定跨账户仍有效；不可用时重新导入并获取实际 ID。
3. 调用 Canva `generate_image`，在 `imageReferences` 中为每个真实样图填入单独的 `{"type":"MEDIA","id":"真实mediaId"}`，并填写语义锁定后的提示词。主风格图 + 最相关的一张 example 通常足够。
4. 获取 `jobId` 并查看完成状态、真实成图；对照参考图执行视觉和语义双重 QA。本次案例 Canva 返回 SUCCESS，媒体 ID `MAHXankzAQA`，证明真实媒体参数可被接口接受并生成；是否通过视觉/语义 QA 要另行验收。

**两项独立状态**：`Reference Input Confirmed` 表示生图请求实际包含真实媒体；`Visual/Semantic QA Passed` 表示最终图片通过质量检查。前者成功不意味着后者成功。

如果当前工具无法实际传入图片，输出 REFERENCE_INPUT_UNAVAILABLE，禁止降级到纯文字后自称复刻母版。
