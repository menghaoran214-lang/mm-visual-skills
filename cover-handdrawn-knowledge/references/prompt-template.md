# Prompt Template

## Prompt Order

1. 画面用途与比例
2. 文章核心冲突
3. 封面标题与关键词
4. 构图类型
5. 主业务对象
6. 橘猫角色动作与位置
7. 动态配色
8. 辅助信息
9. 手绘质感
10. 负向约束

## Mother Prompt

Create a wide editorial article cover, around 2.5:1, in a hand-drawn knowledge-poster style.

The cover must be TITLE-FIRST. The Chinese headline is the dominant visual element, using oversized bold typography with only the most important keywords highlighted in the theme color.

Combine:
- bold editorial typography
- rough hand-drawn ink / marker illustration
- one real business object such as a phone, product UI, software window, chart or platform
- the fixed orange-cat mascot when appropriate
- only a small amount of infographic support such as arrows, short labels, 3–4 icons or a compact process

The fixed mascot is an orange cat wearing a black knit beanie, round black sunglasses and a black hoodie/turtleneck. Preserve identity, but vary pose, expression, scale and position according to the article.

Choose the palette dynamically from the article theme. Do not default to yellow-blue-black or red-black-white.

Use brush strokes, handwritten annotations, halftone dots and paper/ink texture sparingly.

The image should feel like a strong Chinese knowledge-creator article cover: high information density, clear hierarchy, immediate topic recognition.

Do not turn it into a dense dashboard, a full-article infographic, a cinematic scene, a generic SaaS gradient poster, or a repeated fixed template.

## Scene Slot

```text
Core conflict:
[one sentence]

Cover headline:
[2–4 lines]

Highlighted keywords:
[1–3]

Layout:
[A–H]

Primary business object:
[one]

Cat role:
[Engineer / Teacher / Analyst / Operator / Frustrated / Observer]

Cat action + position:
[action, position, scale]

Theme palette:
[main + neutral + optional accent]

Auxiliary points:
[3–5 maximum]

Background texture:
[paper / dark / blueprint / desk / collage / UI]

Avoid repeating:
[last cover color / pose / layout if known]
```
