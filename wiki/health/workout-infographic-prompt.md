---
tags: [health, fitness, exercise, assets]
created: 2026-08-28
updated: 2026-09-13
status: active
---

# Infographic Image Prompts — Workout Plan

Prompts for generating the workout plan as a **poster image**. Paste into GPT Image / ChatGPT, Ideogram, or Nano Banana / Gemini. **Ideogram and GPT Image handle poster text far better than Midjourney.**

> 📌 **This file holds prompts only.** All reasoning, loads, rules and history live in [[exercise-plan]] and [[exercise-log]]. **Trimmed 2026-09-13** — the decision archaeology and duplicated rationale were removed.

## Before generating

| | |
|---|---|
| **Source of truth for loads** | **[[exercise-log]] → Load Log.** Update it first, then regenerate. **Never edit a weight in this file.** |
| **Regenerate** | **Monthly** for the first ~6 months, then quarterly. A notch changes somewhere every 1–2 weeks — see [[exercise-plan]] |
| **First generation** | **Wait until after session 1.** Ten loads are still marked *"— calibrate"* |
| **Sets and reps** | **Never on the poster.** You count those as you go; the weight is the number you need before touching the dial |
| **Weights** | **kg only, never notch numbers.** "N6" means nothing at a glance and doubles the garble surface |

🔴 **Three pills must keep their suffix — do not shorten to fit:** `2.5 kg — hold 2 weeks` · `4.5 kg — max 5.5` · `5.5 kg — AT CAP`. **A bare number on those three reads as a starting point instead of a ceiling.**

---

## ✅ OPTION A — single poster *(use this one)*

**Aspect ratio 2:3** — thirteen rows of content need the height, and 2:3 prints to A3/A4 without cropping.

```
A clean modern fitness infographic poster, vertical 2:3 portrait, dark
charcoal background (#15171c).

Title at top: "STRENGTH PLAN". Under it, a thin horizontal row of 7
small rounded boxes labeled MON TUE WED THU FRI SAT SUN.

Below that, two columns of rounded cards side by side.
Left column header "WORKOUT A" in teal (#35c6b4).
Right column header "WORKOUT B" in amber (#f0a94c).

Every card holds one flat-vector line-art figure, a short bold white
label beneath it, and — where a weight is given — that weight on its
own line under the label, in an amber (#f0a94c) pill, in bold.
Print the weights exactly as written. Bodyweight exercises get no pill.

LEFT COLUMN — 9 cards:
1. Push-up, body straight, palms on floor — "Floor push-up"
2. Lying under a low waist-height bar, body in one straight line,
   heels on floor, underhand grip, pulling chest to bar — "Inverted row"
3. Lying on back, arms wide with dumbbells — "Dumbbell fly" / "5.5 kg"
4. Standing, forearm curling a dumbbell — "Bicep curl" / "8 kg"
5. Stepping up onto a knee-height box — "Step-up" / "2.5 kg — hold 2 weeks"
6. Lying on back, hips lifted, heels sliding out — "Hamstring curl"
7. Sitting against a wall, thighs parallel, a dumbbell hanging from
   each hand — "Wall sit" / "5.5 kg"
8. Standing on one leg, heel raised, holding a dumbbell — "Calf raise" / "8 kg"
9. Seen from the side: lying face down, torso and hips pressed flat to
   the floor, only the straight arms raised a few inches overhead in a
   Y shape. Chest NOT lifted, back NOT arched, arms only — "Prone Y-T-W"

RIGHT COLUMN — 9 cards:
1. Seated, back supported, pressing dumbbells overhead
   — "Shoulder press" / "6.5 kg"
2. At the top of a pull-up bar, chin above the bar, lowering slowly
   — "Pull-up negatives"
3. Lying under a low bar, body in one straight line, wide overhand grip
   — "Inverted row"
4. Hinged forward, arms wide with dumbbells — "Rear delt fly" / "4.5 kg — max 5.5"
5. Hinged forward, forearm extending back — "Tricep kickback" / "5.5 kg — AT CAP"
6. Lying on back, knees bent, hips lifted, a dumbbell resting across
   the hips — "Glute bridge" / "8 kg"
7. Hips lifted with one leg extended straight — "1-leg bridge" / "4.5 kg"
8. One card with a side-lying figure and three small labels beneath:
   "Hip circuit — clamshell · leg adduction · hip extension"
9. Standing on one leg, heel raised, holding a dumbbell — "Calf raise" / "8 kg"

Below the two columns, a full-width slate-grey band headed "LOADS":
first line, the dial settings in one row of small monospace text:
"2.5  3.5  4.5  5.5  6.5  8  9  10  11.5  13.5  16  18  20.5  22.5  24"
second line, smaller: "Build 8 to 15 reps (to 12 above 8 kg), then up one
setting, reset to 8"
third line in amber: "Step-up: 2 clean weeks before every increase"
fourth line in amber: "Rear delt fly + kickback: never above 5.5"
fifth line, small grey, right-aligned: "Loads as of 13 Sep 2026"

Bottom band in violet (#8f7fe8), titled "SPINE + BALANCE — EVERY DAY",
six small figures in a single row:
bird dog · dead bug · side-lying hip abduction · single-leg stand ·
tandem heel-to-toe stance · heel-to-toe walk

Under that, a thin slate strip headed "EFX / REST DAYS", one line of
plain text, no figures:
"Wrist curl 6.5 kg · Reverse wrist curl 3.5 kg · Dead hang"

Very bottom, a thin red (#e5645e) strip headed "NEVER", one line of
plain text, no figures:
"Barbell squats · Deadlifts · Sit-ups · Russian twists ·
Hanging leg raises · Back extensions"

Style: minimalist flat vector, thin uniform line weight, no shading,
no facial features, no gym background, generous whitespace, clinical
health-app aesthetic. Short labels only — no paragraphs, no watermark,
no logo.
```

> 🔴 **The NEVER strip is text-only and must stay that way.** A picture of a barbell squat on your wall is exactly what this strip exists to prevent — viewers glance at pictures before reading headers.

> ⚠️ **If the poster comes back cramped, cut the MON–SUN strip first, not exercises.** The rotation is A · B · A · B regardless of weekday, so a fixed weekday row is decorative and mildly misleading anyway.

---

## OPTION B — three posters *(fallback only)*

Use only if Option A's figures are unusable after 4–5 attempts. Splitting roughly triples text accuracy. Generate all three in one session so the style matches.

**Add the same amber kg pills and dated footer as Option A**, taking every value from the Load Log in [[exercise-log]].

### B1 · Workout A

```
A clean modern fitness infographic poster, vertical 4:5, dark charcoal
background (#15171c), teal (#35c6b4) accent.

Header: "WORKOUT A"

A 3x3 grid of 9 rounded cards. Each card contains a minimalist
flat-vector line-art stick figure, the exercise name below in bold
white, and where a weight is given, that weight beneath the name in a
small amber pill. No sets or reps anywhere on the poster.

Cards in order:
1. Push-up, body straight, palms on floor — "Floor push-up"
2. Lying under a low waist-height bar, underhand grip, pulling chest up — "Inverted row"
3. Lying on back, arms wide with dumbbells — "Dumbbell fly" / "5.5 kg"
4. Standing, forearm curling a dumbbell — "Bicep curl" / "8 kg"
5. Stepping up onto a knee-high box — "Step-up" / "2.5 kg — hold 2 weeks"
6. Lying on back, hips lifted, heels sliding out — "Hamstring curl"
7. Sitting against a wall, thighs parallel, a dumbbell hanging from
   each hand — "Wall sit" / "5.5 kg"
8. Standing on one leg, heel raised, holding a dumbbell — "Calf raise" / "8 kg"
9. Seen from the side: lying face down, torso and hips pressed flat to
   the floor, only the straight arms raised a few inches overhead in a
   Y shape. The chest must NOT be lifted and the back must NOT arch —
   this is an arms-only movement — "Prone Y-T-W"

Style: minimalist flat vector, thin uniform line weight, no shading,
no facial features, no gym background, clinical health-app aesthetic,
generous whitespace. Short labels only, no paragraphs, no watermark.
```

### B2 · Workout B

```
Same style, layout and colour rules as the Workout A poster, but the
accent colour is amber (#f0a94c) and the header reads "WORKOUT B".

A grid of 11 cards, each with a flat-vector line-art figure, the
exercise name below in bold white, and where a weight is given, that
weight beneath the name in a small pill. No sets or reps.

1. Seated, back supported, pressing dumbbells overhead — "Shoulder press" / "6.5 kg"
2. At the top of a pull-up bar with chin above it, lowering down slowly — "Pull-up negatives"
3. Lying under a low bar, wide overhand grip, body in one straight line — "Inverted row"
4. Hinged forward, arms wide with dumbbells — "Rear delt fly" / "4.5 kg — max 5.5"
5. Hinged forward, forearm extending back — "Tricep kickback" / "5.5 kg — AT CAP"
6. Lying on back, knees bent, hips lifted, a dumbbell across the hips
   — "Glute bridge" / "8 kg"
7. Hips lifted with one leg extended — "1-leg bridge" / "4.5 kg"
8. Side-lying, top knee opening — "Clamshell"
9. Side-lying, bottom leg lifting — "Leg adduction"
10. Face down, one leg lifted — "Hip extension"
11. Standing on one leg, heel raised, holding a dumbbell — "Calf raise" / "8 kg"
```

> 🔴 **B2 card 3 will look identical to B1 card 2, and that is acceptable.** Underhand-close vs wide-overhand is a few pixels of hand position in flat line art. **Don't spend regenerations chasing it** — the grip cue lives in [[exercise-plan]], not on the wall.

### B3 · Every day + rules

> 🔴 **Print this one first.** It is the only place the six daily movements are prescribed, and it runs 7 days a week versus ~1.5 for each workout.

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
3. Lying on side, top leg raised straight — "Side-lying hip abduction  2x15"

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

> ✅ **B3 keeps its sets/reps** — the daily block is bodyweight, the prescriptions don't change, and at 6 cards it is the least garble-prone poster.

---

## 🔴 Check before you print

> **The real failure mode is a correct-looking figure showing the wrong movement.** A garbled word is obvious; a wrong figure looks fine and goes on the wall.

| Check | Failure it catches |
|---|---|
| 🔴🔴 **Every kg pill, digit by digit against the Load Log** | **"25 kg" instead of "2.5 kg" under the step-up is a spine injury on a wall, and it looks completely normal.** Do not skim |
| 🔴 **The three suffixes: "— hold 2 weeks", "— max 5.5", "— AT CAP"** | Models truncate long labels. Dropped suffix = a ceiling now reads as a starting point |
| 🔴 **Prone Y-T-W — chest flat on the floor?** | A lifted torso means the model drew a **superman** — a hard-stop movement. Reject, don't print |
| **Inverted row — body in one straight line?** | Drawn hinged, it reads as a bent-over row — the lumbar pattern the SI history rules out |
| **Step-up — box at knee height, not higher?** | Depth caused the free-squat relapse |
| **Shoulder press — seated, back supported?** | Standing overhead press is a hard stop; seated is why the lift is allowed |
| **Glute bridge — dumbbell across the hips?** | Held at the chest or overhead teaches the wrong setup |
| **NEVER strip — text only, no figures?** | A rendered barbell squat defeats the strip entirely |
| **LOADS band — all 15 values, ascending?** | If it garbles, cut the band rather than print a wrong ladder |
| **Dated footer present?** | Without it, a stale poster is indistinguishable from a current one |

**If a figure is wrong, regenerate — do not fix it by hand-labelling.** A poster is glanced at, not read; the picture wins over the caption.

## If the text still comes out wrong

1. **Regenerate 3–4 times and pick the best** — run-to-run variance beats any prompt change.
2. **Shorten labels** ("Y-T-W", "1-leg bridge") or drop the MON–SUN strip.
3. **Cut the LOADS band** before cutting the kg pills — the ladder is also in [[exercise-plan]].
4. **Fall back to the write-in version below** if numbers keep garbling.

---

## Alternative — blank write-in boxes instead of printed kg

Never goes stale. **Switch to this if monthly regeneration becomes a chore** — that is the most likely way the printed version fails.

Take the Option A prompt and replace the pill instruction with:

```
Cards that would carry a weight instead show, directly under the label,
a small empty rounded rectangle outlined in mid-grey with the text
"___ kg" inside it in light grey — an empty write-in box to be filled
by hand. The box is empty. Do not print any weight value inside it.
```

Fill the boxes in pencil or dry-erase from the Load Log. **Keep the LOADS band, both amber rules and the dated footer.** 🔴 **Hand-write the three suffixes too** — a bare number on step-up, rear delt fly and kickback reads as a starting point rather than a ceiling.

⚠️ **Check the boxes came back EMPTY.** Image models fill blanks, and an invented "10 kg" under the step-up is worse than no poster.

## Related

- [[exercise-plan]] — the source plan, all loads, rules and rationale
- [[exercise-log]] — Load Log, the source of truth for every kg value here
