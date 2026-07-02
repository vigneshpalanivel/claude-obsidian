---
type: concept
title: "RWA / STO EU Compliance Landscape"
created: 2026-07-02
updated: 2026-07-02
tags:
  - EU
  - fintech
  - compliance
  - regulation
  - RWA
  - STO
  - tokenization
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[MiFID-II]]"
  - "[[MiFID-III]]"
  - "[[Prospectus-Regulation]]"
  - "[[MAR-Regulation]]"
  - "[[EU-Listing-Act]]"
  - "[[ELTIF-2.0]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[ESMA]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/sales-marketing/Service/Content/EU Compliance/RWA-STO-EU-Compliance-Landscape.md"
    hash: "3a5514933436b5db63867659c0bfb1b9"
    registered: 2026-07-02
    last_synced: 2026-07-02
    derived_from: split out of EU-Compliance-Landscape.md on 2026-07-02
    purpose: "Standalone InnBlockchain-branded client-shareable artifact for the RWA/STO regulatory lane (MiFID II-primary, not MiCA). Split out of EU-Compliance-Landscape.md 2026-07-02: carries all RWA/STO-specific content (Token Classification / RWA≠MiCA, Three Roles Issuer-Venue-Dealer/SI, Fund Classification UCITS→AIF→ELTIF, MiFID II/III + AIFMD/UCITS + ELTIF 2.0 + Prospectus + MAR + EU Listing Act + DLT Pilot regulations, per-segment obligations for Seg 1 + WealthTech, cross-cutting DORA/AML/eIDAS/GDPR/AI Act/MiCA callout, checklist links). Body content kept in sync with this wiki concept. 2026-07-02 correction: added Cross-cutting regimes callout + Compliance by Segment section (Seg 1 + WealthTech full obligation lists) after the initial split dropped the per-segment DORA/AML/eIDAS/GDPR/AI Act detail."
---

# RWA / STO EU Compliance Landscape

RWA tokenization and Security Token Offerings sit in a distinct regulatory lane from general fintech — **MiFID II is the primary framework, not MiCA** — and the compliance burden compounds with each additional role a platform takes on (issuer → venue → dealer). This document covers EU compliance specific to RWA/STO platforms across both relevant segments — **Crypto Native Seg 1 (RWA Tokenization)** and **FinTech WealthTech (RWA / STO / Tokenized Securities)**. For payments, crypto-asset services (Seg 2-10), lending, and other FinTech segments, see [[EU-Fintech-Compliance-Landscape]].

---

## Token Classification — The First Question

> [!WARNING] RWA ≠ MiCA — Common Misframe
> MiCA does not "cover" RWA tokenization by default. Token classification is mutually exclusive between MiFID II and MiCA (Article 2(4)):
> - **Ownership-conferring token** (fractional real estate, tokenized bond/equity, revenue claim) → **MiFID II financial instrument**, regardless of whether yield is distributed. Path: Prospectus Regulation + DLT Pilot Regime + DORA.
> - **Value-referencing token without ownership** (basket-pegged, asset-backed stable value) → **MiCA Asset-Referenced Token (ART)**. Different category, narrow use case.
> - **CASP authorization under MiCA** is a *service-level* license (custody, trading, exchange) and can still apply to a firm whose primary token is MiFID-classified — but only if that firm also services non-MiFID crypto-assets.
>
> Selling MiCA-as-RWA-cover to a Seg 1 prospect is a credibility risk: wrong regulatory regime (MiFID II under prospectus + ESMA convergence vs MiCA white-paper regime — both supervised by the same national NCAs, but the substantive obligations diverge), wrong offering document (prospectus vs white paper), wrong infrastructure path (DLT Pilot Regime vs CASP authorization).

---

## Three Roles: Issuer / Venue Operator / Dealer (SI)

> [!info] Three Roles in Tokenized Securities — Issuer / Venue Operator / Dealer-Advisor
> A platform working with tokenized securities can play one role, two roles, or all three at once. Each role triggers a different regulatory regime, and the compliance burden compounds when roles stack.
>
> **Issuer** — The entity that creates the financial instrument and offers it to investors. Mints the token. Files the offering document.
> - Primary obligations: **Prospectus Regulation** + [[MAR-Regulation|**MAR**]] (inside-information disclosure once admitted to trading — Listing Act narrowed Art 17 protracted-process disclosure to final-event-only from 4 Dec 2024 and raised the PDMR threshold to €20k) + national corporate disclosure rules.
> - Does NOT trigger MiFID II investment-firm authorization, MiFIR transaction reporting, or DLT Pilot Regime by itself.
> - **MiFID III: does not apply.** Pure issuers have no trading venue, no order routing, and no SI obligations — all three MiFID III changes (PFOF ban, consolidated tape, expanded reporting) are aimed at intermediaries and venues, not issuers.
>
> **Venue Operator** — The entity that runs an investor-to-investor trading system in the financial instrument. Operates the order book. Matches buyers and sellers under non-discretionary rules. Publishes prices.
> - Triggered by MiFID II Art. 4(1)(22) MTF definition: multiple **third-party** buying and selling interests brought together in a system that results in a contract. "Third party" means parties other than the platform operator. The trigger is **investor-to-investor matching**, not whether you list assets from third-party issuers. Selling only your own assets to investors does NOT make you a venue. The moment investors can trade with each other on your platform — even in tokens you originally minted — you become a venue operator.
> - Primary obligations: **MiFID II venue authorization** + **DLT Pilot Regime license** (DLT MTF / SS / TSS depending on scope) + **MiFIR Arts 3–23** (pre/post-trade transparency) + **MiFIR Art. 26** (transaction reporting on every executed trade) + **DORA** + **AMLR**.
> - **MiFID III additions (on top of MiFID II):** consolidated tape — venue must report all executed trades to the EU consolidated tape provider (**Jun 2026**) · expanded MiFIR Art. 26 transaction reporting fields — more data per trade report (**Apr 2026**) · pre-trade transparency narrowing — fewer waiver exemptions under amended MiFIR Art. 25, more quotes must be made public (**Sep 2025 / Mar 2026**). PFOF ban does NOT apply to the venue role — it targets broker order-routing, not the venue itself.
>
> **Dealer / Advisor** — The entity that takes active positions in the financial instrument, takes the other side of every trade on its own account, or gives advice about it.
> - Triggered by any of: platform takes the other side of every trade from its own treasury (investors never trade with each other — they each only trade with the platform — this is the **Systematic Internaliser (SI)** regime under MiFID II Art. 4(1)(20); an SI executes client orders against its own capital on an organised, frequent, systematic, and substantial basis *outside* a regulated venue; all four ESMA conditions must be met: (1) on own account, (2) organised process, (3) frequent + systematic above ESMA thresholds per instrument, (4) substantial relative to total market turnover; key distinction from a DLT MTF: on an MTF investors match *with each other* and the platform runs the order book — on an SI the platform's own capital is the permanent counterparty on every trade) · buying back own tokens at quoted prices · providing market-making or liquidity provision · giving personalized recommendations to investors · managing investor portfolios on a discretionary basis · executing client orders against external venues or own book · underwriting or placing tokens for other issuers.
> - Primary obligations: **MiFID II investment-firm authorization** (with the specific permissions depending on which services are provided) + **MiFIR Art. 26** transaction reporting on every executed trade + **MiFIR Art. 27** best execution + **MiFID II Arts 24–25** disclosure and suitability + **IFR/IFD** capital adequacy + **product governance** (Art. 16(3)). Systematic Internalisers additionally owe pre-trade quoting and transparency under **MiFIR Arts 14–20** (SI-specific regime — narrower than the full Arts 3–23 venue regime).
> - **MiFID III additions (on top of MiFID II):** PFOF ban — if the dealer / SI receives payment from market-makers in exchange for routing client orders to them, that practice is prohibited (**Jun 2026**) · expanded MiFIR Art. 26 transaction reporting fields (**Apr 2026**). SI pre-trade quoting obligations (MiFIR Arts 14–20) are unchanged by MiFID III. Consolidated tape: SI trade data feeds into the tape indirectly via Art. 26 reporting — no separate tape submission obligation for SIs.
>
> **Routing test for first intake:**
> 1. Can investors trade with each other on the platform (investor-to-investor matching)? → Yes adds Venue Operator role.
> 2. Does the platform take the other side of trades from its own treasury, buy back tokens at quoted prices, or post bid/ask quotes on own account? → Yes adds Dealer / Systematic Internaliser role.
> 3. Does the platform recommend specific tokens to specific investors or manage their portfolios? → Yes adds Advisor role.
>
> Each "yes" adds an independent regulatory stack. A platform that answers no to all three is in the issuer-only lane (lightest compliance lift). The only way to genuinely stay in the pure-issuer lane is **no on-platform secondary trading at all** — tokens locked, exits only off-platform or via narrow redemption-to-issuer arrangements that fall under the MiFID II Art. 2(1)(d) "occasional" carve-out. Continuous redemption-on-demand probably does not qualify. A platform that answers yes to all three is in the full investment-firm + venue + advisor lane (largest compliance burden, smallest addressable market). The shift in compliance scope between role layers is roughly 3× in budget and timeline.
>
> **MiFID III layering summary:** Issuer role is untouched. Venue and Dealer roles each carry independent MiFID III obligations. A platform operating both (DLT MTF + SI) faces consolidated tape + PFOF ban + expanded reporting simultaneously — the obligations do not merge, they stack.

---

## Fund Structure Classification — UCITS → AIF → ELTIF

> [!info] AIFMD in plain words — when fractional RWA becomes a "fund"
> Tokenizing an asset is not automatically a fund. But the moment you **pool money from several passive investors** and **someone manages the asset to produce a return they collect**, EU law treats that vehicle as an **Alternative Investment Fund (AIF)** — and it needs an authorised fund manager (an **AIFM**) under AIFMD (Directive 2011/61/EU). On top of MiFID II + Prospectus, this is a *separate* authorisation, and often the heavier one. UCITS is the parallel rulebook for retail funds.
>
> **Two simple questions decide it:**
> 1. *Where does the investor's money go?* — Pooled into an asset managed for them → **fund (AIF)**. Direct legal title to their own asset, or a plain loan to a borrower → **not a fund**.
> 2. *Where does the return come from?* — The asset's rent + resale value → **fund (AIF)**. The trading profit of a real business they own as shareholders → **operating company, not a fund**.
>
> **What does NOT get you out of AIFMD:**
> - *"It's only one property / one car."* Single-asset vehicles can still be AIFs — the number of assets is irrelevant.
> - *"It's fractional ownership."* Fractionalising just adds investors; it neither creates nor avoids a fund.
> - *"There's staff, payroll, maintenance — real work behind the profit number."* Every real-estate and infrastructure fund runs exactly that. Collecting revenue → paying expenses → distributing net profit to passive holders *is the fund model*, not a defence against it.
>
> **The only real exit:** the investors own a genuine **operating business as a trade** — their return is enterprise/trading profit, not asset yield. Even then it is a fact-specific legal-opinion call. Treat AIFMD as the **default** for pooled, manager-run, passive-investor RWA (fractional real estate, car fleets, private-credit pools), and treat "we're exempt" as the position that has to be proven — not assumed.

> [!info] Fund Classification Decision Tree — UCITS → AIF → ELTIF
> EU law runs a sequenced test. Check UCITS first; everything that fails is an AIF; ELTIF is a label bolted on top of an AIF when retail access is needed.
>
> **Step 1 — Is it a UCITS?** (must satisfy all three simultaneously)
> 1. *Open-ended* — investors can redeem at NAV on demand
> 2. *Liquid eligible assets only* — transferable securities, money-market instruments, bank deposits, FDIs; **no real estate, commodities, loans, or infrastructure**
> 3. *Retail investor targeting*
>
> All three YES → **UCITS** (Dir 2009/65/EC; UCITS ManCo licence required — not an AIFM; 5/10/40 diversification rule; PRIIPs KID mandatory; EU cross-border passport via 10-working-day NCA notification; mandatory LMTs from 16 Oct 2026 per AIFMD II amendment)
>
> Any one NO → **AIF → AIFMD** (Dir 2011/61/EU; authorised AIFM required; sub-threshold registration only if AUM ≤€100M leveraged / ≤€500M unleveraged). **A fund is either a UCITS or an AIF — never both.**
>
> **Step 2 — Does the AIF also need a retail EU passport? ([[ELTIF-2.0|ELTIF 2.0]] check)**
>
> | Scenario | Outcome |
> |---|---|
> | Illiquid long-term assets + professional investors only | AIFMD only — ELTIF not needed |
> | Liquid assets + retail | UCITS — ELTIF irrelevant (cannot layer ELTIF on a UCITS) |
> | Illiquid long-term assets + retail EU passport wanted | **AIFMD + ELTIF 2.0 label** (Reg (EU) 2023/606; applicable 10 Jan 2024) |
>
> ELTIF 2.0 is not available to sub-threshold AIFMs — full AIFMD authorisation is a hard prerequisite. Two separate authorisations are required: the AIFM licence (for the manager) + ELTIF fund authorisation from the fund's home-Member-State NCA (per fund, 2-month decision window per Art 5(3)).
>
> **Key terms**
>
> *Professional investor (MiFID II Annex II):* Banks, fund managers, pension funds, large corporates (balance sheet ≥€20M / turnover ≥€40M / own funds ≥€2M — must meet 2 of 3). Lighter regulatory protection — fewer mandatory disclosures, no PRIIPs KID requirement. Retail can request elective-professional status if they pass wealth/experience tests; the manager must verify.
>
> *Retail investor:* Everyone not meeting the professional test — individuals, small businesses. Full regulatory protection applies: PRIIPs KID, suitability assessment, cost disclosures, redemption rights.
>
> *Liquid asset:* Continuously traded on a deep market — price-quoted daily, exit in minutes to hours at close to fair value. Examples: listed equities, government bonds, ETFs, FX. UCITS-eligible.
>
> *Illiquid asset:* No continuous market — price discovery is infrequent (valuation-based, not market-quoted), exit takes months to years. Examples: real estate, private equity, infrastructure, private credit, loans, farmland. UCITS-ineligible → AIF lane by default.

---

## Key Regulations

| Regulation | Focus | Key Deadline | Penalty |
|-----------|-------|-------------|---------|
| **MiFID II / III** | Investment services + markets. MiFID II (Dir 2014/65/EU): investment firm authorization, client classification, suitability, best execution, transaction reporting, venue types (RM, MTF, OTF, SI). MiFIR (Reg 600/2014): pre/post-trade transparency, Art 26 transaction reporting. MiFID III (Dir 2024/790 + Reg 2024/791): targeted reform on PFOF, consolidated tape, and expanded reporting — applies to venue and dealer roles only; issuer role untouched. | MiFID II in force since Jan 2018; MiFID III phased: Sep 2025 active monitoring · Apr 2026 expanded reporting · Jun 2026 PFOF ban + consolidated tape | €44.5M EU fines in 2024 (single-year) |
| **AIFMD / UCITS** | Two distinct fund-manager authorisation regimes. **AIFMD** (Dir 2011/61/EU): governs managers of AIFs — any pooled vehicle that raises capital from several investors to invest per a defined investment policy for their collective benefit, with no general commercial/industrial purpose. Tokenised fractional real-estate / private-credit / multi-asset vehicles with passive investors qualify; their units are MiFID Annex I C(3) financial instruments. Below-threshold exemption: AUM ≤€100M (leveraged) / ≤€500M (unleveraged) — sub-threshold registered AIFM, no full authorisation required. **UCITS** (Dir 2009/65/EC): separate authorisation regime for open-ended retail funds. Key distinctions from AIFMD: (a) UCITS ManCo license — not an AIFM license; (b) eligible assets strictly limited to liquid securities — transferable securities, money-market instruments, deposits, FDIs only; **no real estate, commodities, or loans**; (c) **5/10/40 diversification rule**; (d) PRIIPs KID mandatory for retail from 1 January 2023; (e) cross-border passport via 10-working-day NCA notification. **A fund is either a UCITS or an AIF — never both.** | AIFMD in force since 22 Jul 2013; UCITS in force since 2010 (consolidated Dir 2009/65/EC). **AIFMD II (Dir (EU) 2024/927) transposition by 16 Apr 2026** — also amends UCITS: mandatory LMTs for all open-ended UCITS from **16 October 2026** | National-set — administrative fines + loss of authorisation; marketing a fund without an authorised AIFM / UCITS ManCo is prohibited |
| [[ELTIF-2.0\|ELTIF 2.0]] | European Long-Term Investment Fund — a voluntary product label (Regulation (EU) 2023/606 amending Reg 2015/760) applied on top of an AIFMD-authorised EU AIF, granting an EU-wide marketing passport including retail access. ELTIF 2.0 material changes: (1) min eligible assets 70 % → **55 %**; (2) borrowing **50 % NAV retail / 100 % NAV professional-only**; (3) concentration limits **removed for professional-only ELTIFs**; (4) eligible assets broadened to UCITS/EU AIF units + European Green Bonds; (5) matching mechanism for secondary exits (Art 19.2a); (6) local facilities requirement **removed**; (7) **€10k minimum ticket removed**; (8) QPU market cap ≤€1.5B; (9) master-feeder permitted. Two authorisations required: AIFMD licence for the manager + ELTIF NCA fund authorisation (2-month decision, Art 5(3)). | Applicable from **10 January 2024** (Reg 2023/606, OJ L 80/1, 20 Mar 2023) | NCA revocation of ELTIF authorisation; penalties follow AIFMD national framework of home Member State |
| **Prospectus Regulation** | Public-offer + admission-to-trading disclosure for transferable securities (issuer-level obligation; instrument classification borrowed from MiFID II Art. 4(1)(44) — issuer does *not* need to be MiFID-authorised) | In force since 21 Jul 2019; **Listing Act (Reg 2024/2809) amendments phased: 4 Dec 2024 / 5 Mar 2026 / 5 Jun 2026** — fungibility 20%→30%, supplement withdrawal 2→3 WD (in force); new EU Follow-on + EU Growth Issuance Prospectus + 300-page limit (Mar 2026); single €12M threshold (Jun 2026) | ≥€5M or 3% turnover for legal persons; ≥€700k for natural persons; ≥2× profits gained / losses avoided (Art. 38(2)) |
| [[MAR-Regulation\|MAR (Market Abuse Regulation)]] | Inside-information disclosure, insider lists, PDMR transactions, market-manipulation prohibition, buy-back safe harbour — applies once a financial instrument is admitted (or pending admission) to trading on an EU RM, MTF, OTF, SME growth market, DLT MTF, or DLT TSS. The *ongoing-disclosure* counterpart to the Prospectus Regulation's *offer-time* disclosure. | In force since 3 Jul 2016; **Listing Act (Reg 2024/2809) amendments from 4 Dec 2024** — Art 17 protracted-process narrowed to *final event only*; PDMR threshold raised €5k → €20k; further amendments 5 Jun 2026 | **2% of total annual turnover** (min €2.5M) for Art 17 breaches; **0.8%** (min €1M) for Arts 18-19; **≥3× disgorgement** for natural persons |
| [[EU-Listing-Act\|EU Listing Act]] | Horizontal reform package (Reg (EU) 2024/2809 + Dir (EU) 2024/2810 + Dir (EU) 2024/2811) amending Prospectus Reg, MAR, MiFIR, and MiFID II. Not a standalone regime — every obligation lives in an amended host regulation. | Three-cliff: **4 Dec 2024** (MAR amendments, fungibility 30%, supplement withdrawal 3 WD) / **5 Mar 2026** (EU Follow-on + EU Growth Issuance Prospectus) / **5 Jun 2026** (single €12M threshold); Dir 2024/2810 transposition **5 Jun 2026**; Dir 2024/2811 multi-vote shares **5 Dec 2026** | Penalties live in the amended host regulation (Prospectus Art 38(2) / MAR Art 30(2)) |
| [[DLT-Pilot-Regime\|DLT Pilot Regime]] | Regulatory sandbox for on-chain tokenized-securities trading and settlement — DLT MTF (trading), DLT SS (settlement), DLT TSS (combined). Grants exemptions from MiFIR/CSDR for on-chain infrastructure. Permanence package proposed April 2026. | Regulation (EU) 2022/858 in force; 6-year sandbox window per authorisation; **10 pending applications** as of 2026 (including Securitize, Spain) | Sandbox exemptions revocable by NCA; operators revert to full MiFIR/CSDR obligations on expiry |

> [!info] Cross-cutting regimes also apply
> The table above lists the *securities-specific* lane. RWA/STO platforms are also subject to the EU's horizontal financial-services regimes — because an RWA platform is a MiFID investment firm and/or a DLT venue, it is in scope for:
> - [[DORA-Regulation|**DORA**]] (ICT operational resilience) — always, via the MiFID investment-firm / DLT Pilot trading-venue / CSD pathway (DORA Art. 2(e),(g),(i)); the firm does NOT need to be a CASP to be caught.
> - [[EU-AML-AMLA|**AML/AMLA**]] (AMLR obliged entity) — always; CDD + KYC + STR. **TFR Travel Rule does NOT apply** to MiFID-classified tokens (not crypto-assets under MiCA); only a CASP side, if present, triggers TFR.
> - **eIDAS 2.0** — investor KYC must accept the EUDI Wallet as a relying party from 31 Dec 2026.
> - **GDPR** — always, for investor personal data.
> - **EU AI Act** — conditional; if AI is used for asset valuation, oracle inputs, or portfolio/risk management (high-risk AI obligations).
> - **MiCA** — only if the token is an Asset-Referenced Token, or the firm also services non-MiFID crypto-assets (CASP licensing is service-level, independent of the token's classification).
>
> These are detailed in [[EU-Fintech-Compliance-Landscape]] (the horizontal regimes are shared across all segments). The per-segment obligation lists below show the full stack in context.

---

## Compliance by Segment

### Crypto Native — Seg 1: RWA Tokenization

| Segment | EU Compliance Obligations |
|---|---|
| **Seg 1 — RWA Tokenization** | **MiFID II + Prospectus Regulation** (primary — any token conferring ownership / claim on issuer or underlying asset is a transferable security regardless of yield; MiCA Art. 2(4) carve-out applies) · **AIFMD / UCITS** (conditional but high-frequency — when the token pools capital from multiple investors under a defined investment policy, the token is a *unit in a collective investment undertaking* (MiFID Annex I C(3)) and the vehicle requires an authorised **AIFM** (or UCITS ManCo); per ESMA's Mar 2025 guidelines, a token giving a proportional share of pooled returns + redemption for a share of portfolio value = CIU unit; carve-outs are narrow — genuine day-to-day holder control, or a genuine operating business / direct tokenized debt / direct legal co-ownership; see the AIFMD callout above) · [[ELTIF-2.0\|**ELTIF 2.0**]] (if the AIF manager seeks a retail EU passport for illiquid long-term assets — Reg (EU) 2023/606, applicable 10 Jan 2024; ≥55 % eligible assets; requires AIFMD authorisation as prerequisite) · **MiFID III** (if operating a DLT MTF / SS / TSS — expanded reporting Apr 2026, transparency Mar 2026, PFOF ban Jun 2026; pure issuers not in scope) · [[MAR-Regulation\|**MAR**]] (once tokens are admitted or pending admission to trading on an EU venue / DLT MTF / DLT TSS — issuer Art 17 disclosure, Art 18 insider lists, Art 19 PDMR, Arts 12-15 manipulation prohibition; venue Art 16 + STORs) · [[DLT-Pilot-Regime\|**DLT Pilot Regime**]] (DLT MTF / SS / TSS — the real on-chain infra path, not MiCA) · [[DORA-Regulation\|**DORA**]] (ICT resilience — always, via the MiFID investment-firm / DLT Pilot venue / CSD pathway, DORA Art. 2(e),(g),(i)) · [[EU-AML-AMLA\|**AML/AMLA**]] (CDD + KYC + STR via AMLR as a MiFID II investment firm; **TFR Travel Rule does NOT apply** — only the CASP side, if present, triggers it; AMLA direct supervision only if cross-border + large) · **eIDAS 2.0** (investor KYC must accept the EUDI Wallet as relying party from 31 Dec 2026) · **GDPR** (investor personal data) · **EU AI Act** (if AI used for asset valuation or oracle inputs) · **MiCA** (only if the token is an Asset-Referenced Token, or the firm also services non-MiFID crypto-assets) |

### FinTech — WealthTech (RWA / STO / Tokenized Securities)

| Segment | EU Compliance Obligations |
|---|---|
| **WealthTech (RWA / STO / Tokenized Securities)** | **MiFID II / III** (primary — financial instrument classification; investment services authorization) · **Prospectus Regulation** (for any token conferring ownership / claim on issuer or underlying asset) · **AIFMD / UCITS** (if the tokenised product is a pooled vehicle — the token is a *unit in a collective investment undertaking* (MiFID Annex I C(3)) and an authorised AIFM / UCITS ManCo is required; see Seg 1 + the Fund Structure section) · [[ELTIF-2.0\|**ELTIF 2.0**]] (conditional — if the AIF manager seeks an EU-wide retail marketing passport for illiquid long-term assets: ELTIF label layered on AIFMD; ≥55 % eligible assets; two authorisations — AIFM licence + per-fund ELTIF NCA authorisation) · [[MAR-Regulation\|**MAR**]] (ongoing-disclosure counterpart to Prospectus — triggers once the tokenised security is admitted or pending admission to trading) · [[DLT-Pilot-Regime\|**DLT Pilot Regime**]] (if building DLT MTF/SS/TSS) · [[DORA-Regulation\|**DORA**]] (ICT resilience — WealthTech investment firms are explicitly in DORA Art. 2 scope) · [[EU-AML-AMLA\|**AML/AMLA**]] (investment firm → AMLR obliged entity; AMLA direct supervision possible if cross-border + large AUM) · **eIDAS 2.0** (investor KYC must accept the EUDI Wallet from 31 Dec 2026) · **GDPR** (investor personal data) · **EU AI Act** (if AI used in portfolio or risk management) · **MiCA** (only if the firm also services non-MiFID crypto-assets — stablecoins, utility tokens — on the side) |

---

## Compliance Dependency Map

```
─── CONDITIONAL (RWA/STO-specific triggers) ─────────────────────────────────
MiFID II / III ─────► Investment services + financial instruments
                       (includes ownership-conferring tokenized securities)
AIFMD / UCITS ──────► Pooled investment vehicles (collective investment
                       undertakings) — fractional real-estate / private-credit /
                       multi-asset RWA funds with passive investors. The token is
                       a unit in the fund; the vehicle needs an authorised AIFM
                       (or UCITS ManCo). NOT triggered by: single-asset SPV run as
                       a genuine operating business, direct tokenized debt, or
                       direct legal co-ownership of the asset.
ELTIF 2.0 ──────────► EU AIFMs wanting an EU-wide marketing passport (including
                       retail) for long-term illiquid strategies: infrastructure,
                       private equity/debt, real assets. ELTIF is a voluntary AIF
                       product label — requires AIFMD authorisation PLUS separate
                       NCA ELTIF authorisation per fund. Applicable 10 Jan 2024.
                       Key triggers: (a) manager already holds AIFMD licence;
                       (b) fund wants retail EU passport; (c) fund invests ≥55 %
                       in eligible long-term assets. Professional-only ELTIF:
                       diversification limits waived; borrowing up to 100 % NAV.
                       NOT available to sub-threshold AIFMs or non-EU AIFMs.
Prospectus Reg ─────► Issuer-level obligation when offering transferable
                       securities to the public in the EU, or seeking admission
                       to trading on an EU regulated market. Triggers on the
                       *issuer*, not on intermediaries. Borrows MiFID II's
                       "transferable security" definition (Art. 4(1)(44)) —
                       the issuer itself does NOT need MiFID authorisation.
                       Listing Act (Reg 2024/2809) amendments: 5 Mar 2026 —
                       new EU Follow-on Prospectus + EU Growth Issuance Document,
                       exemption threshold up to €12m.
MAR ────────────────► Ongoing-disclosure counterpart to Prospectus — triggers
                       once a financial instrument is admitted (or pending
                       admission) to trading on an EU RM / MTF / OTF / SMEGM
                       / DLT MTF / DLT TSS. (Listing Act schedule + scope:
                       see Key Regulations table above.)
EU Listing Act ─────► Horizontal package amending Prospectus + MAR + MiFIR +
                       MiFID II + adding multi-vote SMEGM shares. Triggers on
                       any issuer planning EU public-market access in 2026+,
                       any already-listed issuer absorbing MAR amendments,
                       and large EU equity venue operators (new MAR Arts 25a/25b).
DLT Pilot Regime ───► On-chain tokenized securities trading + settlement infra
                       (DLT MTF / SS / TSS — sandbox path; permanence package
                       proposed April 2026)

─── CROSS-CUTTING (apply to RWA platforms via entity classification) ─────────
DORA ───────────────► ICT resilience — always (MiFID investment firm / DLT venue
                       / CSD; DORA Art. 2(e),(g),(i))
AML / AMLA ─────────► AMLR obliged entity — always (investment firm). TFR Travel
                       Rule does NOT apply to MiFID-classified tokens.
eIDAS 2.0 ──────────► Investor KYC must accept the EUDI Wallet from 31 Dec 2026
GDPR ───────────────► Investor personal data — always
EU AI Act ──────────► If AI used for asset valuation, oracle inputs, or portfolio
                       / risk management (high-risk AI)
MiCA ───────────────► Only if token is an ART, or firm services non-MiFID
                       crypto-assets (service-level CASP licensing)
```

---

## Quick Reference: RWA/STO Regulatory Triggers by Segment

| Regulation | Crypto Native — Seg 1 | FinTech — WealthTech |
|---|---|---|
| **MiFID II / III** | Seg 1 RWA primary (ownership tokens are securities by default); MiFID III applies to Venue and Dealer roles only — Issuer role untouched | WealthTech (primary); ExchangeTech (if also trading financial instruments) |
| **AIFMD** | Seg 1 RWA when the token is a unit in a pooled **alternative / illiquid**-asset vehicle with passive investors + defined investment policy — authorised AIFM required (sub-threshold registration if AUM ≤€100M leveraged / ≤€500M unleveraged). NOT triggered by single-asset operating SPVs, direct tokenized debt, or direct co-ownership | WealthTech (pooled alternative / illiquid tokenised funds = AIF → AIFM required) |
| **UCITS** | Seg 1 RWA — **only** if the tokenized fund invests exclusively in UCITS-eligible liquid assets (no real estate, commodities, or loans) AND is structured open-ended for retail investors. **Rare in Crypto Native**. A fund is either a UCITS or an AIF — **never both** | WealthTech — retail open-ended tokenized funds with liquid underlying assets; UCITS ManCo license required; 5/10/40 rule; PRIIPs KID mandatory; mandatory LMTs from 16 Oct 2026 |
| [[ELTIF-2.0\|**ELTIF 2.0**]] | Seg 1 RWA — voluntary AIF product label for managers seeking EU-wide retail passport for illiquid tokenized long-term asset funds. Applicable 10 Jan 2024. Requires AIFMD licence as prerequisite; **not available to sub-threshold AIFMs**; ≥55 % in eligible assets; professional-only: all concentration limits waived, ≤100 % NAV borrowing | WealthTech — primary for managers building EU-passported illiquid-asset funds with retail access; no minimum ticket; ≤50 % NAV (retail) / ≤100 % NAV (professional-only); two authorisations required — AIFM licence + ELTIF NCA fund authorisation |
| **Prospectus Regulation** | Seg 1 RWA (any public offer or admission to trading of an ownership-conferring token — primary) | WealthTech (primary — every public offer of a tokenised security); ExchangeTech indirectly (must verify a compliant prospectus exists before admitting a security token to trading) |
| [[MAR-Regulation\|**MAR**]] | Seg 1 RWA primary (instrument-based — triggers once tokens admitted or pending admission to trading on EU venue / DLT MTF / DLT TSS) | WealthTech primary (issuer + venue side once admitted); ExchangeTech (venue Art 16 surveillance + STORs if admitting financial instruments) |
| [[DLT-Pilot-Regime\|**DLT Pilot Regime**]] | Seg 1 RWA (DLT MTF / SS / TSS — the real on-chain securities infra path) | WealthTech (primary — DLT MTF/SS/TSS) |

> [!TIP] DLT Pilot Regime Sales Hook
> The 10 pending DLT Pilot applications (including Securitize, Spain) are warm prospects — firms that have decided to pursue DLT Pilot status but haven't built the infrastructure. Highest-intent leads for InnBlockchain's dev/audit motion across both ICPs.

---

## Implementation Checklists

Per-regulation compliance checklists live in `.raw/…/EU Compliance/Checklist/`. Most-relevant for RWA/STO work: MiFID II, MiFID III, MiFIR, AIFMD, AIFMD II, UCITS, ELTIF 2.0, Prospectus, MAR, EU Listing Act, DLT Pilot Regime (all primary/conditional per the segment tables above), plus the cross-cutting DORA, AML/AMLA, eIDAS 2.0, GDPR checklists (always) and MiCA / TFR (only if a CASP side exists).

## InnBlockchain Relevance

- **Crypto Native Seg 1 RWA**: Seg 1 is MiFID-primary, not MiCA — DLT Pilot Regime is both the correct infra path and the highest-intent sales hook (10 pending applications including Securitize / Spain)
- **ELTIF 2.0 opportunity**: ELTIFs are the EU fund wrapper most directly aligned with InnBlockchain's tokenization engineering. Key use cases: tokenised ELTIF units (ERC-3643/T-REX protocol), smart-contract matching mechanism for Art 19(2a) secondary exits, portfolio compliance dashboards tracking the 55 % minimum + per-asset concentration limits + NAV borrowing ratios, PRIIPs KID data automation, real-asset onboarding pipelines. Retail ELTIF passporting without local-facility requirement (removed in ELTIF 2.0) makes this the highest-growth EU fund-tech segment for 2024-2026.
- **WealthTech**: Fund compliance engineering — AIFMD/UCITS/ELTIF structure setup, prospectus + MAR workflow automation, DLT MTF/SS/TSS build-out, investor classification KYC/AML onboarding pipelines

## Primary Sources

Citations use EUR-Lex ELI URLs (the canonical, version-stable form).

### Legislation in force

| Regulation | Instrument | Official source |
|---|---|---|
| MiFID II | Directive 2014/65/EU | https://eur-lex.europa.eu/eli/dir/2014/65/oj |
| MiFIR | Regulation (EU) 600/2014 | https://eur-lex.europa.eu/eli/reg/2014/600/oj |
| MAR (Market Abuse Regulation) | Regulation (EU) No 596/2014 | https://eur-lex.europa.eu/eli/reg/2014/596/oj |
| MiFID III review — Directive | Directive (EU) 2024/790 | https://eur-lex.europa.eu/eli/dir/2024/790/oj |
| MiFID III review — Regulation | Regulation (EU) 2024/791 | https://eur-lex.europa.eu/eli/reg/2024/791/oj |
| AIFMD | Directive 2011/61/EU | https://eur-lex.europa.eu/eli/dir/2011/61/oj |
| AIFMD II (review) | Directive (EU) 2024/927 | https://eur-lex.europa.eu/eli/dir/2024/927/oj |
| UCITS | Directive 2009/65/EC | https://eur-lex.europa.eu/eli/dir/2009/65/oj |
| ELTIF 2.0 (amending Regulation) | Regulation (EU) 2023/606 (amends Reg 2015/760) | https://eur-lex.europa.eu/eli/reg/2023/606/oj/eng |
| ELTIF (original) | Regulation (EU) 2015/760 | https://eur-lex.europa.eu/eli/reg/2015/760/oj |
| DLT Pilot Regime | Regulation (EU) 2022/858 | https://eur-lex.europa.eu/eli/reg/2022/858/oj |
| Prospectus Regulation | Regulation (EU) 2017/1129 | https://eur-lex.europa.eu/eli/reg/2017/1129/oj |
| EU Listing Act — main regulation (amends Prospectus Reg + MAR + MiFIR) | Regulation (EU) 2024/2809 | https://eur-lex.europa.eu/eli/reg/2024/2809/oj |
| EU Listing Act — MiFID amendment + Listing Directive repeal | Directive (EU) 2024/2810 | https://eur-lex.europa.eu/eli/dir/2024/2810/oj |
| EU Listing Act — multi-vote share structures at SMEGM IPO | Directive (EU) 2024/2811 | https://eur-lex.europa.eu/eli/dir/2024/2811/oj |

For the cross-cutting horizontal regimes that also apply to RWA/STO platforms — DORA (Reg 2022/2554), AMLR (Reg 2024/1624) / AMLD6 (Dir 2024/1640) / AMLA (Reg 2024/1620), eIDAS 2.0 (Reg 2024/1183), GDPR (Reg 2016/679), EU AI Act (Reg 2024/1689), MiCA (Reg 2023/1114), TFR (Reg 2023/1113) — see the Primary Sources table in [[EU-Fintech-Compliance-Landscape]].

### Supervisors and authority pages

- **ESMA** (MiFID II/III, AIFMD/UCITS, DLT Pilot, Prospectus, MAR): https://www.esma.europa.eu
  - Guidelines on qualification of crypto-assets as financial instruments (Mar 2025 — the CIU/AIF + transferable-security classification test): https://www.esma.europa.eu/sites/default/files/2025-03/ESMA75453128700-1323_Guidelines_on_the_conditions_and_criteria_for_the_qualification_of_CAs_as_FIs.pdf
  - Guidelines on key concepts of the AIFMD (the "general commercial/industrial purpose" + day-to-day-control carve-outs): https://www.esma.europa.eu/document/guidelines-key-concepts-aifmd-0

See: [[EU-Fintech-Compliance-Landscape]] | [[ELTIF-2.0]] | [[MiFID-II]] | [[MiFID-III]] | [[MAR-Regulation]] | [[EU-Listing-Act]] | [[DLT-Pilot-Regime]] | [[DORA-Regulation]] | [[EU-AML-AMLA]] | [[Asset-Tokenization-RWA]] | [[ESMA]]
