# Prompt Template

## Prompt structure

每次提示词按以下顺序组织：

1. 固定角色
2. 固定视觉 DNA
3. 当前唯一认知任务
4. 角色动作
5. 2–3 个主要道具
6. 因果关系 / 流向
7. 极少量中文标注
8. 负向约束

## Mother prompt

Create an editorial mechanism-explainer illustration on a pure white or warm-white background with generous negative space.

Use the fixed orange cat mascot as the operator: an orange cat wearing a black knit beanie, round black sunglasses and a black turtleneck. Keep the character simplified, flat and graphic, with no photorealistic fur.

The image must explain only ONE cognitive idea from the article through a visible physical action. The cat should actively operate, push, sort, connect, open, stamp, filter, carry, inspect, launch or repair something.

Use thin black ink outlines and only a few simple office/workshop props. Prefer 2–3 main objects.

Color semantics:
- orange = process / flow
- blue = short conversational operation / explanation annotation
- red = real warning / risk only

Chinese labels must be short keywords, preferably written on objects or as small handwritten notes.

Add subtle dry humor through the cat's action, visual contrast, or one concise blue annotation, but never sacrifice clarity.

No poster layout.
No dense cards.
No full-article summary.
No cinematic scene.
No 3D.
No photorealism.
No decorative background.
No huge headline.
No unnecessary text.

## Scene slot

```text
Cognitive task:
[one sentence]

Cat action:
[one active verb]

Main props:
[2–3 objects]

Flow:
[left → middle → right, or single-scene relationship]

Short labels:
[0–4 short labels]

Optional blue note:
[one conversational phrase]
```
