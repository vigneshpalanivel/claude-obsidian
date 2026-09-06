---
tags: [health, fitness, exercise, assets]
created: 2026-08-28
updated: 2026-09-06
status: active
---

# Infographic Image Prompts — Workout Plan

Prompts for generating the workout plan as a **poster image** (not HTML). Paste into GPT Image / ChatGPT, Nano Banana / Gemini, Ideogram, or Midjourney.

> 🔄 **Synced to [[exercise-plan]] 2026-09-06,** after the plan removed core and balance work that was being prescribed twice on a Workout A day. All prompts in this file now match the plan exactly.
>
> 📌 **Decision 2026-09-06: one poster, not three.** Option A is the version to generate; Option B is kept as a fallback. **Option A was rewritten, not just promoted** — as previously written it was missing four Workout B exercises (single-leg glute bridge, side-lying leg adduction, reverse wrist curl, single-leg calf raise) and described its figures as a comma list rather than one line each, which is the main driver of poor figure rendering.

> 🔴 **Read this first.** Image models garble dense text and, more importantly, garble dense *figures*. **The fix is fewer items per image, not a better prompt.**
>
> **Use OPTION A — one poster.** It is the version to generate (decision 2026-09-06: one wall poster, not three). To make one sheet viable it carries **no sets or reps**, and the five-move hip circuit is collapsed into a single card. **Option B (three posters) is now the fallback** — go there only if Option A's figures come back unusable after 4–5 attempts.
>
> ⚠️ **Be realistic about the trade.** One poster means ~24 figures instead of 9–13, so each figure is smaller and the error rate per figure is higher. **Expect more regenerations, and treat the figure-verification table at the bottom of this file as mandatory, not optional.** That table matters *more* on a single dense poster, not less.
>
> **Ideogram and GPT Image handle poster text far better than Midjourney** — use one of those.

---

## ✅ OPTION A — The single poster *(use this one)*

Complete, load-agnostic, no sets or reps. **Rewritten 2026-09-06:** every figure now gets its own description line (a comma list gave the model too little to work with), the four missing Workout B exercises were added, and the hip circuit became one card.

**Aspect ratio is 2:3, not 4:5** — thirteen rows of content need the extra height, and 2:3 prints to A3/A4 without cropping.

```
A clean modern fitness infographic poster, vertical 2:3 portrait, dark
charcoal background (#15171c).

Title at top: "STRENGTH PLAN". Under it, a thin horizontal row of 7
small rounded boxes labeled MON TUE WED THU FRI SAT SUN.

Below that, two columns of rounded cards side by side.
Left column header "WORKOUT A" in teal (#35c6b4).
Right column header "WORKOUT B" in amber (#f0a94c).

Every card holds one flat-vector line-art figure with a short bold
white label beneath it. No numbers anywhere on the poster.

LEFT COLUMN — 9 cards:
1. Push-up, body straight, palms on floor — "Floor push-up"
2. Lying under a low waist-height bar, body in one straight line,
   heels on floor, underhand grip, pulling chest to bar — "Inverted row"
3. Lying on back, arms wide with dumbbells — "Dumbbell fly"
4. Standing, forearm curling a dumbbell — "Bicep curl"
5. Stepping up onto a knee-height box — "Step-up"
6. Lying on back, hips lifted, heels sliding out — "Hamstring curl"
7. Sitting against a wall, thighs parallel — "Wall sit"
8. Standing on one leg, heel raised — "Calf raise"
9. Seen from the side: lying face down, torso and hips pressed flat to
   the floor, only the straight arms raised a few inches overhead in a
   Y shape. Chest NOT lifted, back NOT arched, arms only — "Prone Y-T-W"

RIGHT COLUMN — 9 cards:
1. Seated, back supported, pressing dumbbells overhead — "Shoulder press"
2. At the top of a pull-up bar, chin above the bar, lowering slowly
   — "Pull-up negatives"
3. Lying under a low bar, body in one straight line, wide overhand grip
   — "Inverted row"
4. Hinged forward, arms wide with dumbbells — "Rear delt fly"
5. Hinged forward, forearm extending back — "Tricep kickback"
6. One card showing a glute bridge figure, with five small labels
   listed beneath it: "Hip circuit — glute bridge · clamshell ·
   1-leg bridge · leg adduction · hip extension"
7. Forearm on thigh, palm up, curling the wrist — "Wrist curl"
8. Forearm on thigh, palm down, curling the wrist — "Reverse wrist curl"
9. Standing on one leg, heel raised — "Calf raise"

Bottom band in violet (#8f7fe8), titled "SPINE + BALANCE — EVERY DAY",
six small figures in a single row:
bird dog · dead bug · side plank · single-leg stand ·
tandem heel-to-toe stance · heel-to-toe walk

Very bottom, a thin red (#e5645e) strip headed "NEVER", one line of
plain text, no figures:
"Barbell squats · Deadlifts · Sit-ups · Russian twists ·
Hanging leg raises · Back extensions"

Style: minimalist flat vector, thin uniform line weight, no shading,
no facial features, no gym background, generous whitespace, clinical
health-app aesthetic. Short labels only — no paragraphs, no watermark,
no logo.
```

> 🔴 **The NEVER strip is text-only and must stay that way.** Do not ask for figures of the banned movements — a picture of a barbell squat on your wall is exactly the thing this poster exists to prevent, and a viewer glances at pictures before reading headers.

> ⚠️ **If the poster comes back too cramped**, the first thing to cut is the MON–SUN weekday strip, not exercises. The rotation is **A · B · A · B alternating regardless of weekday** ([[exercise-plan]]) — a fixed weekday row is decorative and mildly misleading anyway.

---

## OPTION B — Three posters *(fallback only)*

> ⚠️ **Not the default any more (2026-09-06).** Use these only if Option A's figures are unusable after 4–5 attempts. Splitting the content is still the most reliable way to get accurate figures and labels — it is just three sheets on the wall instead of one, which was the stated reason for choosing A.

Splitting the content roughly triples text accuracy, because each image carries a third as many words. Generate all three in one session so the style matches.

> 🔴 **B1 and B2 carry NO sets/reps — deliberate, decided 2026-09-06. Do not add them back.** Two reasons: **(1) They expire.** Adjustable dumbbells arrive **Sep 18 2026**; the plan then resets every lift to 3 × 10 and staggers per-category increases for four weeks. Numbers baked into pixels cannot be edited — a load change means regenerating the whole poster at 3–4 attempts each. **A name-only poster survives every load change for years. (2) Numbers are the highest-garble-risk text on the image**, and dropping them is the mitigation this file already recommended as a fallback. **Making it the default rather than the fallback costs nothing**, because the numbers were never the poster's job.
>
> ✅ **B3 keeps its numbers** — the daily block is bodyweight, the prescriptions don't change on Sep 18, and at 6 cards it is the least garble-prone of the three.

### B1 · Workout A

```
A clean modern fitness infographic poster, vertical 4:5, dark charcoal
background (#15171c), teal (#35c6b4) accent.

Header: "WORKOUT A"

A 3x3 grid of 9 rounded cards. Each card contains a minimalist
flat-vector line-art stick figure of the exercise and its name below in
bold white. No numbers anywhere on the poster.

Cards in order:
1. Push-up, body straight, palms on floor — "Floor push-up"
2. Lying under a low waist-height bar, underhand grip, pulling chest up — "Inverted row"
3. Lying on back, arms wide with dumbbells — "Dumbbell fly"
4. Standing, forearm curling a dumbbell — "Bicep curl"
5. Stepping up onto a knee-high box — "Step-up"
6. Lying on back, hips lifted, heels sliding out — "Hamstring curl"
7. Sitting against a wall, thighs parallel — "Wall sit"
8. Standing on one leg, heel raised — "Calf raise"
9. Seen from the side: lying face down, torso and hips pressed flat to
   the floor, only the straight arms raised a few inches overhead in a
   Y shape. The chest must NOT be lifted and the back must NOT arch —
   this is an arms-only movement — "Prone Y-T-W"

Style: minimalist flat vector, thin uniform line weight, no shading,
no facial features, no gym background, clinical health-app aesthetic,
generous whitespace. Short labels only, no paragraphs, no watermark.
```

> 🔴 **Card 9 is the one to check before printing — see the verification list at the bottom of this file.** "Lying face down, arms lifted" is the textbook description of a **superman**, which is on the [[exercise-plan]] hard-stop list. Image models default to the arched, chest-raised pose because that is what dominates their training data. The wording above is deliberately over-specified (side view, torso flat, arms only, explicit negatives) to fight that default. **It will still fail sometimes. Look at the figure, don't just read the label.**

### B2 · Workout B

```
Same style, layout and colour rules as the Workout A poster, but the
accent colour is amber (#f0a94c) and the header reads "WORKOUT B".

A grid of 13 cards, each with a flat-vector line-art figure and the
exercise name below in bold white. No numbers anywhere on the poster.
1. Seated, back supported, pressing dumbbells overhead — "Shoulder press"
2. At the top of a pull-up bar with chin above it, lowering down slowly — "Pull-up negatives"
3. Lying under a low bar, wide overhand grip, body in one straight line — "Inverted row"
4. Hinged forward, arms wide with dumbbells — "Rear delt fly"
5. Hinged forward, forearm extending back — "Tricep kickback"
6. Lying on back, hips lifted — "Glute bridge"
7. Side-lying, top knee opening — "Clamshell"
8. Hips lifted with one leg extended — "1-leg bridge"
9. Side-lying, bottom leg lifting — "Leg adduction"
10. Face down, one leg lifted — "Hip extension"
11. Forearm on thigh, palm up, curling wrist up — "Wrist curl"
12. Forearm on thigh, palm down, curling wrist up — "Reverse wrist curl"
13. Standing on one leg, heel raised — "Calf raise"
```

> ⚠️ **Card 12 was missing before 2026-09-06** — the reverse wrist curl is supersetted with the wrist curl in the plan, and the poster listed only the first half. Unrelated to the deduplication; caught while syncing.
>
> 🔴 **Card 3 will look identical to Workout A's card 2, and that is acceptable.** Underhand-close vs wide-overhand is a few pixels of hand position in flat line art — no image model will render it reliably. **Don't spend regenerations chasing it.** Per the plan's own 2026-08-28 correction, grip shifts emphasis only 10–20%; it is one exercise with a slight bias, not two. The grip cue lives in [[exercise-plan]], not on the wall.

### B3 · Every day + rules

> 🔴 **This is now the most important poster of the three, not the afterthought it was.** Since core and balance were pulled out of Workouts A and B, **this poster is the only place those six movements are prescribed.** It also runs 7 days a week versus ~1.5 for each workout. **Print this one first.**

```
Same style and layout rules, accent colour violet (#8f7fe8), vertical
4:5, dark charcoal background. Header: "SPINE + BALANCE  ·  5 MIN"
Small subheading under it: "every day"

Red (#e5645e) is used ONLY in the NEVER box at the bottom — nowhere
else on this poster.

Top section, headed "SPINE  ·  3 MIN", 3 cards with flat-vector
line-art figures:
1. On hands and knees, opposite arm and leg extended — "Bird dog  2x10"
2. Lying on back, opposite arm and leg extended — "Dead bug  2x10"
3. Side plank on one forearm — "Side plank  2x30s"

Middle section, headed "BALANCE  ·  2 MIN", 3 cards:
4. Standing balanced on one leg — "Single-leg stand  30s"
5. Standing heel-to-toe, one foot directly in front of the other —
   "Tandem stance  30s"
6. Walking a straight line placing heel against toe — "Heel-to-toe walk  10 steps"

Bottom section: a rounded box with a red border, headed "NEVER",
containing six short lines each with a small cross icon:
"Barbell squats"
"Deadlifts"
"Sit-ups and crunches"
"Russian twists"
"Hanging leg raises"
"Back extensions"

Style: minimalist flat vector, thin uniform line weight, no shading,
no facial features, generous whitespace, clinical health-app aesthetic.
Short labels only, no paragraphs, no watermark.
```

---

## 🔴 Check the figures before you print — added 2026-09-06

> **The real failure mode is not a misspelled label, it is a correct-looking figure showing the wrong movement.** A garbled word is obvious. A wrong figure looks fine and goes on the wall. **Four of these have a failure mode that is itself a restricted movement or a spine risk — check these specifically, every generation:**

| Card (Option A) | What to check | Why it matters |
|---|---|---|
| **Left 9 — Prone Y-T-W** *(B1 · 9)* | 🔴 **Is the chest flat on the floor?** If the torso is lifted or the back is arched, the model drew a **superman**. | Superman is on the [[exercise-plan]] hard-stop list — loaded spinal extension with seronegative spinal inflammation. **Reject and regenerate. Do not print it.** |
| **Left 2 / Right 3 — Inverted row** *(B1 · 2 / B2 · 3)* | Is the body in **one straight line**, braced, heels on the floor? | A figure drawn hinged or bent at the hips reads as a bent-over row — the exact lumbar pattern the SI history rules out. |
| **Left 5 — Step-up** *(B1 · 5)* | Is the box **knee-height, not higher**? | Depth is the variable that caused the free-squat relapse. A hip-height box drawn in error depicts deep hip flexion. |
| **Right 1 — Shoulder press** *(B2 · 1)* | Is the figure **seated with the back supported**? | Standing overhead press with heavy weight is a hard stop. Seated is the whole reason this lift is allowed. |
| **Bottom NEVER strip** | Is it **text only, with no figures**? | A rendered picture of a barbell squat or sit-up on the wall defeats the strip's purpose entirely. |

**If a figure is wrong, regenerate — do not fix it by hand-labelling.** A poster is glanced at, not read; the picture wins over the caption.

## If the text still comes out wrong

1. **Regenerate 3–4 times and pick the best** — text accuracy varies run to run more than any prompt change will fix.
2. **Option A carries no numbers at all**, which already removes most of the risk. If labels still garble, shorten names ("Y-T-W", "1-leg bridge") or drop the MON–SUN strip.
3. **Fall back to the plan itself** — [[exercise-plan]] has the full sets, reps, loads and cues. **The poster answers "which exercises, in what order"; the plan answers "how much."** That split is deliberate — see the note under Option B.

## Related

- [[exercise-plan]] — the source plan these posters are generated from
