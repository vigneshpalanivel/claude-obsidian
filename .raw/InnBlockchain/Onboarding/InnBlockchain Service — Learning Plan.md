---
company:
  - innblockchain
type: onboarding
scope: service-side-only
audience: incoming Sales lead
rev: 3
last_revised: 2026-10-01
ramp_length: 6 weeks
learning_hours_total: ~55
---

# InnBlockchain Service — Learning Plan

> [!INFO] What this is
> A sequenced reading-and-practice plan to get you useful on InnBlockchain's **Service** business. It is scoped deliberately: Service only, no Product (the productized clone-script line is a different ICP, different buyer, different price band — ignore it entirely for now).
>
> Everything referenced here lives in the `sales-marketing` repo under `Service/`. Paths are given so you can go straight to the file. You don't need to read any file end-to-end on the first pass — read the section named, do the self-check, move on.
>
> **Time estimates are reading-and-practice hours, not elapsed days.** From week 2 onward you are doing real work alongside the learning, so budget roughly **8–10 learning hours per week** and expect the rest of your time to go on the CRM, calls and forecast.

---

## Master schedule

| # | Topic | When | Learning hours |
|---|---|---|---|
| 3 | Stage 0 — Vocabulary | Week 1, days 1–2 | ~10 |
| 4 | Stage 1 — The classification rule | Week 1, days 3–5 | ~8 |
| 8 | Hard rules — memorise | Week 1, day 5 | ~1 |
| 9 | Personas and role codes | Week 1, day 5 | ~1 |
| 6 | Stage 3 — The sales system | Week 2 | ~7 reading + 6–8 on the CRM audit |
| 5 | Stage 2 — Regime map | Weeks 2–3 | ~9 |
| 7 | Stage 4 — Deal shapes, procurement, who's out of scope | Weeks 3–4 | ~6 |
| — | Discovery calls as note-taker (10 calls) | Weeks 3–4 | ~11 |
| — | Own the forecast and Friday review | Week 5 | — |
| — | Week-6 self-assessment with Vignesh | Week 6 | ~1 |
| | | **Total** | **~55 hrs over 6 weeks** |

Note the ordering: **Stage 3 comes before Stage 2.** You can run the sales system in week 2 with no blockchain knowledge at all, so it starts earlier and the regime map runs alongside it.

---

## 1. What the business actually sells

⏱ *Read this section once — 20 minutes. Day 1.*

InnBlockchain builds **blockchain engineering for regulated European financial companies and for asset owners who want to put real assets on-chain.** Two kinds of buyer:

| Buyer | Who they are | What they're afraid of |
|---|---|---|
| **Crypto Native** *(Segment 1 only)* | A founder who owns a real asset — a real-estate developer, a vehicle-fleet owner, a commodity producer — who wants to turn that asset into tradeable digital units. Often **not technical at all.** | That one flaw in the code compromises real ownership rights. And that a regulator appears they didn't see coming. |
| **FinTech (WealthTech)** | A licensed European wealth platform, asset manager, or securities-token platform. Either **50–500 employees with $10M+ revenue**, or **10–50 employees with $2M+ raised** — both shapes qualify. Already regulated, already has engineers — just not blockchain engineers. | A security breach, a failed audit, or their compliance officer blocking the whole thing late. |

The asset classes in current focus: **real estate, vehicles, commodities, private credit, art.**

> **A warning about the Crypto Native document.** It describes **ten** segments — DeFi protocols, wallets, NFT platforms, token launches, L2 infrastructure, Web3 gaming, AI-and-crypto, and others. **Only Segment 1 (asset tokenization) is in scope right now.** Segments 2–10 belong to later phases. When you open that file, read Segment 1 and ignore the other nine; they will otherwise pull you into a completely different business.

The sale is **not** "blockchain is exciting." The sale is "you have a regulatory and security problem, we're the team that doesn't create a new one." That is why the learning order below puts regulation before technology.

---

## 2. Who does what — where your work starts and stops

⏱ *20 minutes to read. One conversation to confirm — day 1 or 2, see the note at the end.*

You are joining a small team. Knowing the boundaries on day one saves a month of friction.

| Who | What they hold |
|---|---|
| **Vignesh** | Pricing, every contract signature, and **every regulatory answer**. Also: approves any new outreach wording before it sends, joins FinTech deals above $100k, and takes any request to "speak to the founder." |
| **Vasanth** *(SP — sales person)* | **All outbound.** Connection requests, DM sequences, strategic commenting — sent first-person from Vignesh's own LinkedIn profile, which Vasanth operates. He carries his deals through to close (Vignesh still signs). This stays his. |
| **You** | The system around the selling: CRM correctness, stage discipline, the weekly forecast, discovery-call records, scope triage on incoming requests, and the handover from a won deal into delivery. |

Two things to be clear about from the start, because they are easy to assume otherwise:

- **You do not take over Vasanth's outbound,** and you do not send messages from Vignesh's LinkedIn profile. That profile carries warm outreach, cold outreach and recommendation requests on one account; extra hands on it risk the whole surface being restricted.
- **You are not the escalation point for regulatory questions.** Those go to Vignesh whether they come from you or from Vasanth. Your job is to recognise one and route it the same day.

> **Confirm this in week 1 — a real handover, not an assumption.** Vasanth's role sheet in the team repo lists CRM ownership, pipeline-stage enforcement and the Friday pipeline review as *his*, and those sheets are **not being rewritten** — so expect them to keep saying that. The written docs are the team's operating reference; this handover is a verbal agreement on top of them.
>
> That makes the conversation the only record, so have it properly: sit down with Vignesh and Vasanth in your first few days and agree out loud which of the three moves to you and which Vasanth keeps at deal level. Write the outcome down for yourself. **Do not start reorganising the CRM before that conversation has happened** — it is his by the documentation until the three of you have said otherwise.

---

## 3. Stage 0 — Vocabulary

⏱ **~10 hours · week 1, days 1–2**

**Read:** `Service/Content/blockchain-glossary.md`

It's written for someone with your exact starting point — nine groups, plain English, no code.

| What | Time |
|---|---|
| Groups 1–6 — basics, on-chain/off-chain, smart contracts, tokens, RWA mechanics, compliance-in-contract | ~4 hrs |
| **Group 9 — "Where EU rules plug in."** Read this before groups 7–8. It is the most important section in the file for your job and the plain-English version of Stages 1 and 2 below | ~3 hrs |
| Practising the self-check below out loud | ~2 hrs |
| Groups 7–8 — wallets, infrastructure. Second pass, lower priority | ~1 hr |

**Self-check — explain each of these out loud, no notes:**

- On-chain vs off-chain, and why KYC is done off-chain but only the pass/fail result goes on-chain
- A security token vs a utility token, and why the difference is legal rather than technical
- What a whitelist (allowlist) does, and what a transfer-restriction module does
- What an SPV is, and what a "legal wrapper" is — and why a token without one is worthless
- Why "immutable" is both the selling point and the problem

**What to skip forever:** Solidity, writing contracts, reading contract code. You will never need it. If a conversation goes there, it goes to Vignesh or the dev team.

---

## 4. Stage 1 — The one distinction the company is built on

⏱ **~8 hours · week 1, days 3–5**

This is the highest-cost mistake available to you, so it gets its own stage.

**The rule:** a token that gives someone **ownership of, or a claim on, a real asset or its issuer** is a **transferable security** under European securities law (MiFID II). It is *not* a "crypto-asset" under MiCA. MiCA Article 2(4) explicitly excludes financial instruments from its scope.

### Two things wear the name "MiFID II" — keep them apart

*⏱ ~2 hrs, including talking it through with Vignesh*

- **MiFID II classification** — the test that decides whether a token *is* a transferable security. This applies to **every client's token**, whether or not the client holds any licence at all. It is the reason the Prospectus Regulation and MAR apply downstream. **This is the part you need.**
- **MiFID II authorisation** — the licence a firm needs in order to provide investment services. Most of our asset-owner clients never need it. Licensed wealth platforms and asset managers on the FinTech side often already hold one. **This is not your concern.**

You will never be asked to assess either. You need to know the classification exists, and what it sets off.

**Why it matters commercially — three consequences:**

1. The offering document is a **prospectus**, not a MiCA white paper.
2. At the national regulator, the file goes to the **securities and markets team**, not the MiCA/crypto team.
3. **Only if** the client runs their own trading and settlement layer, the infrastructure path is the **DLT Pilot Regime** rather than a MiCA CASP licence. Most clients don't run their own venue — so don't lead with this one.

**Why it matters in a conversation:** if you say "MiCA" to an asset-tokenization prospect, a competent compliance officer concludes within thirty seconds that you don't understand their regime, and the deal is over. It is the single most common way credibility is lost on call one.

**Read:**

| What | Time |
|---|---|
| `Service/Content/EU Compliance/Tokenized-Securities-EU-Compliance-Landscape.md` — the classification test | ~3 hrs |
| `Service/ICP/ICP - FinTech.md` → Pain Point 4, the "WealthTech variant" paragraph | ~1 hr |
| Issuer lane vs venue lane, below | ~1 hr |
| Self-check with Vignesh | ~30 min |

**Second distinction, same stage — issuer lane vs venue lane:**

Most prospects **issue** their tokens onto somebody else's trading platform. A few **run their own** trading and settlement layer. Those are two different services and two different conversations, and the issuer lane is where our current focus sits. The qualifying question, almost word for word from the ICP doc:

> *"Are you issuing onto someone else's venue, or running the trading and settlement layer yourselves?"*

Default assumption: issuer. Confirm it, don't assume the venue build.

**Self-check:** state the classification rule, the MiCA boundary, and its consequences in two sentences, cold, to Vignesh. Until you can, don't speak to a prospect.

---

## 5. Stage 2 — Regime map: recognition, not judgement

⏱ **~9 hours · weeks 2–3, running alongside Stage 3**

You need to **recognise** which rulebook applies and **which document to send**. You do not need to interpret the rulebook. That line is firm — the same rule applies to Vasanth: *never make a regulatory judgement yourself; escalate same-day.*

*⏱ ~4 hrs on the table below*

| Regime | What it governs | When it comes up |
|---|---|---|
| **MiFID II** | Classification — is this token a transferable security? | Every asset-tokenization prospect. The gateway test everything else depends on. |
| **Prospectus Regulation** | The offering document for raising from investors | Any prospect actually offering to the public |
| **MAR** (Market Abuse Regulation) | Insider dealing, disclosure | From the moment admission to trading is *applied for* |
| **DORA** | Operational resilience, and **vendor risk for suppliers like us** | Every licensed EU prospect, by default |
| **GDPR** | Personal data — relevant because identity data and blockchains interact badly | Vendor risk conversations |
| **DLT Pilot Regime** | Exemptions for running your own on-chain trading/settlement venue | Venue lane only — secondary, don't lead with it |
| **MiCA** | Crypto-assets that are *not* financial instruments | Rarely in our segment. Know the boundary so you can say precisely where it doesn't apply. |

**Then read:**

| What | Time |
|---|---|
| `Service/Content/EU Compliance/EU-Compliance-Landscape.md` — which regime maps to which segment | ~2 hrs |
| `Service/Sales/DORA Article 30 Vendor Readiness Pack.md` — sections 1 and 7 only | ~2 hrs |
| Self-check below | ~1 hr |

**The DORA question to memorise**, because it is both a qualification gate and a credibility signal — almost no vendor asks it:

> *"Will this engagement be classified as supporting a critical or important function in your DORA framework?"*

Record the answer **and their reasoning**. It decides how heavy the contract gets, and it has to be flagged early rather than discovered when the proposal is already written.

**Also useful:** a prospect may ask whether we are a "CTPP." The answer is **no, and that is the correct answer** — we are an ICT third-party service provider. Say that one sentence and nothing more; anything further goes to Vignesh.

**Do NOT read** the 137 regulation checklist files in `Service/Content/EU Compliance/Checklist/`. That library is Vignesh's working reference, not onboarding material.

**Self-check:** given a one-paragraph prospect description, name the segment, name the primary regime, name which brief to send — and correctly say "escalate" for anything past that.

---

## 6. Stage 3 — The sales system

⏱ **~7 hours reading + 6–8 hours on the audit · week 2**

This is where your business-analysis background transfers directly, with no blockchain knowledge required. It starts before Stage 2 for exactly that reason — you can be productive here in week 2 while the regime map is still settling.

**Read, in this order:**

| # | What | Time |
|---|---|---|
| 1 | `Service/Sales/Pipeline Stage Exit Criteria.md` — the stage gates. Every transition is all-conditions-must-be-true. Note that "Qualified" requires a *documented regulatory or technical specifics signal* — vague interest is not qualified | ~1.5 hrs |
| 2 | `Service/Sales/Discovery Call Master Sequence.md` — the 20-step, 5-phase call framework. Prep → opening → discovery → qualification → post-call. First 20 minutes are listening, not pitching | ~2 hrs |
| 3 | `Service/Shared/Delegated-Work Spot-Check Protocol.md` — how review rates ramp down as a new person proves out. This also describes *your own* first four weeks | ~45 min |
| 4 | `Service/Shared/Analytics Measurement Framework.md` + the "Funnel Math & KPIs" section of `Service/Playbook/Phase 1/Execution Playbook.md` — how connection requests turn into closed projects, and what each conversion rate is assumed to be | ~2.5 hrs |

### The stale-pipeline rules — your weekly job, so learn them properly

*⏱ ~1 hr, part of item 1 above*

A pipeline is only honest if things leave it. Four rules:

- **Any stage → Parked** when: 21 days of no response after the fifth message, **or** an explicit "not now" with no near-term timeline, **or** a disqualifying signal surfaces.
- **Parked → re-engagement** needs **60 days minimum** elapsed *and* a new buying trigger *and* a fresh opening message — never a continuation of the old thread.
- **Stale "Call Booked"** — booked but not completed within **7 days** gets a follow-up sequence; at **14 days** it moves to Parked.
- **Every transition gets a logged reason.** Which signal triggered it. No exceptions — this is what makes the monthly pattern review possible.

**Your first deliverable, week 2:** audit the CRM against the exit criteria and flag every stage transition that has no documented signal behind it. You can do this on day eight with zero blockchain knowledge, and it is genuinely useful. ⏱ *6–8 hrs depending on pipeline size.*

**Also worth knowing:** the funnel numbers in the playbook are *directional assumptions*, not validated facts, and the close rate per discovery call is explicitly flagged as unvalidated. Treat them as hypotheses to test, which is a BA instinct you already have.

---

## 7. Stage 4 — Deal shapes, procurement, and who's out of scope

⏱ **~6 hours · weeks 3–4**

### Deal shapes you need to recognise

*⏱ ~2 hrs*

| Shape | Floor | Delivery | What it is |
|---|---|---|---|
| White-label / productized | $20k+ flat | 6–10 weeks | Audited contracts + a working UI, client owns the code outright. Light compliance hooks only. |
| Custom build | $50k+ | Longer | Everything the white-label tier explicitly excludes — full vendor risk pack, certification prep, regulator-grade audit reporting, per-jurisdiction documentation |

**The routing rule that protects margin:** the moment a buyer asks for a vendor risk pack, certification prep, regulator-grade reporting, or bespoke jurisdiction documentation — that is **custom build, not white-label.** Delivering that depth at the white-label floor loses money. The white-label tier has a ≥40% gross-margin target that only holds with tight scope discipline. This is the single most valuable thing your experience can defend.

### Who is out of scope — learn this before you touch the pipeline

*⏱ ~2 hrs*

You cannot forecast honestly without knowing what shouldn't be in the pipeline at all.

**Geography.** The EU is the **sole outbound focus until five EU projects have closed.** The UK, US, MENA and SEA are all "Watch" — real markets, deliberately not worked yet, each needing its own compliance brief before anyone approaches them. A US prospect in the pipeline is not an early-stage opportunity; it's out of scope. Flag it, don't forecast it.

**Budget floor.** $20k+ earmarked is the minimum. Below that it isn't a small deal, it's a disqualification. *(This floor is itself flagged in the ICP as an assumption pending validation against the first ten closed deals — so it may move. Check before quoting it as fixed.)*

**Hard disqualifiers.** Unfunded founders with only an idea · zero or sub-$20k budget · consumer crypto retail apps · crypto-native exchanges and DeFi-native startups with no existing traditional financial-services business.

**Time-wasters to recognise but not chase.** Concept-stage founders wanting free brainstorming · "blockchain tourists" with no business case · anyone "just exploring" with no timeline.

### Procurement timing — this drives forecast dates

*⏱ ~1 hr*

| Who signs | Threshold | Add to timeline |
|---|---|---|
| CEO/CTO discretionary | under $75k | 1–2 weeks |
| CFO sign-off required | $75k+ | 4–6 weeks, plus a business case document |
| Board/investor visibility | large or first-ever blockchain engagement | factor into the close date |

Typical cycle for the primary segment: **60–90 days.**

### Where prices and dates may and may not appear

*⏱ ~30 min*

- **Never** in a published or gated marketing asset — a landing page, a downloadable brief, a LinkedIn post. Those state what cost *depends on*, and make the qualifying questions the route to an answer.
- **Yes** in client-specific documents — a proposal or a scope document carries figures and dates, because that is their job.
- The pricing **conversation** is Vignesh's, always, regardless of which document it lands in.

---

## 8. Hard rules — memorise before your first client contact

⏱ **~1 hour · week 1, day 5. Do not defer this one.**

Taken from Vasanth's rule set. These never relax, for either of you:

- **Never frame an asset-tokenization prospect with MiCA.** The framing is MiFID II, Prospectus and MAR — plus the DLT Pilot Regime *only* if they run their own venue.
- **If a compliance officer asks "can I speak to the founder?" — always escalate to Vignesh.** Never shield that request.
- **Never advance a CRM stage without a documented signal,** and always log which signal triggered it.
- **First 20 minutes of a discovery call: listen and qualify. Do not pitch.**
- **Any new outreach wording, and any message making a regulatory claim, needs Vignesh's sign-off before it sends.** Already-approved templates go out on their own.
- **Deal value above $100k on a FinTech prospect → escalate for a joint pitch.**
- **A prospect who insists they need MiCA for asset tokenization → escalate same-day.** Don't argue it yourself.
- **Never make a regulatory judgement yourself.** Ever. Recognise, route, escalate.

---

## 9. Who the people in the documents are

⏱ **~1 hour · week 1, day 5**

The docs refer to buyer archetypes by first name. They are personas, not real people:

| Name | Role | What they care about |
|---|---|---|
| **Strategic Sam** | CEO or Chief Product Officer at a FinTech | Launching on time, board confidence, margin. Commercially sharp, not deeply technical. He opens the conversation. |
| **Technical Tom** | CTO or VP Engineering | Code quality, security, not stretching his team. Holds a technical veto. |
| **Compliance Carol** | Chief Compliance Officer | Approving a vendor without creating regulatory exposure. **Not an economic buyer — a veto holder.** Usually surfaces late, which is when she's most dangerous. |
| **Founding Felix** | Two versions, and only one is ours right now. **RWA Felix** — an asset owner (real-estate developer, fleet owner, commodity producer) building a tokenization platform, often not technical. **DeFi Felix** — a technical protocol founder; later phases, not yours. | RWA Felix wants the first asset tokenized, legally enforceable, and investors onboarded. |

**Role codes:** SP = sales person · MP = marketing person · CW = content writer.

**The question that surfaces Carol before she becomes a problem, asked on call one:** *"Who handles vendor risk and compliance approval in your organisation?"*

---

## 10. The first six weeks, day by day

| When | What | Hours on learning |
|---|---|---|
| **W1 · Mon–Tue** | §1 business shape · §2 boundaries (and the handover conversation) · Stage 0 glossary groups 1–6 then group 9 | ~10 |
| **W1 · Wed–Fri** | Stage 1 classification rule · classification-vs-authorisation · issuer vs venue lane · self-check with Vignesh | ~8 |
| **W1 · Fri** | §8 hard rules memorised · §9 personas. **Read-only week: no messages sent, no calls joined** | ~2 |
| **W2** | Stage 3 — take over CRM and pipeline hygiene (once the handover is agreed). Deliver the exit-criteria audit. Stage 2 regime map begins in parallel | ~7 + 6–8 on the audit |
| **W3** | Stage 2 regime map finishes · Stage 4 begins · first discovery calls as note-taker | ~8 |
| **W4** | Stage 4 finishes — out-of-scope rules and procurement timing. Discovery calls continue, target ten total by end of W4 | ~7 |
| **W5** | Own the Friday pipeline review and produce the forecast yourself. Write the scope note for any deal that has been won | ~2 |
| **W6** | Self-assess against the list below with Vignesh. Agree what, if anything, becomes client-facing next | ~1 |
| **After** | Any client-facing conversation, by agreement per prospect. Regulatory questions still route to Vignesh — permanently, not temporarily | — |

Taking notes on ten real discovery calls will teach you more than any document here. The documents exist so the notes make sense.

### What good looks like at week 6

Six checks. These are the standard, not aspirations:

1. You can state the classification rule and the MiCA boundary cold, without notes.
2. The CRM has **zero** stage transitions without a documented signal behind them.
3. You produce a weekly forecast that Vignesh reads rather than rebuilds.
4. Ten discovery calls have written records, each one following the 20-step sequence.
5. Given three sample scope requests, you route each correctly between white-label and custom build — and you can say why. *(Tested on samples, not on live deals: six weeks may not produce a real one, and that shouldn't count against you.)*
6. Every regulatory question you've met went to Vignesh the same day, and none of them got answered by you.

If 1 and 2 are true and the rest aren't yet, you're on track. If 2 isn't true, nothing else counts.

---

## 11. Reading list in one place

**Read first, in order:**

| # | File | Time |
|---|---|---|
| 1 | `Service/Content/blockchain-glossary.md` — groups 1–6, then **group 9** | ~7 hrs |
| 2 | `Service/Content/EU Compliance/Tokenized-Securities-EU-Compliance-Landscape.md` | ~3 hrs |
| 3 | `Service/ICP/ICP - FinTech.md` — executive summary, qualifying criteria, Pain Point 4, Segment 1, persona cards | ~3 hrs |
| 4 | `Service/ICP/ICP - Crypto Native.md` — executive summary and **Segment 1 only** (ignore segments 2–10) | ~1.5 hrs |
| 5 | `Service/Sales/Pipeline Stage Exit Criteria.md` | ~1.5 hrs |
| 6 | `Service/Sales/Discovery Call Master Sequence.md` | ~2 hrs |

**Reference as needed:**
- `Service/Content/EU Compliance/EU-Compliance-Landscape.md` — which regime applies to which segment
- `Service/Sales/DORA Article 30 Vendor Readiness Pack.md` — sections 1 and 7
- `Service/Shared/Analytics Measurement Framework.md`
- `Service/Shared/Delegated-Work Spot-Check Protocol.md`
- `Service/Playbook/Phase 1/Execution Playbook.md` — the master operations document. Large. Use the per-role table and Funnel Math sections; don't read it cover to cover.
- `Service/LinkedIn/Outreach Startegy Phase 1/Phase 1 Regulator & Register Site List.md` — where the prospect list comes from. Vasanth's sourcing reference; useful context for you, not required reading.

**Don't read yet:** the `Checklist/` regulation library, anything under `Product/`, the smart-contract design documents, the SEO and content-production workstreams.
