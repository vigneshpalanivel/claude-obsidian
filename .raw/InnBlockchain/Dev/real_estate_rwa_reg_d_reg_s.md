# Real Estate RWA Tokenization — Dual-Tranche Reg D 506(c) + Regulation S Implementation Guide for Sponsors, Counsel, and Builders

**Offering structure:** This is a **concurrent dual-tranche offering** — a **Regulation D Rule 506(c)** tranche for **U.S. accredited investors** (general solicitation permitted, accreditation verified) run alongside a **Regulation S** tranche for **offshore non-U.S. persons**. The two tranches are separate offerings kept from integrating under the **Rule 152(b)(2)** safe harbor. Both produce **restricted securities** governed by **Rule 144**; **OFAC** applies to both cumulatively. One ERC-1400 token contract serves both, with each tranche in its own partition(s).

**Source authorities:**

- [reg-d-checklist.md](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md) — single source of truth for Regulation D requirements (17 CFR §§ 230.500–230.508), governing the U.S.-accredited Rule 506(c) tranche (accredited-investor definition, verification, general solicitation, Form D, bad-actor disqualification, integration via Rule 152)
- [reg-s-checklist.md](../sales-marketing/Service/Content/US%20Compliance/reg-s-checklist.md) — single source of truth for Regulation S requirements (17 CFR §§ 230.901–230.905), governing the offshore tranche
- [rule-144-checklist.md](../sales-marketing/Service/Content/US%20Compliance/rule-144-checklist.md) — single source of truth for Rule 144 resale conditions (17 CFR § 230.144). BOTH tranches produce restricted securities: the Reg D tranche directly (Rule 502(d)); the Reg S tranche via the Rule 905 bridge for domestic-issuer equity
- [ofac-checklist.md](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md) — single source of truth for OFAC sanctions compliance (31 CFR Chapter V, SDN List, Executive Orders, program-specific regulations, virtual currency guidance), applied independently of and cumulatively with Reg D, Reg S, and Rule 144

**Token standard:** **ERC-1400** (the security-token standard) — a family of related Ethereum specifications:

- **ERC-1410** — _partitioned tokens_. Lets one token contract hold multiple "partitions," each carrying its own compliance state. Partitions do double duty here: (a) they segregate the **exemption tranche** — `REG_D` partitions (U.S. accredited, Rule 506(c)) vs `REG_S` partitions (offshore) — which keeps the two offerings non-integrated and lets `canTransfer` apply the right rules; and (b) within the Reg S tranche, each partition carries a `closeDate` anchoring that partition's 12-month Reg S lockup. Reg D partitions have no Reg S `closeDate` (that is a Reg S concept). See Section C and the Reg D section.
- **ERC-1594** — _transfer validation_. Defines the `canTransfer` hook the token calls before every transfer to check whether it's allowed; this is where the Reg D (506(c) eligibility), Reg S (offshore / distribution-compliance), and Rule 144 (restricted-securities resale) rules are enforced, dispatched by the partition's tranche type.
- **ERC-1643** — _document registry_. A standard way for the token to publish references (URI + hash fingerprint) to the offering memorandum, legends, and other legal documents.
- **ERC-1644** — _controller operations_. A built-in capability for the issuer to force-transfer or burn tokens to remediate non-compliant transfers, exercised through governance-controlled keys.

**Identity layer:** **ERC-3643** (also called T-REX) / **ONCHAINID** — an on-chain identity registry standard. Each wallet that holds tokens is bound to an identity contract that stores KYC status, jurisdiction, OFAC screening, and other compliance claims. The same investor identity can be reused across multiple deals.

**Audience:** Florida real estate sponsor, his counsel, his placement agents, and the development team building the token platform. Technical terms are used where industry-standard vocabulary exists; each is explained in business context the first time it appears.

**Document scope:** What the platform must enforce on-chain, what must be handled off-chain by people and process, and how the two connect. Code is intentionally omitted; the development team translates these requirements into Solidity.

---

## CONFIRMED ISSUER PROFILE

| Attribute                                   | Value                                                         | Source                                                                                                                                                                                                                                                                                                                                                                                             |
| ------------------------------------------- | ------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Issuer location                             | Florida, USA                                                  | Client input                                                                                                                                                                                                                                                                                                                                                                                       |
| Business                                    | Real estate (U.S.-situs assets)                               | Client input                                                                                                                                                                                                                                                                                                                                                                                       |
| Likely entity form                          | Florida LLC, Delaware LLC, or Delaware statutory trust        | Standard real estate SPV practice                                                                                                                                                                                                                                                                                                                                                                  |
| **Domestic vs Foreign**                     | **Domestic issuer**                                           | Rule 902(e) → Rule 405 "foreign issuer" definition turns on **jurisdiction of organization**: a Florida-organized LLC is organized under U.S. law, so it is NOT a "foreign issuer" → domestic issuer. (The U.S.-ownership + U.S.-management two-prong test is the separate "foreign _private_ issuer" test under Rule 405 / Rule 3b-4 — a different determination, not the one that controls here) |
| **Reporting status**                        | **Non-reporting issuer**                                      | Rule 902(i) — no §12(b)/(g) registration, no §15(d) filings, no 12-month reporting history                                                                                                                                                                                                                                                                                                         |
| **Security type**                           | **Equity** (LLC membership / beneficial interest tokenized)   | Token represents pro-rata ownership in property cash flows and disposition proceeds                                                                                                                                                                                                                                                                                                                |
| **Offering exemptions**                     | **Reg D Rule 506(c) (U.S. accredited) + Reg S (offshore), concurrent** | Dual-tranche. 506(c) permits general solicitation to **verified** accredited U.S. investors; Reg S covers offshore non-U.S. persons. Kept non-integrated under Rule 152(b)(2). Cross-ref: [reg-d-checklist §6](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md), [reg-s-checklist](../sales-marketing/Service/Content/US%20Compliance/reg-s-checklist.md) |
| **Reg D accreditation verification**        | **Required — "reasonable steps to verify" (Rule 506(c)(2)(ii))** | Self-certification is NOT enough. Verification (income/net-worth docs, or a registered BD/RIA/attorney/CPA letter) is an on-chain gate at mint for `REG_D` partitions. Cross-ref: [reg-d-checklist §6](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md) |
| **Reg D filings / disqualification**        | **Form D within 15 days of first sale; bad-actor clear (Rule 506(d))** | Form D on EDGAR; state notice filings (506 = covered security, Section 18 preemption). Bad-actor questionnaires for all covered persons. Cross-ref: [reg-d-checklist §§8–9](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md) |
| **Reg S Category**                          | **Category 3 — domestic-issuer equity** (Rule 903(b)(3)(iii)) | Cross-ref: [reg-s-checklist §3.2 Category 3](../sales-marketing/Service/Content/US%20Compliance/reg-s-checklist.md)                                                                                                                                                                                                                                                                                                                |
| **Distribution compliance period**          | **12 months, from each partition's `closeDate`**              | Rule 903(b)(3)(iii)(A) 1-year period (non-reporting). Per Rule 902(f), a partition's period starts at its `closeDate` — set at creation for a defined tranche (f)(1), or filled at completion of distribution for a continuous offering (f)(2). See Section C                                                                                                                                      |
| **Restricted-securities status**            | **Permanent under Rule 905**                                  | Rule 905 makes domestic-issuer equity acquired under Reg S "restricted securities" under Rule 144 indefinitely                                                                                                                                                                                                                                                                                     |
| **Rule 144 holding period for U.S. resale** | **12 months**                                                 | Rule 144(d) — non-reporting issuer threshold                                                                                                                                                                                                                                                                                                                                                       |

## OPERATIONAL CONSTRAINTS THE CLIENT HAS ACCEPTED

A **concurrent dual-tranche** raise is the chosen path: a **Reg D 506(c)** tranche for verified U.S. accredited investors + a **Reg S** tranche for offshore non-U.S. persons. The client has accepted the following constraints — the platform enforces them on-chain, and the offering documents must disclose them prominently:

1. **U.S. persons may buy ONLY if they are accredited AND verified, and ONLY in the Reg D (506(c)) tranche.** A U.S. person who is not accredited, or is accredited but not verified under Rule 506(c)(2)(ii), cannot subscribe at all. Offshore non-U.S. persons subscribe in the **Reg S** tranche. **The Reg S tranche still blocks EVERY U.S. person** (even a verified-accredited one) for the life of that partition's distribution compliance period — a U.S. accredited buyer belongs in a `REG_D` partition, never a `REG_S` partition. Verified U.S. accredited investors and offshore investors are kept in separate partitions so the two exemptions do not integrate (Rule 152(b)(2)).
2. **Both tranches produce restricted securities → Rule 144 governs resale.** The Reg D tranche is restricted directly under Rule 502(d); the Reg S domestic-equity tranche is restricted via the Rule 905 bridge. In BOTH, U.S. resale requires the Rule 144 holding period (12 months, non-reporting) measured from each holder's full-payment date, with Rule 144(d)(1)(ii) tacking. **The Reg S tranche additionally carries the Reg S distribution compliance period** (the partition's `closeDate + 12 months`), during which NO U.S.-person transfer is allowed regardless of Rule 144 — so on a Reg S partition the two clocks run and the `closeDate` clock binds (Section C/D). **The Reg D tranche has NO Reg S compliance period** — only the Rule 144 holding period gates its U.S. resale. For any holder who becomes an affiliate by operation of law, ongoing Rule 144 affiliate restrictions (volume caps, broker-only channels, current public information, Form 144) apply that this platform does not support — wallet is `BLOCKED` instead.
3. **General solicitation is PERMITTED for the 506(c) tranche — but Reg S non-integration must be protected.** Rule 506(c) allows public marketing (website, social, demo days) to reach U.S. accredited investors, provided every U.S. purchaser is verified. The concurrent Reg S tranche relies on the **Rule 152(b)(2)** integration safe harbor, and SEC guidance treats concurrent 506(c) general solicitation as not constituting "directed selling efforts" that would break the Reg S offering — **provided the Reg S offers/sales themselves remain genuine offshore transactions** (not made to persons in the U.S. for the Reg S securities). Counsel must structure the marketing so the Reg S leg keeps its offshore character; the platform enforces the buyer-side gates, not the marketing.
4. **The sponsor still cannot personally subscribe — in either tranche.** The Florida-resident sponsor would qualify as an accredited investor (as a director/officer under Rule 501(a)(4)), so 506(c) does not exclude him. But the **affiliate-free architecture** (below) does: no affiliate holds tokens. His economics come through the LLC promote (see Architectural Decision §1), not through token subscription, in either tranche.

---

## REG S SAFE HARBOR SCOPE — WHAT IT DOES NOT COVER

Reg S is a safe harbor from Section 5 **registration** requirements only. Even when the platform enforces every Reg S condition correctly, the issuer and its agents remain subject to the following independent legal regimes. The platform does NOT enforce any of them — they are managed off-chain by counsel and the issuer's compliance team.

- [ ] **Anti-fraud provisions** — Section 17(a) of the Securities Act and Section 10(b) / Rule 10b-5 of the Exchange Act apply to every securities transaction, including Reg S offerings. Material misstatements or omissions in the offering memorandum, marketing materials, or investor communications are actionable independent of Reg S compliance
- [ ] **Broker-dealer registration (Section 15 of the Exchange Act)** — placement agents and any party engaged in the business of effecting securities transactions for the account of others must be registered as broker-dealers, unless a separate exemption applies. Reg S does NOT exempt placement intermediaries from this registration. Foreign broker-dealers may rely on the narrow Rule 15a-6 carve-out, but its conditions must be independently satisfied
- [ ] **State securities laws (blue sky)** — Reg S is federal-law only. States retain authority to regulate. Many states have parallel exclusions for transactions effected outside the state, but state-by-state analysis is required for any state with a U.S.-resident purchaser (recall that even some non-U.S.-person investors may be transacting from within a U.S. state — e.g., the U.S.-branch-of-foreign-entity case in Rule 902(k)(1)(v))
- [ ] **Exchange Act reporting** — if the issuer is already a reporting company under §§ 12 or 15(d), Reg S does not relieve ongoing reporting obligations. For non-reporting issuers like this one, Reg S does not by itself create reporting obligations, but the § 12(g) holder-count threshold (2,000 holders of record, or 500 non-accredited, plus $10M+ in assets) can be triggered by accumulated Reg S holders
- [ ] **OFAC sanctions** — see §A.1. Reg S does not exempt from any OFAC obligation; strict liability applies

> **Common misunderstanding:** "We're Reg S-compliant" does not mean "We're securities-law-compliant." Reg S is one piece of a much larger compliance perimeter. The platform's enforcement gates address Reg S Section 5 registration risk and OFAC; everything else requires its own off-chain controls.

---

## THE DUAL-TRANCHE STRUCTURE — Reg D 506(c) (U.S.) + Reg S (Offshore)

_Source authority for the U.S. tranche: [reg-d-checklist.md](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md) — single source of truth for Regulation D (17 CFR §§ 230.500–230.508). This section describes only the implementation-specific application to the platform; refer to the checklist for the full accredited-investor definition, verification methods, general-conditions detail, bad-actor taxonomy, Form D mechanics, Rule 508, and Section 18 preemption._

One token contract, two exemptions, two purchaser pools. Each holding lives in a partition tagged with a **`tranche` type**, and `canTransfer` dispatches on it:

| | **`REG_D` partition (Rule 506(c))** | **`REG_S` partition (Rule 903 Cat 3)** |
|---|---|---|
| Buyer pool | **U.S. accredited investors, verified** | Offshore **non-U.S. persons** |
| Marketing | **General solicitation permitted** | No directed selling efforts in the U.S. |
| Distribution compliance period | **None** (Reg S concept only) | `closeDate + 12 months` (Section C) |
| U.S.-person gate | Recipient must be `US_ACCREDITED_VERIFIED` (or a later Rule 144-eligible resale) | ALL U.S. persons blocked during the compliance period |
| Restricted securities? | **Yes — directly, Rule 502(d)** | Yes — via the Rule 905 bridge |
| Resale into the U.S. | Rule 144 holding period (12 mo, non-reporting) | Reg S compliance period **AND** Rule 144 |
| Issuer filings | **Form D; bad-actor (506(d)); state notices** | Reg S offering restrictions |

### Why two partitions, not one pool — integration (Rule 152)

- [ ] **The two tranches must NOT integrate.** Keeping the U.S.-accredited holdings in `REG_D` partitions and the offshore holdings in `REG_S` partitions — separate purchaser pools, separate subscription documents, separate legends — supports the **Rule 152(b)(2)** safe harbor, under which Reg S offers and sales do not integrate with the concurrent 506(c) offering
- [ ] Do NOT mint the same investor into both tranches for the same economic interest; route each subscriber to exactly one tranche by their status (verified U.S. accredited → `REG_D`; offshore non-U.S. person → `REG_S`)

### Rule 506(c) conditions enforced on-chain (`REG_D` partitions)

- [ ] **All purchasers accredited (Rule 501(a))** — `mint` to a `REG_D` partition requires the recipient's identity record to carry an **accredited** flag. A single non-accredited purchaser destroys 506(c) for the whole tranche
- [ ] **Reasonable steps to VERIFY (Rule 506(c)(2)(ii)) — self-certification is NOT enough.** Verification is an off-chain determination (income docs / net-worth docs + credit report / a registered BD, SEC-RIA, licensed attorney, or CPA confirmation letter) recorded on-chain as a **verification attestation** (method, date, provider) in the identity registry, gated at `mint`. See Section A and the mint flow (Section I). Verification is generally reliable for a bounded window (re-verify on a material change; a written re-representation refreshes it)
- [ ] **General solicitation permitted** — the platform imposes no marketing gate on the `REG_D` tranche; the accredited-and-verified check at mint is what makes public solicitation safe
- [ ] **Restricted securities (Rule 502(d))** — `REG_D` tokens carry the restrictive legend (Section E) and are subject to Rule 144 for U.S. resale (Section D). There is **no Reg S distribution compliance period** on a `REG_D` partition — its `closeDate` field is unused / `type(uint256).max`, and the Reg S U.S.-person gate does not apply to it

### Off-chain gates the platform records but does not compute

- [ ] **Bad-actor disqualification (Rule 506(d))** — before the offering, run bad-actor questionnaires for all covered persons (issuer, directors, executive/participating officers, 20% owners, promoters, placement agents). A disqualifying event makes Rule 506 unavailable. This is a pre-deployment / pre-offering gate, evidenced by an on-chain attestation hash; the platform does not adjudicate it. Cross-ref: [reg-d-checklist §8](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md)
- [ ] **Form D (Rule 503)** — file on EDGAR within **15 calendar days after the first sale** in the 506(c) tranche; amend annually / on material change. The platform emits a `FirstSaleRecorded(tranche, timestamp)` event off which the compliance team runs the 15-day clock. Cross-ref: [reg-d-checklist §9](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md)
- [ ] **State Blue Sky** — 506(c) securities are federally covered (Section 18); file state **notice** filings + fees where U.S. purchasers reside. Reg S offshore sales are separately analyzed. Cross-ref: [reg-d-checklist §11](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md)
- [ ] **Information / anti-fraud** — 506(c) to all-accredited requires no mandated disclosure schedule, but the PPM must be accurate; Section 17(a) / 10b-5 apply to both tranches regardless of exemption

### What is identical across both tranches

- [ ] **OFAC** screening (Section A.1), **KYC**, the **affiliate-free architecture** (no affiliate holds tokens in either tranche), the **9.99% class-wide concentration cap** (aggregated across BOTH tranches — it is one class of equity), and **Rule 144** restricted-securities resale all apply uniformly. The tranche type changes only the *primary-issuance eligibility* and whether a Reg S distribution compliance period runs

> **Cross-tranche transfers:** a token's restricted status and its Rule 144 clock travel with it regardless of tranche. A `REG_D` token resold offshore to a non-U.S. person (Rule 904) stays restricted (Rule 905, domestic equity); a `REG_S` token cannot be transferred to a U.S. person until its compliance period expires and Rule 144 is met. To keep the analysis clean, the reference design routes secondary transfers **within the same partition** and treats any cross-tranche movement as a controller-mediated, compliance-reviewed action rather than an open-market transfer.

---

## ARCHITECTURAL DECISION: AFFILIATE-FREE TOKEN STRUCTURE (LOCKED)

**No affiliate of the issuer will hold tokens.** This is the single most consequential design decision in the project. It removes a substantial layer of compliance machinery from the on-chain logic — Rule 144(e) volume caps, Rule 144(f) manner-of-sale routing, Rule 144(c) current public information attestations, Rule 144(h) Form 144 filings, the Rule 144(a)(2) "person" attribution rules (household relatives + controlled trusts/entities), and the Section 13(d)/Rule 13d-5 group-control rules.

The five structural commitments below maintain the affiliate-free architecture:

### 1. Sponsor economics

- [ ] The sponsor does not receive tokens. The sponsor does not subscribe, is not allocated founder tokens, is not granted carry tokens
- [ ] The sponsor's economic interest is structured as **Class B Promote Units** at the LLC operating-agreement level — a separate class of LLC interests outside the token contract entirely
- [ ] Class B Promote Units are paid through the SPV's off-chain distribution waterfall (preferred return → return of capital → split with promote). The token contract never mints to the sponsor's wallet
- [ ] Class B Promote Units are governed by the applicable state LLC law and the LLC operating agreement, not by securities law (assuming a single-holder structure and no public offering of these units)

### 2. Per-investor concentration cap (on-chain enforced)

- [ ] **Hard maximum holding per identity: 9.99% of the token's total supply across ALL partitions** — keeps every holder below the 10% threshold commonly associated with a _rebuttable_ affiliate presumption. **Note the cap is necessary, not sufficient:** under Rule 144(a)(1) affiliate status is a **control** test, not an ownership-percentage test (rule-144-checklist §2.1) — a sub-10% holder can still be an affiliate via a board seat, veto rights, or concerted action. Control-based affiliate creation is caught separately by the BLOCKED triggers in §4 below; the 9.99% cap only removes the ownership-percentage vector. The cap is measured at the **class** level — the partitions are fungible tranches of one class (segregated only for compliance clocks), so the cap is the class-wide aggregate — NOT 9.99% of each partition (which would let a holder reach ~N×10% of the class across N closings)
- [ ] The cap is checked inside the `canTransfer` hook (ERC-1594) on every secondary transfer, and at issuance (mint) on every subscription
- [ ] The cap applies after aggregating balances across all wallets associated with the same identity in the ERC-3643 identity registry **and across all partitions that identity holds** — investors cannot split holdings across multiple wallets or across closing tranches to evade

### 3. No governance attached to tokens

- [ ] The tokens carry **no voting rights** on capex, refinance, sale, or any other SPV decision. The token is a pure economic claim (right to distributions, share of exit proceeds)
- [ ] All governance sits with the LLC managing member (the sponsor) under the operating agreement
- [ ] No board / advisor seats are granted to token holders. Institutional investors who expect governance representation must take a separate LLC interest, not tokens
- [ ] Any voting / governance hooks present in the ERC-1400 base implementation are **disabled or removed** at deployment

### 4. Affiliate-creating events trigger a wallet block

- [ ] If the off-chain KYC pipeline detects any of the following for any token holder, the identity registry flags the wallet as `BLOCKED` (the affiliate-free architecture does not classify anyone as an "affiliate" — there is no affiliate state, only BLOCKED). Each trigger flows from **Rule 144(a)(1)** — affiliate = "a person that directly or indirectly through one or more intermediaries, controls, is controlled by, or is under common control with" the issuer:
  - The holder is appointed an officer, director, or manager of the SPV → presumptive control → affiliate under Rule 144(a)(1)
  - The holder enters a voting agreement or shareholder agreement with other holders → joint control via group beneficial ownership (Section 13(d) / Rule 13d-5) → affiliate under Rule 144(a)(1)
  - Household attribution under Rule 144(a)(2)(i) — relative or spouse sharing the same home as an SPV affiliate. Per rule-144-checklist §2.2, the Rule 144(a)(2) "person" definition governs whose account securities are sold across ALL sales-side conditions (holding period, volume, manner of sale, Form 144) — not just (e) aggregation. A household member of an SPV affiliate therefore sits inside that affiliate's Rule 144 "person," and combined with the related party's affiliate status is treated as a presumptive affiliate under Rule 144(a)(1)
  - Concerted-action signal — multiple holders coordinating as a block (Section 13(d) / Rule 13d-5 group beneficial ownership → joint control) → affiliate under Rule 144(a)(1)
- [ ] Once BLOCKED, all outgoing transfers from that wallet revert in `canTransfer`. The holder must liquidate via registered offerings, Reg S Rule 904 offshore-only resales, or other paths handled entirely off-chain. The platform offers no on-chain affiliate-resale path

### 5. Offering memorandum disclosure (mandatory)

- [ ] The offering memorandum must contain prominent language: _"This security is structured such that no holder will be an affiliate of the issuer. Token holders agree as a condition of subscription that they will not take any action that would cause them to become an affiliate (including acquiring securities such that they hold 10% or more of any class, accepting any office or director position, entering any voting or shareholder agreement with other holders). Any holder who nevertheless becomes an affiliate by operation of law will have their wallet blocked from further transfers in this token contract; their sole U.S. resale paths are registration or another exemption, neither of which the issuer is committed to support."_
- [ ] The subscription agreement contains a binding covenant by each purchaser not to become an affiliate
- [ ] The subscription agreement requires the purchaser to notify the issuer within 5 business days of any event that would cause them to become an affiliate

### Risk acknowledgement

The affiliate-free architecture closes the on-chain Rule 144 affiliate path entirely. If a holder nevertheless becomes an affiliate, the platform BLOCKS them rather than guiding them through Rule 144 conditions. They retain off-chain resale paths (registration, Reg S offshore-only sales, Rule 144A) but cannot use this platform for those resales.

**Trade-off accepted:** zero affiliate trading capability in exchange for dramatic contract simplification.

### If the client later wants affiliate trading capability

See [real_estate_rwa_reg_s_affiliate_addendum.md](real_estate_rwa_reg_s_affiliate_addendum.md) — a separate document that preserves the full Rule 144 affiliate-condition machinery (affiliate category taxonomy, status-transition rules including the Rule 144(b)(1) 3-month tail, the four-sub-gate `canTransfer` logic for affiliate sellers, Rule 144(e) volume cap implementation with group aggregation, Rule 144(c) current-information killswitch, Form 144 filing hook, off-chain → on-chain attestation map). The addendum is not implemented in the base deployment; adopt it only if the client confirms a scenario that requires on-platform affiliate trading (e.g., a strategic institutional holder with board representation). The addendum lists the specific base-guide modifications required if it is adopted.

---

## A. Identity Registry & Investor Whitelist

_Cross-reference: checklist §2.1 (U.S. person definition), §6.3 (KYC controls)_

The on-chain identity registry — implemented using **ERC-3643** (T-REX) or an equivalent **ONCHAINID**-style design — maps every wallet that holds tokens to a verified investor record. This registry is the single source of truth for "who is this wallet and what claims attach to them" that the `canTransfer` hook consults on every transfer.

- [ ] Each wallet that holds tokens must be linked to a KYC-verified investor record in the identity registry
- [ ] Each investor record must store:
  - **U.S.-person status flag** — covering all 8 categories of Rule 902(k)(1) (resident natural persons, U.S.-organized entities, U.S. estates/trusts, U.S.-branch accounts, foreign entities formed by U.S. persons to invest in unregistered securities, etc. — not just citizenship)
  - **Jurisdiction / residency code** — ISO 3166-1 alpha-3
  - **KYC verification timestamp + provider attestation hash** (the cryptographic fingerprint of the KYC dossier the provider signed off on)
  - **Accredited-investor status + Rule 506(c) verification attestation** — for the U.S. tranche: an `accredited` flag (which Rule 501(a) category), plus a **verification record** `{verified: bool, method, providerId, verifiedAt, evidenceHash, expiresAt}` capturing the "reasonable steps to verify" under Rule 506(c)(2)(ii) (income docs, net-worth docs + credit report, or a registered BD / SEC-RIA / attorney / CPA confirmation letter). `verified` alone — not `accredited` alone — is what admits a U.S. person to a `REG_D` mint. Self-certification does not set `verified`. (Also retains the narrow Rule 902(k)(1)(viii) institutional-accredited carve-out relevant to the Reg S side)
  - **OFAC / sanctions screening result set** — see §A.1 below for the full framework. Includes: SDN match flag, crypto-address SDN flag, comprehensively-embargoed jurisdiction flag, 50-Percent-Rule beneficial-ownership flag, last screening timestamp, SDN list version at screening, screening provider ID
  - **Investor classification:** `DISTRIBUTOR` (placement agent's own holding), `NON_US_PERSON` (offshore investor — eligible for `REG_S` partitions), **`US_ACCREDITED_VERIFIED`** (U.S. person, accredited AND verified under Rule 506(c) — eligible for `REG_D` partitions), `US_PERSON_QUALIFIED` (rare — a U.S. person whose Reg S-side purchase did not require registration), `US_PERSON` (U.S. person, not accredited/verified — ineligible for any primary mint), `BLOCKED` (suspended for any reason, including affiliate-creating events or OFAC flag)
- [ ] The identity registry must be **updatable** by an authorized compliance role — investors can become U.S. persons (move residency), lose accredited status, get sanctioned. Status changes propagate immediately to every subsequent `canTransfer` decision
- [ ] The identity registry contract is **separate and upgradeable** independently of the token contract. KYC rules and identity claims can evolve without redeploying the token; the same identity is reusable across multiple security tokens

---

## A.1 — OFAC Sanctions Compliance — Implementation

> **Source authority for this section:** [ofac-checklist.md](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md) — single source of truth for the OFAC sanctions framework (31 CFR Chapter V, SDN List, Executive Orders, program-specific regulations, virtual currency guidance). This section describes only the implementation-specific application of those requirements to the platform; refer to the checklist for: U.S.-person scope, the full landscape of OFAC programs, the SDN/SSI/FSE/non-SDN list inventory, screening provider selection, blocking and reporting workflows, General and Specific License framework, voluntary self-disclosure procedure, virtual-currency-specific guidance, recent crypto enforcement actions, and penalty structure.

### A.1.1 — Why OFAC Applies to This Deployment

The issuer is U.S.-domiciled. Every U.S. person in the transaction chain (issuing SPV, placement agent, KYC provider, smart contract operator, brokers, transfer agents) is subject to OFAC on a **strict liability** basis. OFAC obligations are **independent of and cumulative with** Reg S, Rule 144, and AML — satisfying any of those does not relieve OFAC. See [ofac-checklist.md §1](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md) for the full U.S.-person scope.

### A.1.2 — On-Chain Implementation of the Four Screening Dimensions

The identity registry (Section A) stores the OFAC screening result set covering all four dimensions defined in [ofac-checklist.md §4.1](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md):

| #   | Dimension                                     | Identity registry storage                                                                                                          |
| --- | --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| 1   | SDN identity match                            | `sdnIdentityFlag` + `sdnListVersionAtScreening`                                                                                    |
| 2   | SDN crypto-address match                      | `sdnAddressFlag` (covers both the investor's wallet and any transaction-history exposure score from the screening provider)        |
| 3   | Comprehensive country sanctions               | `jurisdictionCode` + `embargoedJurisdictionFlag` (Cuba, Iran, North Korea, Syria, Crimea, Donetsk, Luhansk, Kherson, Zaporizhzhia) |
| 4   | 50 Percent Rule beneficial-ownership analysis | `aggregatedSDNOwnershipPercent` + supporting attestation hash from compliance officer review                                       |

Any single dimension flagging blocks subscription (in `mint`) and all subsequent transfers (in `canTransfer`).

### A.1.3 — Screening Cadence Implementation

- [ ] **Initial screening at subscription** — `mint` requires a fresh OFAC screening result (within e.g. 30 days) across all four dimensions. Result recorded with timestamp and SDN list version
- [ ] **Continuous re-screening** — off-chain screening provider pulls SDN deltas at least daily and re-screens the full holder population. Newly-flagged holders are written to the identity registry, and `canTransfer` blocks subsequent transfers immediately. Emits `SDNStatusChanged` event
- [ ] **Freshness window enforced in `canTransfer`** — if `block.timestamp - lastOFACScreening > 30 days`, transfers revert with `OFAC_SCREENING_STALE`. No emergency-override path
- [ ] **Pre-distribution re-screening** — `distribute` (revenue payout) re-checks OFAC status before sending; status can change between subscription and distribution

See [ofac-checklist.md §4.2](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md) for full screening cadence requirements and [§9.1](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md) for the OFAC-recommended five-component Sanctions Compliance Program.

### A.1.4 — Blocking and Reporting Workflow

When screening identifies a match (at subscription, during continuous re-screening, or pre-distribution):

- [ ] **Immediate on-chain freeze** — wallet flagged `BLOCKED` in identity registry. All outgoing transfers and incoming distributions revert in `canTransfer`. Tokens remain in the wallet (not seized) but cannot move
- [ ] **`BlockedTransactionRecorded` event** triggers the off-chain workflow to file **TD F 90-22.50 — Report of Blocked Transactions** with OFAC within **10 business days** (per [ofac-checklist.md §6.1](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md))
- [ ] **`BlockedPropertyHeld` event** feeds the **Annual Report of Blocked Property (ARG)** due by September 30 each year (per [ofac-checklist.md §6.3](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md))
- [ ] **No release without OFAC authorization** — `BLOCKED` status can only be cleared by manual compliance officer action with documented OFAC license (General or Specific — see [ofac-checklist.md §7](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md)). On-chain audit trail records the license reference

### A.1.5 — Items NOT Implemented On-Chain (Refer to OFAC Checklist)

| Concern                                                                                                                           | Location                                                                                          |
| --------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| OFAC General License terms (compliance with humanitarian, journalistic, etc. exceptions)                                          | Compliance officer + counsel; see [ofac-checklist.md §7.1](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md)  |
| Specific License applications                                                                                                     | Counsel; see [ofac-checklist.md §7.2](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md)                       |
| Voluntary self-disclosure procedure                                                                                               | Counsel; see [ofac-checklist.md §8](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md)                         |
| Sanctions Compliance Program (SCP) framework — management commitment, risk assessment, internal controls, testing/audit, training | Firm-level; see [ofac-checklist.md §9.1](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md)                    |
| 5-year sanctions records retention (31 CFR § 501.601)                                                                             | Off-chain compliance database; see [ofac-checklist.md §6.4](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md) |

### A.1.6 — Penalty Exposure (Founder-Level Awareness)

Civil: up to the greater of ~$311,562 per violation (2024) or 2× transaction value, strict liability. Criminal (willful): up to $1M and 20 years per individual violation. Plus reputational and banking-relationship consequences. See [ofac-checklist.md §10](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md) for the full penalty framework and recent crypto enforcement comparables.

The offering memorandum discloses the OFAC compliance framework; the compliance officer receives mandatory OFAC training; OFAC penalty exposure is included in the firm's risk register and D&O insurance scope.

---

## B. Transfer Validation — `canTransfer` / `canTransferByPartition`

_Cross-reference: checklist §3.2 Category 3, §6.3 (Investor Verification & KYC Controls)_

The ERC-1594 `canTransfer` hook (and its partition-aware counterpart `canTransferByPartition`) is the on-chain enforcement point for every Reg D 506(c), Reg S, and Rule 144 rule. It runs before every transfer and either allows it or reverts with a specific reason code, **dispatching on the partition's `tranche` type** (`REG_D` vs `REG_S`). ERC-1066 status codes are used where they apply, so wallets and explorers can display human-readable rejection reasons.

The hook enforces, by tranche:

- **Rule 506(c) conditions** (`REG_D` partitions) — the recipient must be `US_ACCREDITED_VERIFIED` for a primary mint or an in-tranche holding transfer; there is no Reg S distribution compliance period on a `REG_D` partition
- **Rule 903 conditions** (`REG_S` partitions, issuer-side safe harbor) — applies at mint and to any transfer from the issuer, a distributor, or any of their affiliates. The Rule 903 path is the primary issuance path through `mint` (§I)
- **Rule 904 conditions** (`REG_S` partitions, offshore-resale safe harbor) — applies to peer-to-peer secondary transfers by non-issuer holders. Rule 904's universal conditions are enforced through these gates: (a) the offshore-transaction prong (Rule 902(h)) is enforced via the U.S.-person check below — the sale is not made to a person in the U.S.; (b) the "no directed selling efforts by the seller" condition is captured as a binding covenant in the Subscription Agreement (§E Document 4) and is not on-chain enforceable — relies on the seller's covenant plus off-chain monitoring; (c) the Rule 904(b)(1) dealer-confirmation notice requirement is handled via the `DistributorConfirmationRequired` event (§H) routed to the placement agent's off-chain workflow
- **Rule 144 conditions** (both tranches) — restricted-securities resale into the U.S., §D

The hook returns `false` (reject) when:

- [ ] Recipient is **not in the identity registry** (no KYC) → reason: `"NO_KYC"`
- [ ] **[`REG_S` partition]** Recipient is a **U.S. person** AND the sender-partition's compliance period has not expired (`closeDate == max` OR `block.timestamp < closeDate + 12 months`) AND recipient is not classified as `DISTRIBUTOR` → reason: `"REG_S_US_PERSON_RESTRICTED"`. This is the core Rule 903(b)(3)(iii)(A) gate; an unset `closeDate` (`max`) blocks until the partition's distribution closes (Section C). **This gate does NOT apply to `REG_D` partitions**
- [ ] **[`REG_D` partition]** Recipient is a **U.S. person who is NOT `US_ACCREDITED_VERIFIED`** (accredited AND verified under Rule 506(c)(2)(ii)) → reason: `"REG_D_NOT_VERIFIED_ACCREDITED"`. A single non-verified U.S. purchaser breaks 506(c) for the tranche. (After the Rule 144 holding period clears, a non-affiliate resale may go to a broader set — §D — but primary mints and in-tranche transfers require verified-accredited status)
- [ ] Recipient or sender is **OFAC-flagged** in the identity registry — covering any of the four OFAC failure modes from §A.1.2: (1) SDN-listed identity, (2) SDN-listed wallet address, (3) comprehensively-sanctioned country of residence (Cuba, Iran, North Korea, Syria, Crimea/Donetsk/Luhansk/Kherson/Zaporizhzhia), or (4) 50%+ aggregated ownership by SDN-listed persons. Strict liability — check applies on both sender AND recipient on every transfer → reason: `"OFAC_BLOCKED"`. Stale OFAC screening (>30 days old) also rejects → reason: `"OFAC_SCREENING_STALE"`
- [ ] Sender is flagged `BLOCKED` (covers any holder who became an affiliate by operation of law under the affiliate-free architecture) → reason: `"SENDER_BLOCKED"`
- [ ] Sender or recipient identity record has **stale KYC** beyond the re-verification window (e.g., 12 months since last KYC refresh) → reason: `"KYC_EXPIRED"`
- [ ] Transfer is **for the account or benefit of a U.S. person** — pure on-chain detection is impossible; the hook requires either (a) an EIP-712 signed attestation by the compliance officer for transfers above a threshold, or (b) a beneficial-ownership claim recorded in the identity registry — see Section L for the off-chain → on-chain pattern
- [ ] Transfer would breach the **Rule 144 holding period** for a U.S.-person recipient relying on Rule 144 (12 months for this non-reporting issuer) — see Section D
- [ ] Transfer would push the **recipient's aggregate balance over 9.99% of the token's total supply across all partitions** (concentration cap; enforces the affiliate-free architecture) → reason: `"CONCENTRATION_CAP_EXCEEDED"`. The cap is checked against the sum of balances across all wallets **and all partitions** linked to the recipient's identity in the registry — the class-level aggregate, not just the destination wallet or partition

Return codes follow ERC-1066 (Ethereum Status Codes) where possible for explorer and wallet compatibility.

---

## C. Distribution Compliance Period Logic — Per-Partition `closeDate` (Rule 902(f))

_Cross-reference: checklist §3.2 Category 3 equity (Rule 903(b)(3)(iii)(A)), §2.4 (Rule 902(f) distribution compliance period definition)_

> **Scope: this section governs `REG_S` partitions only.** The Reg S distribution compliance period is a Regulation S concept. `REG_D` partitions (Rule 506(c), U.S. accredited) have **no** distribution compliance period — their `closeDate` field is unused (`type(uint256).max`) and the Reg S U.S.-person gate never fires for them; a `REG_D` holding is gated by 506(c) eligibility at issuance (Section B / the Reg D section) and by Rule 144 for U.S. resale (Section D). Everything below applies to `REG_S` partitions.

**Core model — one field, one gate, no modes.** A **`REG_S` partition is an offering**, and its **`closeDate` is the start of that offering's Reg S distribution compliance period**. The compliance period for a partition runs `closeDate → closeDate + 12 months` (`isReportingIssuer = false` → 1-year branch; the 6-month branch would only apply if the issuer were a public reporting company). There is **no separate global variable and no "continuous vs. tranche" branching** — there is one field, `partition.closeDate`, and `canTransfer` uniformly reads the **sender's partition's** value (it does NOT hardcode any partition index).

- [ ] **Storage on-chain: `closeDate` per partition.** Semantics: the date that partition's distribution closed under Rule 902(f) — the LATER of first-offer-to-non-distributors or the close; the close controls in normal primary offerings
- [ ] **Unset sentinel = `type(uint256).max` (NEVER `0`).** A partition whose distribution has not closed carries `closeDate = type(uint256).max`, so `closeDate + 12 months` never arrives and the Reg S gate blocks ALL U.S.-person transfers of that partition's tokens. The sentinel — not a mode flag — is what makes the gate uniform and **fails safe**. `0` would fail OPEN (`0 + 12mo` is ancient history → the check passes → U.S. transfers allowed before the period starts → Section 5 violation). Use `max`
- [ ] Storage on-chain: an `isReportingIssuer` boolean — hard-coded `false` until/unless the issuer later registers under the Exchange Act. The boolean stays in the contract so the same code can serve a future reporting-issuer deployment without redeployment

**`closeDate` gets its value one of two ways — same field, same gate, only the timing of the write differs:**

- [ ] **Set at partition creation (defined tranche — Rule 902(f)(1)):** if the tranche has a firm, contractually-fixed (future) close date, write `closeDate` at `createPartition`. Mints are accepted until that date arrives. Used by an issuer running a scheduled multi-tranche offering
- [ ] **Filled later via `setCloseDate` (continuous / unknown close — Rule 902(f)(2)):** if the close is not known up front — e.g. a continuous offering that ends "upon full placement or earlier termination by issuer" — the partition is created with `closeDate = max`, and the compliance officer calls `setCloseDate` with a (near-future) cutoff when the distribution completes (the Rule 902(f)(2) completion-of-distribution determination — made by the **issuer** as the person performing the managing-underwriter function in a direct offering, or backed by the **placement agent's off-chain certification** when an agent is engaged) via a **multi-sig-gated** governance write. **No on-chain placement-agent signature is required** — the cert is off-chain; an optional emit-only `completionCertHash` (keccak256 of that cert doc) anchors it for audit. Mints stop when that cutoff arrives. Emits `CloseDateSet(partition, closeDate)` (+ `CompletionCertified(partition, completionCertHash)` when a hash is supplied). **A continuous offering is simply a tranche whose `closeDate` is filled in later — typically a single partition.** This is the client's current whitepaper structure

**On-chain constraints when writing `closeDate` (these prevent a Section 5 under-restriction bug). The whole ruleset collapses to two invariants plus one corollary:**

- [ ] **(1) `closeDate` must be NOW or a future date when written** — `require(closeDate >= block.timestamp)`, enforced both at `createPartition` and in `setCloseDate`. The only forbidden value is a **past** date; that is the precise safety boundary. A past `closeDate` is the backdating attack — `closeDate + 12 months` could already be expired, opening the gate for tokens that never served a lockup. `closeDate == now` is safe (it yields a full 12-month period) and is the natural "close the distribution right now" write for a continuous offering: mints stop in that same block. This rule eliminates backdating by construction and subsumes "`closeDate >= latest mint`" — see invariant (2)
- [ ] **(2) `mint` is allowed iff `block.timestamp < closeDate`** (an unset `closeDate == max` → always allowed until set). Once the date **arrives** (`block.timestamp >= closeDate`), `mint` into that partition reverts — **no sales after the close**. New subscriptions go into a fresh partition. Note the trigger is the date _arriving_, NOT the value being _set_ — a future `closeDate` set at creation still allows mints until it arrives
- [ ] **Corollary — `closeDate` is mutable only while still in the future.** `setCloseDate` may update the value (extend later, or pull in to an earlier _still-future_ date) ONLY while `block.timestamp < closeDate`. Once the date has been reached it is **immutable** — updating a period that has already started would un-start or shift it. Both update directions are safe while future, because invariant (2) makes whatever date you land on the genuine close (no mints occur past it)
- [ ] **⚠️ The indefinite-restriction trap (surface to the client and counsel):** for a "filled later" (continuous) partition, if the compliance officer never writes the `closeDate`, it stays `max` and **every token in that partition is permanently restricted from U.S.-person resale** — the period never starts. An under-subscribed offering left open indefinitely freezes all U.S. resale paths forever. **Mitigation:** the placement agreement MUST obligate the completion certification on a defined trigger (full placement OR termination), and the offering documents should set a **long-stop date** at which the offering auto-terminates and `closeDate` is written regardless of placement level. Without a long-stop, "earlier termination by issuer" places the period start under unilateral issuer discretion — an SEC substance-over-form concern (cf. reg-s-checklist §10.2)

**During and after the compliance period:**

- [ ] While the partition's offering is open (`closeDate` not yet set, or not yet arrived), `canTransfer` enforces all of Section B's checks plus: (a) distributor confirmation event when a token goes to a known dealer / selling-concession recipient (Rule 903(b)(3)(iv)) — emits `DistributorConfirmationRequired`; (b) buyer recertification event when tokens move to a new wallet during the offering — the new holder reaffirms non-U.S.-person status (Rule 903(b)(3)(iii)(B)(1))
- [ ] **After** a partition's compliance period expires (`closeDate + 12 months`), U.S.-person transfers of that partition's tokens become eligible for Rule 144 analysis, but the **restricted-securities status persists indefinitely** — see Section D
- [ ] **Rule 144 holding-period clock is SEPARATE and per-holder** — see Section D. It is keyed to each holder's full-payment date (`acquisitionTimestamp`), NOT to `closeDate` and NOT to the mint event. Because `closeDate` is never in the past when written and mints stop once it arrives (invariants 1–2 above), every lot's payment date precedes `closeDate`, so the Reg S gate (`closeDate + 12mo`) always clears at or after every lot's Rule 144 gate (`acquisitionTimestamp + 12mo`) — **the Reg S `closeDate` gate is always the binding constraint**, and the per-lot Rule 144 clock is audit-only on-chain (Section D)

> **What partitions are for here:** (1) the Reg S compliance-period container — one `closeDate` per partition; (2) distribution snapshots and reporting. A continuous offering uses a single partition; a scheduled multi-tranche offering uses one partition per tranche. The Rule 144 per-holder clock is tracked separately (audit record / event log — Section D), not by the partition's `closeDate`.

> **Client conversation point:** A continuous offering (single partition, `closeDate` filled at completion) means every U.S.-resale clock is pinned to ONE future completion event the issuer/placement agent controls — early subscribers wait the full remaining offering period PLUS 12 months. A scheduled multi-tranche offering (one partition per close) lets early tranches start their clocks sooner — better subscriber liquidity, but requires the issuer to commit to defined closes and to amend the whitepaper to describe the tranche structure. Confirm which the client wants; the placement agreement must commit the agent to write each `closeDate` on a defined trigger with a long-stop backstop.

---

## D. Permanent Restricted-Securities Status — Rule 144 (both tranches)

_Cross-reference: [rule-144-checklist.md](../sales-marketing/Service/Content/US%20Compliance/rule-144-checklist.md) §5 (holding period), [reg-s-checklist.md §5](../sales-marketing/Service/Content/US%20Compliance/reg-s-checklist.md) (Rule 905), [reg-d-checklist.md §7.4](../sales-marketing/Service/Content/US%20Compliance/reg-d-checklist.md) (Rule 502(d) restricted securities)_

**BOTH tranches produce restricted securities → Rule 144 governs U.S. resale of every token.** They arrive at restricted status by different doors:

- **`REG_D` tokens** — restricted **directly** under **Rule 502(d)**: securities sold in a Reg D transaction are restricted securities, full stop
- **`REG_S` tokens** — restricted via the **Rule 905** bridge: domestic-issuer equity sold under Reg S is deemed a "restricted security" under Rule 144(a)(3)(v)

Either way the consequence is the same and **permanent**: the restricted label persists for the life of the security (the compliance period is time-limited; the restricted status is not), and any U.S. resale requires the **Rule 144 holding period** (12 months, non-reporting), registration, or another exemption. The Rule 144 machinery below (per-holder `acquisitionTimestamp` = full-payment date, tacking, the affiliate-free non-affiliate path) applies **identically to both tranches**. The ONE difference is the extra Reg S gate:

- On a **`REG_D` partition**, Rule 144 is the **only** U.S.-resale gate — there is no Reg S compliance period.
- On a **`REG_S` partition**, a U.S. resale must clear **both** the Reg S compliance period (`closeDate + 12 months`, Section C) **and** Rule 144 — and the `closeDate` clock is the binding one (see the alignment bullet).

**Why does Rule 144 apply at all?** Neither exemption "chooses" it — each *produces* restricted securities by operation of law (Rule 502(d) for Reg D; Rule 905 for Reg S). Reg D / Reg S govern the primary offering; Rule 144 governs the subsequent U.S. resale. An investor asking "why can't I just sell to my U.S. friend after 12 months?" is asking a Rule 144 question in either tranche.

Under the affiliate-free architecture, every holder is by structural commitment a **non-affiliate**. Rule 144's clean non-affiliate path (Rule 144(b)(1)(ii) for non-reporting issuers) applies: after the holding period clears (12 months from the holder's own **acquisition date** — the date they paid in full and assumed the investment risk — with automatic Rule 144(d)(1)(ii) tacking inherited on secondary transfers), a non-affiliate can resell to U.S. persons with no volume cap, no manner-of-sale restriction, no current-information requirement, no Form 144. **On a `REG_D` partition that is the whole U.S.-resale test.** On a **`REG_S` partition**, the sale must ALSO wait for the Reg S compliance period (`closeDate + 12 months`, Section C) — the two conditions clear at different times and the `closeDate` clock binds; see the alignment bullet below.

- [ ] **Per-acquisition-lot storage on-chain: `acquisitionTimestamp`** (= the date the acquirer **paid in full and assumed the economic risk** of the investment — Rule 144(d)(1)). This is NOT the contract's mint event: under [rule-144-checklist.md §5.1](../sales-marketing/Service/Content/US%20Compliance/rule-144-checklist.md), "the holding period shall not begin until full purchase price or other consideration is paid by the acquirer." For a rolling subscription, each investor pays on a different date, so each primary acquisition carries its own `acquisitionTimestamp`. The Rule 144 clock is therefore **per holder, not shared across a partition** — different subscribers in the same offering can clear their holding period on different dates
- [ ] **Tacking travels with the tokens (Rule 144(d)(1)(ii)).** On a non-affiliate-to-non-affiliate transfer, the receiver does NOT get a fresh clock — the tokens carry their existing `acquisitionTimestamp` to the new holder, tracing back to the original acquisition from the issuer. Implementation: model each primary acquisition as its own **ERC-1410 (sub)partition (lot)** whose `acquisitionTimestamp` is intrinsic and immutable; when tokens move, they stay in their lot and carry the timestamp automatically. This makes "per-holder acquisitionTimestamp with tacking" fall out of the partition machinery without separate per-wallet bookkeeping
- [ ] **Mixed-date wallet handling.** A wallet may hold tokens from multiple lots acquired on different dates (the same investor subscribes twice, or subscribes once and receives a tacked transfer). Each lot has its own `acquisitionTimestamp` and therefore its own Rule 144 `holdingEnd`. On a partial sale, the lot being sold determines the applicable date. Use **FIFO** (oldest lot first) for precision, or the **conservative rule** (gate the whole balance on the latest lot's date — over-restrictive but simplest). **Never gate on the earliest lot — that would let newer tokens sell before their true Rule 144 date (under-restrictive, legal risk)**
- [ ] **Do you actually need a FIFO slot/consumption engine? With the not-in-the-past `closeDate` (Section C) — NO.** Because the Reg S `closeDate` gate is binding and does not open until `closeDate + 12 months`, and `closeDate` is never in the past while mints stop once it arrives (so every lot's payment precedes `closeDate`), every lot has already cleared its own 12-month Rule 144 clock by the time the Reg S gate opens. There is no reachable state where a U.S. transfer is permitted while any lot is still inside its Rule 144 window. **So the per-lot distinction never changes a `canTransfer` outcome.** You should still **capture `acquisitionTimestamp` per acquisition** (a cheap record / event-log entry — needed for audit, legal proof, and the wash trail), but you can **skip the FIFO consumption engine**. Build the full slot engine ONLY if a partition uses **escrow-until-close with the Rule 144 clock as a binding gate**, or other structures where lot precision actually decides a transfer
- [ ] **Rule 144 clock and Reg S compliance period clock do NOT align — Reg S is the binding constraint.** Two distinct values gate a U.S.-person resale: (a) the **Reg S** gate, `block.timestamp >= senderPartition.closeDate + 365 days` (per partition — Section C); and (b) the **Rule 144** gate, `block.timestamp >= lot.acquisitionTimestamp + 365 days` (per acquisition lot / per holder, with tacking). Because `closeDate` is never in the past when written and no mints occur after it arrives (Section C invariants 1–2), every lot's `acquisitionTimestamp` (a payment) precedes `closeDate`, so `closeDate >= every lot.acquisitionTimestamp` — and the Reg S gate always clears at or after the Rule 144 gate **for every lot in the partition**. **Practical result: the Reg S `closeDate` gate is always the operative blocker.** By the time it clears, every lot's Rule 144 holding period has already cleared. Gate 3 (Rule 144) is therefore never the binding check, but it is RETAINED because (i) it maps to a distinct source regulation for the audit trail, and (ii) the **Rule 144 holding period — not the Reg S period — governs whether a non-affiliate U.S. resale "washes" the restricted-securities label off the buyer's tokens** (Rule 905 / Rule 144 wash). The two gates would align and clear simultaneously only with **escrow-until-close settlement** (tokens released and full payment deemed made at the close), where every holder's `acquisitionTimestamp` equals the partition's `closeDate`
- [ ] `canTransfer` checks for a U.S.-person recipient not relying on registration/other exemption: BOTH (a) `senderPartition.closeDate != type(uint256).max AND block.timestamp >= senderPartition.closeDate + 365 days` (Reg S — the binding gate; an unset `closeDate` blocks) AND (b) `block.timestamp >= lot.acquisitionTimestamp + 365 days` for the lot(s) being transferred (Rule 144 — always already satisfied once the Reg S gate clears, but checked for audit-trail completeness and to confirm the wash applies)
- [ ] **No affiliate-seller branching needed in `canTransfer`** — under the affiliate-free architecture, the identity registry never carries an "affiliate" classification. Any holder who becomes an affiliate by operation of law is flagged `BLOCKED` instead, and the affiliate path is closed entirely. The full Rule 144 affiliate-seller conditions (volume cap, manner-of-sale, current public information, Form 144) are described in [rule-144-checklist.md](../sales-marketing/Service/Content/US%20Compliance/rule-144-checklist.md) §§ 6–9 — referenced for completeness but not implemented in this contract

> **Implementation decision — this platform (MVP): conservative per-holder-per-partition `holdingEnd`, no on-chain lots.** The per-acquisition-lot model above is the _regulatory reference_. The on-chain implementation is a conservative simplification that the not-in-the-past `closeDate` (Section C) makes exact:
>
> - **Stored field = `issuanceTimestamp` (the mint timestamp), not a separately-captured full-payment date.** It is used as a **conservative proxy** for the Rule 144(d)(1) acquisition (full-payment) date. Valid because issuance always follows full payment in this architecture — USDT `purchaseByPartition` pulls payment and mints atomically (payment == mint); fiat `issueByPartition` mints only after off-chain settlement (payment precedes mint) — so the mint date is always **≥** the true acquisition date (conservative, never under-restrictive). The precise full-payment date lives in the off-chain subscription/settlement record (the SEC evidence file pairs the on-chain mint event with the off-chain payment confirmation). **Guardrail:** if any future deployment mints **before** payment (installments / promissory notes), this proxy is invalid and the real payment date must be supplied (e.g. via `data`).
> - **On-chain Rule 144 state = one conservative `holdingEnd` per holder PER PARTITION — `holdingEnd[holder][partition]`.** Because transfers are `transferByPartition` (tokens move within a specific partition), and each partition snapshots its own `holdingPeriod` at creation (different partitions can have different periods), the Rule 144 clock must be scoped to the partition being transferred. A single global `holdingEnd[holder]` across all partitions would bleed a longer-period partition's clock onto tokens in a shorter-period partition — blocking a sale in P1 because the holder also holds tokens in P2 with a longer clock. That is not legally required and is unfair. The correct mapping is `holdingEnd[holder][partition]`, raised **monotonically** on every acquisition into that partition — `holdingEnd[holder][partition] = max(stored, block.timestamp + partition.holdingPeriod)` — and **never lowered**. On transfer-in, tacking is applied within the same partition: `holdingEnd[to][partition] = max(holdingEnd[to][partition], holdingEnd[from][partition])`. Per-acquisition `issuanceTimestamp`s are emitted in events; true per-lot detail is reconstructed **off-chain** by the indexer for the audit trail and the wash determination — no on-chain lot storage, no FIFO consumption engine.
> - **Accepted trade-off (within a partition).** An investor who acquires the same partition more than once has her earlier lots in that partition locked until her latest lot in that partition clears (up to one extra `holdingPeriod` within the partition). Tokens in other partitions are unaffected. This is **legally safe** — an issuer may always impose a longer hold than Rule 144 requires; over-restriction within a partition is never a violation — and a minor liquidity/UX cost, surfaced in the investor UI ("your \<partition\> holding unlocks on \<latest-lot date\>").
> - **When to add on-chain per-lot + FIFO.** Only if the client requires **precise per-lot liquidity within a partition** (selling each lot the moment it individually clears), or adopts a structure where the Rule 144 clock becomes the **binding** gate (e.g. escrow-until-close). Neither holds for the continuous / defined-tranche `closeDate` model here, where the Reg S gate always clears last — so the per-holder-per-partition conservative `holdingEnd` changes no outcome. Defer the lot engine until a client insists.

---

## E. Legends & Documents — ERC-1643

_Cross-reference: checklist §3.2 Category 3 (B)(3), §6.2 (Legend Requirements)_

ERC-1643's document registry is a standardized way for the token to publish references to legal documents. Each document is registered as a (name, URI, hash) triple — the URI points to the document's hosted location, the hash is the cryptographic fingerprint that lets any reader verify they're looking at the authentic version. The platform publishes the following:

- [ ] **Document 1: Reg S unregistered-securities legend** — _"The securities … have not been registered under the U.S. Securities Act of 1933, as amended, and may not be offered or sold in the United States or to U.S. persons (other than distributors) unless registered under the Act or an applicable exemption from registration is available."_
- [ ] **Document 2: Hedging-restriction legend** — _"Hedging transactions involving these securities may not be conducted unless in compliance with the U.S. Securities Act of 1933."_
- [ ] **Document 3: Transfer-restriction legend** (Cat 3 domestic equity) — transfer prohibited except per Reg S / registration / exemption. Applies to `REG_S` tokens
- [ ] **Document 3b: Reg D restricted-securities legend** (Rule 502(d)) — for `REG_D` tokens: _"These securities have not been registered under the Securities Act of 1933 and are 'restricted securities' within the meaning of Rule 144. They may not be offered, sold, pledged, or otherwise transferred except pursuant to registration or an available exemption (including Rule 144)."_ The two tranches carry different legends; the ERC-1643 document bound to a holding is selected by the partition's `tranche` type
- [ ] **Document 4: Subscription / Purchase Agreement template hash** — the cryptographic fingerprint of the executed agreement template, with purchaser certifications and resale covenants. Two templates: the Reg S offshore subscription agreement (`REG_S`) and the Reg D 506(c) accredited-investor subscription agreement with accreditation representations and the Rule 502(d) restricted-securities acknowledgement (`REG_D`)
- [ ] **Document 5: Property-specific PPM / offering memorandum** — for real estate, the underlying property due diligence package (title, environmental, lease roll, appraisal)
- [ ] Documents are **versioned** — `setDocument` emits an event with the publication timestamp so off-chain readers can reconstruct the full disclosure history. Prior versions are never deleted — investors and regulators can always inspect what was disclosed at any prior moment

---

## F. Transfer Refusal Enforcement — ERC-1644

_Cross-reference: checklist §3.2 Category 3 (B)(4) (Rule 903(b)(3)(iii)(B)(4))_

Rule 903(b)(3)(iii)(B)(4) requires the issuer to **refuse to register transfers** not made per Reg S / registration / exemption. The ERC-1644 controller-operations module gives the issuer the on-chain powers to do so:

- [ ] **Default rejection in `canTransfer`** — a non-compliant transfer reverts before it takes effect. No off-chain transfer registry can override the on-chain rejection
- [ ] **`controllerTransfer` / `controllerRedeem`** — the issuer can force-reverse a non-compliant transfer that somehow went through (e.g., compromised signer, smart-wallet exploit, governance error). Exercise of this power requires the controller key, which is a multi-sig + time-lock account
- [ ] **Force-burn and re-issue** capability for clearly fraudulent transfers — same governance constraints
- [ ] Controller powers are **disclosed in Document 4** (the Subscription Agreement). Purchasers consent to the controller's reversal authority as a condition of subscription

---

## G. Hedging Prohibition Detection

_Cross-reference: checklist §3.2 Category 3 (B)(2)_

The Reg S Category 3 hedging restriction prohibits hedging transactions during the compliance period. Some of this is enforceable on-chain, some requires off-chain monitoring:

- [ ] On-chain blocklist of known derivatives venues, lending protocols, and wrapped-token contracts. The compliance role maintains the list; transfers to any address on the list are rejected in `canTransfer` during the compliance period
- [ ] Record the hedging covenant as the `HEDGING_COVENANT` certification (via `setCertifications`, emitting `PurchaserCertified(wallet, HEDGING_COVENANT, attestationHash)`) when a purchaser signs their subscription — creates an on-chain audit trail of the investor's acknowledgement. (No bespoke `HedgingRestrictionAcknowledged` event — folded into the dynamic certification mechanism, Story 1.4)
- [ ] Block transfers to contracts flagged as short-position venues during the compliance period — same blocklist mechanism
- [ ] Block deposits into wrap contracts (e.g., bridging to a synthetic short via a wrapper that mints a transferable representation) — wrap contracts effectively transfer beneficial ownership and would be a hedging route around the on-chain rule

---

## H. Events for Off-Chain Monitoring

_Cross-reference: checklist §6.4 (Monitoring During the Distribution Compliance Period)_

On-chain compliance monitoring depends on rich, structured events emitted by the token and identity registry. The platform emits:

- [ ] `TransferAttempted(from, to, partition, amount, reasonCode, allowed)` — emitted on every transfer attempt, including rejected ones, so off-chain monitoring can detect probing patterns (e.g., sanctioned wallets repeatedly trying to receive tokens)
- [ ] `ClaimChanged(investor, claimType, value, attestationHash)` — emitted on every single-claim write (`setClaim`) and per-claim in a batched write (`setIdentityClaims`); for compliance audit and claim history
- [ ] `KYCVerified(investor, kycVerifiedAt, attestationHash)` — emitted once per `setIdentityClaims` call to record the KYC timestamp; routes to KYC onboarding history (distinct from claim changes)
- [ ] `SanctionsScreeningCompleted(investor, screenedAt, screeningHash)` — sanctions trail; `screeningHash = keccak256` of the full off-chain screening record (provider, list version, 4 OFAC dimensions, result — whatever the caller has). Emit-only, not stored on-chain. An auditor re-hashes the off-chain `sdn_screenings` record to verify provenance (same pattern as `attestationHash` in `ClaimChanged`/`KYCVerified`, ADR-1400-9)
- [ ] `SDNStatusChanged(investor, oldStatus, newStatus, listVersion)` — emitted when an existing holder is newly added to OR removed from the SDN list during continuous re-screening. Triggers immediate freeze (added) or release (removed, subject to OFAC license requirements per §A.1.5)
- [ ] `BlockedTransactionRecorded(party, counterparty, transactionType, amount, partition, reasonCode, timestamp)` — emitted every time a transfer is rejected for OFAC reasons. Feeds the off-chain workflow for filing TD F 90-22.50 (Report of Blocked Transactions) with OFAC within **10 business days** of the blocking event (§A.1.4)
- [ ] `BlockedPropertyHeld(holder, partition, amount, blockingDate)` — emitted on the original blocking event and tracked for the Annual Report of Blocked Property due September 30 each year (§A.1.4)
- [ ] `DistributorConfirmationRequired(distributor, downstreamDealer, partition)` — triggers the off-chain Rule 903(b)(3)(iv) confirmation notice workflow at the placement agent
- [ ] `ComplianceFlagRaised(holder, flagType, evidence)` — when off-chain monitoring detects a suspicious pattern (e.g., a wallet receiving tokens from a known mixer)
- [ ] `CloseDateSet(partition, closeDate)` — emitted when a partition's `closeDate` is written (at creation for a defined tranche, or filled later by the compliance officer at completion of distribution — Section C). For a "filled later" (continuous) partition this is the single most consequential event in the contract's life: it starts that partition's Reg S compliance clock. Off-chain monitoring should alert if a continuous partition has been open beyond the long-stop date without this event firing (the indefinite-restriction trap, Section C)
- [ ] `PartitionComplianceExpired(partition, timestamp)` — emitted when a partition's distribution compliance period ends (`closeDate + 12 months`); signals that U.S.-person secondary trading of that partition's tokens under Rule 144 is now possible (every holder's Rule 144 `holdingEnd[holder][partition]` having already cleared by this point — mints stop once `closeDate` arrives, so each acquisition's `issuanceTimestamp` precedes `closeDate`)
- [ ] `RestrictedSecuritiesNoted(holder, partition, amount)` — emitted on every U.S.-person sale post-compliance-period to flag the Rule 144 tracking obligation
- [ ] `FirstSaleRecorded(tranche, timestamp)` — emitted on the first mint in each tranche. For `REG_D` it starts the **15-day Form D** filing clock (Rule 503); the off-chain compliance team must file on EDGAR within 15 calendar days. Also feeds the state notice-filing workflow (Section 18 covered-security notices)
- [ ] `AccreditationVerified(investor, method, providerId, expiresAt, evidenceHash)` — emitted when a 506(c) verification record is written to the registry; the audit trail proving "reasonable steps to verify" for every `REG_D` purchaser (Rule 506(c)(2)(ii))

These events form the SEC evidence file. Every off-chain monitoring tool and every future SEC inquiry will reconstruct compliance posture from this event stream.

---

## I. Subscription / Mint Flow

_Cross-reference: checklist §6.1 (Pre-Offering Documentation), §6.3 (Investor Verification)_

Initial issuance happens through the `mint` function (or its partition-aware equivalent). **The mint path dispatches on the target partition's `tranche` type:**

- **`REG_D` mint (Rule 506(c), U.S. accredited)** — see §I.1 below.
- **`REG_S` mint (Rule 903, offshore)** — must satisfy the Rule 902(h) offshore-transaction test, detailed immediately below.

**Requirements common to BOTH tranches** (checked at every mint regardless of partition): recipient is in the identity registry (else reject); OFAC screening fresh (§A.1); recipient not `BLOCKED`; the **9.99% class-wide concentration cap** holds (aggregated across BOTH tranches — it is one class); the **Rule 144 acquisition anchor** (`acquisitionTimestamp` = full-payment date) is recorded; and the property record is linked. These are listed once at the end of this section.

### I.0 — `REG_S` mint (Rule 903 offshore-transaction test)

Every `REG_S` primary sale must satisfy the **Rule 902(h) two-prong offshore-transaction test**:

- **Prong A** — the offer is not made to a person in the United States. Enforced via the recipient U.S.-person check (item below). Implicit in the identity-registry classification: the recipient must not be flagged `US_PERSON` (unless qualified under the narrow U.S.-person carve-out)
- **Prong B** — at the time the buy order is originated, the buyer is outside the United States, or the seller reasonably believes so. **Rule 902(h)(1)(ii) lets the issuer, a distributor, or any person acting on their behalf form that reasonable belief — a separate placement agent is NOT required.** Who forms it depends on the offering structure:
  - **Direct offering (no broker-dealer placement agent):** the **issuer** forms the belief. Enforced on-chain via the **non-U.S. KYC determination** (the recipient is not flagged `US_PERSON`, set by the KYC source from KYC + declared location) **plus the investor's own EIP-712 offshore-purchaser certification** (item below). No separate agent signature is manufactured where no agent exists. This is the default platform configuration (`placementAgent` unset).
  - **Agent-mediated offering:** when the deal genuinely uses a placement agent, the agent's contemporaneous reasonable belief is **additionally** captured via the **optional** EIP-712 mint-authorization attestation (per §L.1 item 6), enforced on-chain only when a `placementAgent` signer is configured.
    Either way Prong B is enforced before mint; the agent attestation is an additional layer for agent-mediated deals, not a universal precondition.

**Rule 902(h)(2) exclusion — U.S. citizens abroad:** offers and sales specifically targeted at identifiable groups of U.S. citizens abroad (e.g., U.S. armed forces personnel serving overseas) are NOT offshore transactions, regardless of physical location. Distribution channels must not specifically target U.S. citizens abroad as a class. This is enforced through marketing policy (§J) and the placement agent's binding representations in its placement agreement.

Before any tokens are minted, the platform must verify:

- [ ] Signed off-chain subscription agreement hash present — the cryptographic fingerprint of the executed agreement is recorded
- [ ] Purchaser-classification proof — either a Merkle proof against the published subscription whitelist, or an oracle attestation from the KYC provider (see Section L for the mechanism trade-offs)
- [ ] Signed certification that the purchaser is not a U.S. person AND not acquiring for U.S. account/benefit, OR is a U.S. person whose purchase did not require registration (Rule 903(b)(3)(iii)(B)(1)) — typically an EIP-712 signed message from the investor
- [ ] **Resale-restriction and hedging covenant from purchaser** (Rule 903(b)(3)(iii)(B)(2)) — the executed Subscription Agreement (§E Document 4) contains the purchaser's binding covenant to (a) resell only in accordance with Reg S, registration, or another exemption, AND (b) not engage in hedging transactions unless in compliance with the Securities Act. The platform records the agreement hash; the covenant itself is enforced via legal recourse, not via on-chain check
- [ ] **(Only when an offering uses a placement agent — OPTIONAL, `placementAgent` configured)** EIP-712 mint-authorization attestation by the placement agent (Rule 902(h) Prong B) — fresh within its deadline window; signed by the placement agent's compliance signer; attests to the offshore-buyer reasonable belief based on KYC + IP geolocation + declared location at order origination. **For a direct offering this row does not apply** — Prong B rests on the non-U.S. KYC determination + the investor's own offshore certification (issuer forms the 902(h)(1)(ii) belief)

### I.1 — `REG_D` mint (Rule 506(c) verification)

A `REG_D` primary sale has NO offshore test and NO distribution compliance period; the gate is **verified accredited status**:

- [ ] **Recipient is `US_ACCREDITED_VERIFIED`** — the identity record carries both the `accredited` flag (a Rule 501(a) category) AND a completed **verification record** (`verified = true`, not expired). Self-certification does NOT satisfy this; `mint` reverts with `REG_D_NOT_VERIFIED_ACCREDITED` otherwise (Rule 506(c)(2)(ii))
- [ ] **Verification attestation present and current** — `{method, providerId, verifiedAt, evidenceHash, expiresAt}` recorded in the registry (income docs / net-worth docs + credit report / registered BD-RIA-attorney-CPA letter). Verification is time-bounded; a stale verification (`block.timestamp > expiresAt`) reverts with `REG_D_VERIFICATION_STALE`
- [ ] **Signed subscription agreement hash** present, containing the purchaser's accredited-investor representations and the **Rule 502(d) restricted-securities acknowledgement + resale covenant** (resell only under Rule 144, registration, or another exemption)
- [ ] **Bad-actor and Form D pre-conditions confirmed at the offering level** — the pre-offering bad-actor clearance attestation (Rule 506(d)) is on file, and the `FirstSaleRecorded(REG_D, timestamp)` event fires on the first `REG_D` mint to start the 15-day Form D clock (§ the Reg D section)
- [ ] **No Reg S artifacts** — a `REG_D` mint does NOT require the Rule 902(h) offshore certification and does NOT set a `closeDate`; the partition's `closeDate` stays `type(uint256).max` and is never consulted for `REG_D` tokens

### I.2 — Requirements common to both tranches

- [ ] OFAC screening result is fresh (within e.g. 30 days) at mint time
- [ ] Recipient wallet is registered in the identity registry; mints to unregistered wallets are rejected
- [ ] Recipient's resulting balance does not exceed the 9.99% concentration cap (measured on the identity's class-wide aggregate across all wallets and partitions)
- [ ] **The target partition is still open** — `mint` is allowed iff `block.timestamp < partition.closeDate` (an unset `closeDate == max` → open). It reverts once the `closeDate` has **arrived** (`block.timestamp >= closeDate`) — NOT merely because a future `closeDate` has been set (Section C, invariant 2). No sales after the close. New subscriptions after a close go into a fresh partition
- [ ] **Record the Rule 144 acquisition anchor** — capture the lot's `acquisitionTimestamp` = the date **full payment cleared** for this subscription (Rule 144(d)(1), Section D), NOT the mint block per se. If minting precedes payment confirmation (e.g., escrow), set `acquisitionTimestamp` to the payment-confirmation date. This is captured as an audit record / event-log entry (per-lot on-chain state is not required — because `closeDate` is never in the past and mints stop when it arrives, every lot has cleared its Rule 144 clock before the Reg S gate opens; Section D); it feeds the wash determination and audit trail, never the binding gate
- [ ] Certifications are recorded at the **registry** before mint via `setCertifications`, emitting `PurchaserCertified(wallet, certType, attestationHash)` (identity-level — no partition; `attestationHash` = keccak256 of the signed covenant, emit-only). Mint (Story 3.3) **verifies** the required certification set is present (`hasAllRequiredCertifications`) — it does not re-emit a cert event
- [ ] For real estate: link the mint event to the property record (property NFT or on-chain property registry entry) so the new holding can be tied to a specific underlying asset for distributions and reporting

---

## J. Out of Scope for the Contract

These compliance items are **operational, not contract-level** — do not invest contract complexity trying to enforce them on-chain:

| Off-chain concern                                                                                           | Where it lives                                                                           |
| ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| IP geofencing of marketing website                                                                          | Frontend / CDN (Cloudflare WAF, Fastly)                                                  |
| Directed selling efforts monitoring (§2.3)                                                                  | Marketing & PR governance policy                                                         |
| Tombstone advertisement compliance (§2.3)                                                                   | Compliance review queue for ads                                                          |
| Distributor written agreement (Rule 902(g)(1))                                                              | Legal documents, signed before placement                                                 |
| Press release / social media review (§6.4)                                                                  | Communications playbook + compliance gate                                                |
| Reg D / Reg S integration analysis (Rule 152) — keeping the tranches non-integrated                        | Counsel + offering structure                                                             |
| **Reg D Form D filing** — EDGAR within 15 days of first `REG_D` sale; annual + material-change amendments (Rule 503) | Compliance officer via EDGAR (clock started by `FirstSaleRecorded`)                      |
| **Reg D 506(c) accreditation verification — the actual document review** (income/net-worth docs, or BD/RIA/attorney/CPA letter) | Verification provider / compliance officer; only the resulting attestation goes on-chain |
| **Reg D bad-actor (Rule 506(d)) diligence** — questionnaires for all covered persons, refreshed each offering | Counsel + compliance officer (pre-offering gate; attestation hash on-chain)              |
| **Reg D state Blue Sky notice filings** — 506 covered-security notices + fees where U.S. purchasers reside (Section 18) | Counsel / compliance ops                                                                 |
| §13(d) / §16 / §12(g) Exchange Act reporting (§8.2)                                                         | Issuer's separate SEC filings                                                            |
| Record retention (§6.3)                                                                                     | Off-chain compliance database (5+ years)                                                 |
| AML SAR filings                                                                                             | MLRO + transaction monitoring system                                                     |
| Property due diligence and disclosures                                                                      | Sponsor / asset manager                                                                  |
| **OFAC SDN list pulls and daily re-screening infrastructure** (§A.1.3)                                      | Sanctions screening provider (Chainalysis / TRM Labs / ComplyAdvantage) + compliance ops |
| **TD F 90-22.50 Report of Blocked Transactions** — within 10 business days of any block (§A.1.4)            | MLRO / compliance officer via OFAC electronic reporting system                           |
| **Annual Report of Blocked Property (ARG)** — by September 30 each year (§A.1.4)                            | Compliance officer via OFAC annual reporting workflow                                    |
| **OFAC license applications** (specific or general) for any authorized release of blocked property (§A.1.5) | Counsel + OFAC application submission                                                    |
| **Voluntary Self-Disclosure** procedure if a sanctions violation is discovered post-facto (§A.1.6)          | Counsel + OFAC VSD submission                                                            |
| **OFAC records retention** — 5 years of all sanctions-related records (31 CFR § 501.601)                    | Off-chain compliance database (separate retention class from general records)            |
| **50 Percent Rule beneficial-ownership analysis** for entity investors (§A.1.2)                             | KYC provider + compliance officer ownership review                                       |

---

## K. Architecture Recommendation

Use the ERC-1400 family with the following modules, each with one clear responsibility:

1. **ERC-1410 Partitioned Token** — a partition is an offering, tagged with a **`tranche` type** (`REG_D` or `REG_S`) that `canTransfer` dispatches on. `REG_S` partitions carry a `closeDate` (Section C); their Reg S compliance period is `closeDate + 12 months` (single partition for a continuous offering, one per tranche for scheduled closes). `REG_D` partitions have no `closeDate` (`type(uint256).max`) — the 506(c) verified-accredited gate applies at issuance and Rule 144 governs U.S. resale. `canTransfer` reads the **sender's** partition — never a hardcoded index. The Rule 144 per-holder clock is tracked separately (Section D), not by the partition
2. **ERC-1594 Transfer Validation** — `canTransfer` calls into a separate `ComplianceRegistry` contract (upgradeable behind a transparent proxy). Compliance rules change; the token contract should not. Decoupling them lets the rules engine track SEC guidance evolution without forcing a token redeployment
3. **ERC-1643 Document Registry** — for the five legend / disclosure documents (Section E)
4. **ERC-1644 Controller Operations** — for force-transfers and compliance corrections (Section F)
5. **External `IdentityRegistry`** (ERC-3643 / ONCHAINID style) — owned by the KYC provider, referenced by the token. The same investor identity can be reused across multiple security tokens, which compounds value for the KYC provider and the investor
6. **External `ComplianceRegistry`** — rules logic behind a transparent proxy. Multi-sig + time-lock governance for upgrades. Allows the contract owner to update Reg S / Rule 144 rule application as SEC guidance evolves without redeploying the token

Keep the **token contract minimal**. Every Reg S rule should live in the compliance registry, not in the token itself.

```
┌─────────────────────────┐
│  Token (ERC-1400)        │
│  - ERC-1410 partitions   │
│  - ERC-1643 documents    │
│  - ERC-1644 controller   │
└────────┬─────────────────┘
         │ canTransfer() (ERC-1594)
         ▼
┌─────────────────────────┐      ┌────────────────────────┐
│  ComplianceRegistry     │─────▶│  IdentityRegistry      │
│  - Reg S rules          │      │  (ERC-3643 / ONCHAINID)│
│  - Rule 144 audit clock │      │  - KYC status          │
│  - Hedging blocklist    │      │  - U.S. person flag    │
│  - per-partition closeDate│    │  - OFAC status         │
│  - Concentration cap    │      │  - Concentration ledger│
└──────────┬──────────────┘      └────────────────────────┘
           │
           ▼
┌──────────────────────────┐
│ External Data Feeds      │
│ - OFAC sanctions oracle  │
│ - KYC provider updates   │
│ - Compliance officer     │
│   EIP-712 attestations   │
└──────────────────────────┘
```

---

## L. Off-Chain Compliance → On-Chain Validation Pattern

_The most important architectural pattern for security-token compliance: most Reg S decisions cannot be computed on-chain (KYC review, residency analysis, document inspection, OFAC list maintenance happen off-chain), but the contract must enforce them at every transfer. The pattern: off-chain decision → cryptographic attestation → on-chain verification in `canTransfer`. The smart contract is the gate; the off-chain pipeline tells the gate which way to swing._

### L.1 — Catalogue of Compliance Checks (off-chain action vs on-chain validation)

| #   | Compliance check                                                       | Off-chain action                                                                                                                                                                                                                                                                      | What gets to the chain                                                                                                                                                                                                   | On-chain validation point                                                                                                                                                                      |
| --- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | KYC identity verification                                              | KYC provider (Jumio, Onfido, Sumsub) runs document + liveness check                                                                                                                                                                                                                   | Status flag + verification timestamp written to identity registry                                                                                                                                                        | `canTransfer` reads registry every transfer                                                                                                                                                    |
| 2   | U.S. person classification (Rule 902(k))                               | KYC review + residency + entity-structure analysis                                                                                                                                                                                                                                    | Boolean flag + ISO jurisdiction code in identity registry                                                                                                                                                                | `canTransfer` rejects U.S.-flagged recipient during compliance period                                                                                                                          |
| 3   | OFAC SDN screening                                                     | Sanctions screening service (Chainalysis, TRM Labs, ComplyAdvantage)                                                                                                                                                                                                                  | Status flag + screening timestamp in identity registry                                                                                                                                                                   | `canTransfer` blocks on flagged sender OR recipient                                                                                                                                            |
| 4   | "For account or benefit of U.S. person" determination (Rule 902(h))    | Compliance officer manual review for nominee structures, trust beneficiaries                                                                                                                                                                                                          | EIP-712 signed attestation per transfer above threshold                                                                                                                                                                  | `canTransfer` verifies signature + expiry for high-value transfers                                                                                                                             |
| 5   | Reg S purchaser certification (Rule 903(b)(3)(iii)(B)(1))              | Investor signs subscription agreement off-chain                                                                                                                                                                                                                                       | Document hash + investor EIP-712 signature recorded at mint                                                                                                                                                              | `mint` requires signed certification reference                                                                                                                                                 |
| 6   | Reasonable belief buyer is offshore at order origination (Rule 902(h)) | **Issuer** (direct offering) or **placement agent** (agent deal) based on KYC, IP geolocation, declarations — 902(h)(1)(ii) permits issuer belief, no agent required                                                                                                                  | Non-U.S. KYC determination + investor's offshore-purchaser cert **always**; **optionally** an EIP-712 mint-authorization attestation by the agent's compliance signer                                                    | `mint` enforces non-U.S. KYC + investor signed cert; **when `placementAgent` configured**, also verifies the agent attestation (nonce + deadline)                                              |
| 7   | Distributor confirmation notice sent (Rule 903(b)(3)(iv))              | Placement agent emails confirmation off-chain                                                                                                                                                                                                                                         | Notice hash + recipient + timestamp emitted in event log                                                                                                                                                                 | Per transfer to known dealer/concession recipient                                                                                                                                              |
| 8   | Reg S compliance period (Rule 902(f))                                  | For a continuous partition: completion of distribution determined by the **issuer** (managing-underwriter function) or **certified off-chain by the placement agent** when engaged (full placement OR issuer termination). For a defined tranche: the close date is known at creation | **Multi-sig governance** write → compliance officer sets `partition.closeDate` (or it is set at `createPartition`); **no on-chain agent signature** — optional emit-only `completionCertHash` anchors the off-chain cert | `canTransfer` checks `senderPartition.closeDate != max AND block.timestamp >= closeDate + 12mo` (an unset `closeDate` blocks)                                                                  |
| 9   | Rule 144 holding period (post-compliance period U.S. resale)           | None — pure timestamp arithmetic (but the acquisition date must be captured at subscription/payment)                                                                                                                                                                                  | N/A (timestamp on-chain; payment confirmation off-chain feeds it)                                                                                                                                                        | `canTransfer` for U.S.-bound resale checks `block.timestamp >= lot.acquisitionTimestamp + 365 days` (per-holder/per-lot clock = full-payment date; Rule 144(d)(1)(ii) tacking — see Section D) |

Item 9 (Rule 144 holding period) is pure on-chain timestamp arithmetic once the acquisition date is captured. Item 8 (Reg S compliance period) is pure arithmetic too once the partition's `closeDate` is set — but for a continuous partition that `closeDate` depends on the off-chain completion-of-distribution determination reaching the chain before the clock can even start. Everything else is a hybrid where off-chain decisions need a trustworthy path onto the chain.

### L.2 — Four Attestation Mechanisms (pick the right one per check)

**1. Identity Registry State (push model)** — for slow-moving, broadly-applicable status

A trusted compliance role updates the identity registry contract with current status (KYC, OFAC, U.S.-person flag, jurisdiction). The token contract reads from the registry at transfer time. Updates are gas-paid by the compliance role; reads are free for the token.

- **Use for:** KYC status, OFAC status, U.S.-person flag, residency, accredited status
- **Pros:** cheap on-chain reads; status is current as of last push
- **Cons:** trusts the writer role; status can become stale between pushes; gas cost falls on the compliance role
- **Controls required:**
  - Time-stamped writes; `canTransfer` enforces `block.timestamp - lastUpdate < freshnessWindow`
  - Multi-sig + time-lock on role changes
  - Per-attribute freshness window (OFAC 30 days, KYC 12 months)

**2. EIP-712 Signed Attestations (pull model)** — for per-event, fact-specific decisions

**EIP-712** is the Ethereum standard for typed, structured data signing. A compliance signer signs a structured message attesting to a specific fact at a specific time. The caller submits the signature with the transaction. The contract verifies signature + freshness + nonce on-chain. The signature itself never has to be on-chain until used.

- **Use for:** per-transfer "not for U.S. benefit" attestations, mint authorization, distributor-notification confirmations, manual override for edge cases
- **Pros:** no gas to sign; submitted only when needed; supports complex per-event facts; signer key can be in a hardware module
- **Cons:** caller must obtain the attestation before transacting (UX friction); replay protection requires nonces or short expiries
- **Controls required:**
  - Per-fact nonce or short expiry (e.g., 5–60 minutes for mint, 24 hours for general transfer)
  - Signer key in multi-sig or HSM with documented rotation procedure
  - On-chain signer registry with revocation list — compromised keys → immediately invalid
  - EIP-712 domain separator per chain + per contract to prevent cross-deployment replay

**3. Merkle Allowlist Commitments** — for large, slow-changing whitelists

The issuer publishes a single 32-byte **Merkle root** of the eligible-investor list on-chain. At subscription, the investor presents a **Merkle proof** — a small set of intermediate hashes that mathematically demonstrate their wallet is part of the committed list, without the contract ever needing to know the full list.

- **Use for:** initial subscription whitelist where putting each individual investor on-chain would be cost-prohibitive
- **Pros:** single 32-byte storage covers unlimited investors; proofs are small (logarithmic in list size)
- **Cons:** updating the list requires republishing the root (operationally heavy for status changes); not suitable for revocation-sensitive status
- **Controls required:**
  - Use only for facts that don't change once true (e.g., "this wallet completed initial KYC and signed subscription")
  - Do NOT use for revocation-sensitive status (OFAC, sanctions) — combine with identity-registry blocklist for revocation overlay

**4. Oracle Contract (intermediated read)** — for shared cross-protocol state

An **oracle** is an on-chain contract that aggregates off-chain data from multiple sources (KYC provider, sanctions feed, jurisdiction database) and exposes it through a standardized read interface. The token contract reads through the oracle rather than from a registry it owns directly.

- **Use for:** when multiple tokens or protocols share the same investor universe and the same compliance checks (e.g., a security-token issuance platform deploying many deals from the same investor base)
- **Pros:** centralises compliance logic; supports protocol-level upgrades without redeploying tokens; investors benefit from compound network effects
- **Cons:** single point of failure / trust; gas overhead from the indirection; oracle staleness risk if the data feed lags
- **Controls required:**
  - Oracle governed by multi-sig + time-lock
  - Circuit breaker for stale / anomalous data
  - Heartbeat: oracle must update within max-staleness window or downstream contracts default to block

### L.3 — Mechanism Selection Per Check

| Check                               | Recommended mechanism                    | Rationale                                                        |
| ----------------------------------- | ---------------------------------------- | ---------------------------------------------------------------- |
| KYC status                          | Identity Registry (push)                 | Slow-moving (annual re-cert)                                     |
| OFAC status                         | Identity Registry (push) + blocklist     | Needs immediate revocation; blocklist overrides any other status |
| U.S.-person flag                    | Identity Registry (push)                 | Slow-moving but possible change on residency move                |
| Mint authorization                  | EIP-712 signed (pull)                    | Per-mint fact; short freshness window                            |
| "Not for U.S. benefit" (high-value) | EIP-712 signed (pull)                    | Per-transfer fact; manual review                                 |
| Initial subscription whitelist      | Merkle proof at mint                     | Large list; one-time mint event                                  |
| Distributor confirmation sent       | Event emission only (no validation gate) | Evidence-only, off-chain enforcement                             |

### L.4 — Default-Block, Never Default-Allow

The single most important on-chain rule: when any required attestation is missing, stale, or unverifiable, the contract MUST revert. Never default-allow on missing data.

- [ ] Every `canTransfer` check that depends on off-chain attestation has a `STALE_ATTESTATION` or `MISSING_ATTESTATION` revert path
- [ ] Identity registry reads return a `lastUpdated` timestamp; `canTransfer` enforces max staleness per attribute (configurable per check)
- [ ] EIP-712 signatures include an `expiry` field; expired signatures revert with `ATTESTATION_EXPIRED`
- [ ] Oracle reads include a `dataFreshness` timestamp; stale oracle data reverts with `ORACLE_STALE`
- [ ] No bypass / emergency-allow path. If the off-chain pipeline is down, transfers stop until it is restored. Document this as the design intent in the offering memorandum

### L.5 — Revocation, Key Rotation, and Audit Trail

- [ ] **Revocation list** — identity registry exposes a `blocklist` mapping that overrides any other status. Used for OFAC additions, compromised wallets, lost-key recovery. A single transaction can block any wallet immediately
- [ ] **Signer key rotation** — compliance signer keys live in a multi-sig wallet with a documented rotation procedure. An on-chain signer registry tracks currently-valid signers; prior signatures remain valid up to their expiry unless explicitly revoked via a revocation transaction
- [ ] **Oracle downtime fallback** — if an oracle becomes unreachable or returns stale data, contract defaults to block. Emergency-disable of an oracle requires multi-sig + 48-hour time-lock; documented in governance procedure
- [ ] **Audit trail events** — every off-chain attestation consumed on-chain emits an event capturing: (a) source identifier (signer address / oracle address / registry version), (b) timestamp of the off-chain action, (c) on-chain validation timestamp, (d) hash fingerprint of the source document if applicable. This is the SEC evidence file in any future inquiry

### L.6 — Trust Boundaries (Who Is Trusted to Attest What)

| Off-chain role                                                                      | What they attest to                                                                                                                                                                                                                                                                | On-chain mechanism                                    | Compromise impact                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| KYC provider                                                                        | Identity, residency, U.S.-person status                                                                                                                                                                                                                                            | Identity registry write role (provider's address)     | Bad actors get KYC clearance → identity gate fails for some investors                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Sanctions screening provider                                                        | OFAC / sanctions status                                                                                                                                                                                                                                                            | Identity registry write role (separate from KYC)      | Sanctioned actors clear screening → OFAC violation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Accreditation verification provider (Reg D 506(c))                                  | U.S. accredited-investor status "verified" under Rule 506(c)(2)(ii)                                                                                                                                                                                                                | Identity registry write role (writes the verification record) | A non-qualified U.S. person is marked verified → 506(c) broken for the whole `REG_D` tranche → Section 5 exposure. Mitigate with independent providers (registered BD/RIA/attorney/CPA), evidence-hash retention, and the `expiresAt` freshness gate |
| Compliance officer                                                                  | Edge-case determinations, beneficial-ownership reviews                                                                                                                                                                                                                             | EIP-712 signer                                        | Signed-off bad transfers; mitigated by per-attestation amount limits                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Sponsor / GP                                                                        | Mint authorization, offering close timestamps                                                                                                                                                                                                                                      | Multi-sig controller (M-of-N)                         | Unauthorized mints; mitigated by M-of-N and time-lock on threshold mints                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Placement agent **(when the offering engages one; optional for a direct offering)** | Distributor notification, offshore-buyer reasonable belief **(optional on-chain attestation — only when `placementAgent` configured; otherwise the issuer forms the 902(h) belief via KYC)**, **Rule 902(f) completion-of-distribution certification (the partition `closeDate`)** | EIP-712 signer (separate key from compliance officer) | False offshore-buyer claims; **premature or withheld `closeDate` distorts the Reg S clock start** — mitigate by contractually fixing the certification triggers and long-stop date in the placement agreement, the on-chain write constraints (not-in-the-past, immutable once reached, no mints after it arrives) per Section C, and dual sign-off **when an agent is engaged** (placement agent certifies **off-chain**, compliance officer records on-chain via the multi-sig write; a direct offering has the issuer determine completion). The completion certification is **off-chain** — no on-chain agent signature; an optional emit-only `completionCertHash` anchors the cert doc |
| Contract upgrader                                                                   | Compliance rule changes                                                                                                                                                                                                                                                            | Multi-sig + time-lock + governance                    | Rule changes; mitigated by 7+ day time-lock allowing investor review                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

Every role above is a potential compromise vector. **Multi-sig + time-lock + segregated signer scope** is non-negotiable for production deployment. Document each role, its key custody arrangement, and its rotation schedule in the offering memorandum.

---

## M. Single Biggest Design Risk

**Treating Cat 3 domestic equity restrictions as expiring at 12 months.** They don't. Rule 905 makes them **restricted securities perpetually**. The contract logic needs two **separate states**:

1. **Reg S compliance period active** — time-limited (12 months for this non-reporting issuer), gates U.S.-person transfers entirely
2. **Rule 144 restricted-status** — permanent for the life of the token, gates U.S.-person resales unless registration or exemption is available

Conflating the two will let restricted tokens leak into unrestricted U.S. trading after the 12-month compliance period expires, creating Section 5 / Section 12(a)(1) rescission liability for the issuer and the offshore reseller. The on-chain `canTransfer` logic must check both states independently — passing one is not enough.

**Second biggest risk (dual-tranche): a mint into the wrong partition.** Minting a U.S. accredited investor into a `REG_S` partition, or an offshore/unverified buyer into a `REG_D` partition, breaks the exemption for that token — and, worse, can taint the tranche. The mint path must **hard-gate on the recipient's classification vs the partition's `tranche` type** (Section B / I), and the routing (which tranche a subscriber belongs to) must be decided off-chain at onboarding and enforced on-chain at mint — never left to the caller. A related risk is **506(c) verification drift**: relying on a stale or self-certified accreditation admits a non-qualified U.S. person, breaking 506(c) for the whole tranche — hence the `expiresAt` freshness gate and the `verified`-not-`accredited` distinction.

---

## N. Pre-Deployment Verification Checklist

Before mainnet deployment:

- [ ] Independent smart contract security audit (compliance logic + standard reentrancy / access control)
- [ ] Reg S condition mapping document — every contract function annotated with the Rule it enforces (auditor and SEC-reviewer friendly)
- [ ] Test coverage of every `canTransfer` reason code with both pass and fail paths
- [ ] Test coverage of the per-partition `closeDate` lifecycle: (a) unset `closeDate == type(uint256).max` blocks ALL U.S.-person transfers; (b) `closeDate` set at creation (defined tranche); (c) `closeDate` filled later by the compliance officer (continuous); (d) the boundary at `closeDate + 12 months` (before / at / after expiry); (e) **`0` sentinel must NOT be accepted / must not pass the gate** (fail-open regression test)
- [ ] Test coverage of the `closeDate` write constraints: rejects a **past** value (`closeDate < block.timestamp`) at both `createPartition` and `setCloseDate`; **accepts current (`== now`) and future values**; rejects any update once the existing `closeDate` has been reached (immutable-after-arrival); confirms `mint` is allowed while `block.timestamp < closeDate` (including a future `closeDate` set at creation) and reverts once `block.timestamp >= closeDate` (including `closeDate == now`, which stops mints in the same block)
- [ ] Test coverage of Rule 144 holding period math (per-holder `acquisitionTimestamp` = full-payment date, with tacking on transfer) for the affiliate-free non-reporting issuer scenario; confirm the Reg S `closeDate` gate always clears at or after every lot's Rule 144 gate (the binding-constraint invariant)
- [ ] **Test coverage of tranche dispatch in `canTransfer`:** a U.S. person (even accredited/verified) is BLOCKED into a `REG_S` partition (`REG_S_US_PERSON_RESTRICTED`); a non-`US_ACCREDITED_VERIFIED` recipient is BLOCKED into a `REG_D` partition (`REG_D_NOT_VERIFIED_ACCREDITED`); a `US_ACCREDITED_VERIFIED` recipient is ALLOWED into a `REG_D` partition; a `REG_D` partition never consults `closeDate` (stays `type(uint256).max`) and its only U.S.-resale gate is Rule 144
- [ ] **Test coverage of the 506(c) verification gate:** `REG_D` mint reverts on a self-certified-only (unverified) recipient; reverts on a stale verification (`block.timestamp > expiresAt`); passes on a current verification record; the `accredited` flag alone (without `verified`) does NOT admit a `REG_D` mint
- [ ] **Test coverage of tranche isolation / integration:** the same identity is not minted into both tranches for the same interest; the 9.99% concentration cap aggregates across BOTH `REG_D` and `REG_S` partitions (one class); `FirstSaleRecorded(REG_D, …)` fires on the first `REG_D` sale (Form D clock)
- [ ] **Test coverage of the `REG_D` vs `REG_S` timing contrast:** a `REG_D` holder clears U.S. resale at `acquisitionTimestamp + 12mo` (Rule 144 only); a `REG_S` holder of the same vintage clears only at `closeDate + 12mo` (later) — assert the 9-month-style gap from the worked example
- [ ] Test coverage of ERC-1644 controller force-transfer with multi-sig governance
- [ ] Test coverage of concentration-cap aggregation across multiple wallets AND multiple partitions bound to the same identity (class-level aggregate)
- [ ] Test coverage of EIP-712 signature verification, expiry, and revocation
- [ ] Test coverage of Merkle proof verification at mint
- [ ] Test coverage of oracle staleness behaviour (block on stale data)
- [ ] Legal review of all on-chain legend text vs offering document text — they must match verbatim
- [ ] Counsel sign-off on the compliance registry rule set before deployment

---

## Appendix — Worked Example: The Two Clocks in Action

_Illustrative walk-through of how the smart contract enforces the Reg S 12-month distribution compliance period and the Rule 144 12-month holding period over time. Use this when introducing the platform to a sponsor, counsel, or development team for the first time. The actors and timeline are generic — the example illustrates the two-clock mechanics, not any specific deal._

### Setup

- **The SPV** — a non-reporting U.S.-domiciled LLC; sole owner of a U.S.-situs commercial property
- **The token** — ERC-1400 security token representing pro-rata equity in the property
- **The offering** — a **concurrent dual-tranche** raise: a **`REG_S` partition** (Reg S Cat 3 continuous offering, Rule 902(f)(2), "end date upon full placement or earlier termination") for offshore investors, PLUS a **`REG_D` partition** (Rule 506(c)) for verified U.S. accredited investors. The `REG_S` partition's `closeDate` is filled at completion; the `REG_D` partition has **no** `closeDate` (its field stays `type(uint256).max`). Tokens are minted continuously into whichever partition matches the buyer. T=0 = the date the offering opens
- **Setting the `closeDate`** — at some point the placement agent certifies "completion of distribution" (on full placement or issuer termination) and the compliance officer writes the partition's `closeDate`. This write — NOT any individual mint — starts the Reg S compliance clock. In this example, full placement is reached at **T+9mo**, so `closeDate = T+9mo`
- **Reg S distribution compliance period** — 12 months per Rule 903(b)(3)(iii)(A), running from the partition's **`closeDate`**. Here: `closeDate + 12mo` = T+9mo → **T+21mo**. One value for this single-partition offering
- **Rule 144 holding period** — 12 months per Rule 144(d)(1), running from each holder's **full-payment (subscription) date** (with tacking inherited on secondary transfers). Investor A, who paid in full at T=0, clears her Rule 144 holding period at **T+12mo**. Per holder — NOT global
- **The key lesson of this example:** these are **two independent regimes** governed by different statutes, anchored to different events, and they do NOT align. Investor A's Rule 144 clock clears at T+12mo, but the Reg S gate stays shut until T+21mo. **Reg S is the binding constraint** — Investor A cannot sell to a U.S. person until T+21mo even though her Rule 144 holding period cleared 9 months earlier

### Cast

| Actor       | Location    | Status                                                      | Eligible tranche |
| ----------- | ----------- | ----------------------------------------------------------- | ---------------- |
| Investor A  | Mexico City | Non-U.S. person                                             | `REG_S`          |
| Investor B  | Munich      | Non-U.S. person                                             | `REG_S`          |
| Investor C  | Tokyo       | Non-U.S. person                                             | `REG_S`          |
| Investor D  | Los Angeles | U.S. person, **accredited AND verified** (Rule 506(c))      | `REG_D`          |
| Investor E  | New York    | U.S. person, retail (not accredited)                        | **none**         |
| The Sponsor | Florida     | U.S. person AND affiliate (manages the SPV)                 | **none** (affiliate-free) |

### Two Independent Regimes — Kept Separate

These two rules are **separate legal regimes**. They share no clock, no anchor event, and no statutory home. To avoid confusion, understand each ON ITS OWN first, then see how they combine. **Do not think of them as one "two-clock" mechanism — think of them as two independent gates that happen to be checked in the same `canTransfer` call.**

**🟥 Regime 1 — Reg S Distribution Compliance Period** _(governs WHEN any U.S.-person transfer is permitted at all)_

- Statute: Rule 903(b)(3)(iii)(A) / Rule 902(f)
- Anchor: the partition's **`closeDate`** — here filled at completion of distribution (T+9mo)
- Duration: 12 months → `closeDate + 12mo` ends **T+21mo**
- Scope: the partition's `closeDate` (this continuous offering uses a single partition), identical for every holder in it
- Effect: blocks ALL U.S.-person transfers until it expires. Says nothing about restricted-securities status
- Ignore Rule 144 entirely when reasoning about this regime

**🟦 Regime 2 — Rule 144 Restricted-Securities Status & Holding Period** _(governs WHETHER a permitted U.S. resale is exempt and washes the restriction)_

- Statute: Rule 144(d)(1) holding period; Rule 905 / Rule 144(a)(3)(v) restricted status
- Anchor: **each holder's own full-payment date** (per holder, with Rule 144(d)(1)(ii) tacking inherited on secondary transfers). Investor A paid at T=0 → clears **T+12mo**
- Duration: 12 months per holder/lot
- Scope: per acquisition lot — different subscribers clear on different dates
- Effect: once cleared, a non-affiliate U.S. resale is exempt and washes the Rule 905 restricted label off the buyer's tokens. Says nothing about the Reg S offering window
- Ignore Reg S entirely when reasoning about this regime

**How the two combine (the ONLY place they interact):** a U.S.-person resale requires BOTH gates open — Reg S expired AND Rule 144 holding period cleared. Because the partition's `closeDate` (T+9mo) is constrained to land at or after every holder's full-payment date, **the Reg S gate always clears last and is the binding constraint.** By the time Reg S opens (`closeDate + 12mo` = T+21mo), every holder's Rule 144 clock has already cleared — so the only practical question left is the Reg S window. Rule 144 still matters for one thing: it determines that the eventual sale **washes the restricted label**. That is the entire interaction; nothing else couples the two regimes.

---

### Scenario 1 — Primary Offering Day (T=0)

**1a. Investor A buys 1,000 tokens directly from the SPV**

- Investor A is in Mexico City; signs subscription offshore; wires from a Mexican bank
- SPV delivers 1,000 tokens to Investor A's wallet at T=0; her full payment settles the same day, so her Rule 144 `acquisitionTimestamp` = T=0
- 🟥 _Regime 1 (Reg S):_ compliance period has not started (no certification) — but Investor A is a non-U.S. person, so the Reg S U.S.-person gate is not implicated
- 🟦 _Regime 2 (Rule 144):_ Investor A's `acquisitionTimestamp` = T=0 (her full-payment date). Her personal 12-month holding clock will clear at T+12mo. This is HER clock — other subscribers who pay on other dates have their own
- **Result: ✅ ALLOWED.** Investor A holds 1,000 tokens
- Tokens carry the permanent "restricted securities" label — Rule 905 of Reg S imposed this automatically at issuance (Regime 2). Removing it later requires a Rule 144 non-affiliate U.S. resale

**1b. Investor D (U.S., verified accredited) buys 500 tokens — routed by tranche**

- Investor D is a U.S. resident, but **accredited AND verified** under Rule 506(c).
- **Into the `REG_S` partition → ❌ BLOCKED** (`REG_S_US_PERSON_RESTRICTED`). The Reg S tranche blocks EVERY U.S. person; accredited status does not help, and signing from a Bali villa does not help — she is a U.S. resident under Rule 902(k). A U.S. accredited investor does not belong in a `REG_S` partition.
- **Into the `REG_D` partition → ✅ ALLOWED.** She is `US_ACCREDITED_VERIFIED`; the 506(c) mint gate passes. SPV delivers 500 tokens into the `REG_D` partition; her Rule 144 `acquisitionTimestamp` = her full-payment date. The `REG_D` partition has no `closeDate` / no Reg S compliance period — her only future U.S.-resale gate is the Rule 144 12-month holding period.
- Tokens are restricted securities **directly under Rule 502(d)** (not the Rule 905 bridge — that is the Reg S door).

**1c. Investor E (U.S., retail) tries to buy — both tranches**

- Investor E is a U.S. person, **not accredited**.
- `REG_S` → ❌ BLOCKED (U.S. person). `REG_D` → ❌ BLOCKED (`REG_D_NOT_VERIFIED_ACCREDITED` — 506(c) is accredited-only). **There is no tranche for a non-accredited U.S. retail investor.**

**1d. The Sponsor tries to subscribe for 5,000 tokens — both tranches**

- Sponsor is a U.S. resident AND an affiliate of the SPV. He would qualify as accredited (director/officer, Rule 501(a)(4)), so 506(c) alone would not stop him.
- BUT the **affiliate-free architecture** blocks him in **both** tranches — no affiliate holds tokens.
- **Result: ❌ BLOCKED.** Sponsor economics come through LLC-level Class B Promote Units, not tokens.

---

### Scenario 2 — Three Months Later (T+3mo)

**2a. Investor A wants to sell 100 tokens to Investor B (offshore-to-offshore)**

- Both non-U.S. persons
- 🟥 _Regime 1 (Reg S):_ compliance period still not started — but this is an offshore-to-offshore sale, so the Reg S U.S.-person gate is not implicated
- Transfer is offshore-to-offshore — Rule 902(h) offshore-transaction test satisfied via the Rule 904 secondary-resale path
- 🟦 _Regime 2 (Rule 144):_ the 100 tokens carry their `acquisitionTimestamp` = T=0 with them. Investor B **inherits** that timestamp via Rule 144(d)(1)(ii) tacking — B's clock does NOT restart at T+3mo. B is treated as having held since T=0 for any future U.S.-person resale. (Rule 144 only bites on U.S.-person sales, so it is not blocking anything here)
- **Result: ✅ ALLOWED.** Investor B now holds 100 tokens
- Tokens in B's hands are still "restricted securities" — Rule 905 label travels with the tokens through every offshore transfer. Only a Rule 144 non-affiliate U.S. resale removes it

**2b. Investor A wants to sell 100 tokens to Investor D (offshore to U.S.)**

- Investor D is a U.S. person
- 🟥 Reg S compliance period not started → U.S.-person gate blocks with no expiry in sight
- 🟦 Rule 144 holding period: only 3 months — insufficient anyway
- **Result: ❌ BLOCKED.** Both gates fail; the Reg S gate alone is sufficient

**2c. Investor C sells 200 tokens to Investor E**

- 🟥 Reg S compliance period not started; both U.S. persons
- **Result: ❌ BLOCKED.** Same reason as 2b

---

### Scenario 3 — Full Placement → `closeDate` Written (T+9mo)

The offering reaches **full placement** at T+9mo. Per the whitepaper ("Upon full placement or earlier termination by issuer"), the placement agent issues the Rule 902(f)(2) completion-of-distribution certification that day, and the compliance officer writes the partition's `closeDate`.

**3a. The `closeDate` is written**

- Placement agent signs the Rule 902(f)(2) certification (full placement reached)
- Compliance officer records it on-chain via the **multi-sig governance write**: calls `setCloseDate` with the partition's `closeDate = T+9mo` (a future date at the moment of writing, just ahead of the cutoff) and optionally the `completionCertHash` anchoring the off-chain certification doc. Mints stop the instant T+9mo arrives; the partition is then closed to new mints
- `CloseDateSet(partition, T+9mo)` event emitted
- **The Reg S compliance clock now starts — and will run until `closeDate + 12mo` = T+21mo.** Before this write it had not started at all. This single event is what un-freezes the eventual U.S.-resale path
- Note: every investor in this partition — whether they paid at T=0 or T+8mo — now shares this same T+21mo Reg S end date. Only the per-holder Rule 144 clocks (Regime 2) differ by subscription date

---

### Scenario 4 — The Misalignment (T+12mo + 1 day)

🟦 **Investor A's Rule 144 holding period: CLEARED** (T=0 full payment + 12 months + 1 day).
🟥 **Reg S compliance period: STILL ACTIVE** (runs to T+21mo — another ~9 months to go).

This is the central lesson of the continuous-offering structure: **the Rule 144 clock has cleared, but the Reg S gate is still shut. Reg S binds.**

**4a. Investor A wants to sell 100 tokens to Investor D (U.S. person)**

- 🟦 Rule 144 holding period for Investor A: paid in full at T=0, held 12 months + 1 day → ✅ MET
- 🟥 Reg S compliance period: ❌ NOT expired — `closeDate + 12mo` = T+21mo, and it is only T+12mo+1day
- **Result: ❌ BLOCKED** — `REG_S_US_PERSON_RESTRICTED`. Even though Investor A satisfied her Rule 144 holding period 9 months ago, the partition's Reg S compliance period — pinned to the T+9mo `closeDate` — has not run out. **The Reg S gate is the binding constraint.**

> 💡 **This is exactly the trap the continuous-offering structure creates.** Under a defined-closing-tranche structure (Rule 902(f)(1)) **with escrow-until-close settlement** — where the tranche closes at T=0 and full payment is deemed made then — Investor A's two clocks would both anchor at T=0 and clear at T+12mo, so she could sell now. Because the client chose a continuous offering, the partition's `closeDate` was not written until completion at T+9mo, pushing her first eligible U.S. resale out to `closeDate + 12mo` = T+21mo. The earlier an investor subscribed relative to the `closeDate`, the longer the gap between their Rule 144 clearance and their Reg S clearance.

**4b. Investor B wants to sell 100 tokens to Investor D (U.S. person)**

- 🟦 Rule 144 holding period for Investor B: **tacks back to Investor A's full-payment date at T=0** — automatic non-affiliate-to-non-affiliate tacking under Rule 144(d)(1)(ii). 12 months + 1 day elapsed since T=0 → ✅ MET
- 🟥 Reg S compliance period: ❌ NOT expired (T+21mo)
- **Result: ❌ BLOCKED** — same as 4a. Tacking gave B a cleared Rule 144 clock, but the Reg S gate still binds for everyone until T+21mo

> 💡 **Tacking rule (Rule 144(d)(1)(ii)):** _"a minimum of one year must elapse between the later of the date of the acquisition of the securities from the issuer, or from an affiliate of the issuer, and any resale of such securities in reliance on this section **for the account of either the acquiror or any subsequent holder of those securities.**"_ When Investor A (a non-affiliate) sold to Investor B at T+3mo, B's Rule 144 clock tacked back to A's full-payment date at T=0 — it did NOT restart at T+3mo. Automatic tacking is the general rule for ordinary non-affiliate-to-non-affiliate transfers; it is NOT one of the Rule 144(d)(3) "special situations." But note: in this continuous offering, the Rule 144 clock is never the binding gate anyway — Reg S always clears later.

> ⚠️ **When tacking does NOT apply (counterfactual):** If Investor B had acquired directly from the issuer, OR from an **affiliate** of the issuer, B's Rule 144 clock would start fresh on B's acquisition date. Purchase from an affiliate is treated like purchase from the issuer for Rule 144 holding-period purposes. Tacking only applies between non-affiliates. This is the practical reason the affiliate-free architecture matters — any holder who becomes an affiliate by operation of law would disrupt the tacking chain for tokens passing through their hands.

---

### Scenario 5 — Reg S Period Finally Expires (T+21mo + 1 day)

🟥 **Reg S compliance period: EXPIRED** (certification T+9mo + 12 months). The Reg S gate is now OPEN.
🟦 **Every holder's Rule 144 holding period: long since CLEARED** (the latest subscription payment was before T+9mo, so the latest Rule 144 clock cleared by T+21mo at most).

The tokens are still "restricted securities" — the Rule 905 label is permanent. Now a Rule 144 non-affiliate resale can wash it.

**5a. Investor A wants to sell 100 tokens to Investor D (U.S. person)**

- 🟥 Reg S compliance period: ✅ EXPIRED
- 🟦 Rule 144 holding period: ✅ MET (cleared at T+12mo)
- Investor A is a non-affiliate; Rule 144(b)(1)(ii) non-reporting non-affiliate path — no volume cap, no manner-of-sale restriction, no current-info requirement, no Form 144
- **Result: ✅ ALLOWED.** Investor D now holds 100 tokens
- Tokens in D's hands **lose the "restricted" label** — the Rule 144 non-affiliate sale washed it off. (Here the Rule 144 clock matters: it is what authorizes the wash, even though it was never the binding gate.)

> ⚠️ **Critical contrast:** if Investor A had instead sold via Rule 904 (offshore-to-offshore), the tokens would **stay** restricted regardless of how many times traded offshore. The label only comes off via a Rule 144 non-affiliate resale to a U.S. person.

**5b. The Sponsor (counterfactually holding tokens) tries to sell to Investor E**

- Note: under the affiliate-free architecture, the Sponsor **does not hold tokens**. This is a counterfactual to illustrate why
- 🟥 Reg S compliance period: ✅ EXPIRED
- 🟦 Rule 144 holding period: assume ✅ MET
- BUT the Sponsor is an **affiliate** → ongoing Rule 144 restrictions never lift:
  - Volume limit (Rule 144(e)): greater of 1% of outstanding OR average weekly trading volume × 13 (90-day window)
  - Manner of sale (Rule 144(f)): broker transaction or to a market maker only
  - Current public information (Rule 144(c)): non-reporting issuer must maintain a Rule 15c2-11 information statement on file — the practical killswitch
  - Form 144 (Rule 144(h)): required if sale > 5,000 tokens OR > $50,000 in 3 months
- **Result: ⚠️ Theoretically ALLOWED, practically near-frozen.** This is precisely why the affiliate-free architecture exists — the Sponsor never holds tokens to begin with

---

### Scenario 6 — Free Trading (T+30mo)

**6a. Investor D (who bought from Investor A at T+21mo) wants to sell to Investor E**

- Investor D's tokens are NOT restricted — the label was washed when Investor A made the Rule 144 non-affiliate sale to D
- No Reg S analysis, no Rule 144 analysis needed
- **Result: ✅ ALLOWED.** Investor E holds the tokens free and clear

---

### Scenario 7 — The `REG_D` Tranche (only one clock)

Investor D's **`REG_D`** holding (the 500 tokens she bought in 1b at T=0) behaves differently from the Reg S tranche: there is **no Reg S distribution compliance period** — only the Rule 144 clock.

**7a. Investor D wants to sell her `REG_D` tokens to another U.S. accredited investor at T+11mo**

- 🟥 _Regime 1 (Reg S):_ **does not apply** — `REG_D` partition has no `closeDate`. There is no Reg S gate.
- 🟦 _Regime 2 (Rule 144):_ her `acquisitionTimestamp` = T=0; 11 months elapsed → holding period **not yet met** (needs 12).
- **Result: ❌ BLOCKED** — `RULE_144_HOLDING_PERIOD_NOT_MET`. The only gate on a `REG_D` token is Rule 144, and it has not cleared.

**7b. Same sale at T+12mo + 1 day**

- 🟦 Rule 144 holding period: ✅ MET (12 months from her T=0 full payment). Investor D is a non-affiliate; non-reporting non-affiliate path — no volume cap, no Form 144.
- **Result: ✅ ALLOWED.** The buyer receives washed, unrestricted tokens.

> 💡 **The contrast that makes the dual-tranche point:** Investor D's `REG_D` tokens became U.S.-resaleable at **T+12mo** (Rule 144 only). The *same* investor's Reg S-side tokens would not clear until **T+21mo** (`closeDate + 12mo`, because the Reg S compliance period is the binding gate on that partition). Same investor, same issuer, same day of purchase — **9 months' difference, entirely because of which tranche the tokens live in.** That is why the partitions are kept separate and why `canTransfer` dispatches on tranche.

---

### The Two Regimes Distinguished (kept separate)

|                             | 🟥 Regime 1 — Reg S Distribution Compliance Period                                     | 🟦 Regime 2 — Rule 144 Restricted-Securities Status          |
| --------------------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| **Statute**                 | Rule 903(b)(3)(iii)(A) / Rule 902(f)(2)                                                | Rule 144(d)(1) + Rule 905 / Rule 144(a)(3)(v)                |
| **What it is**              | A TIME WINDOW for the offering                                                         | A LABEL on the token + a per-holder holding clock            |
| **Anchor event**            | The partition's `closeDate` (set at creation, or filled at completion of distribution) | Each holder's own full-payment date (with tacking)           |
| **Scope**                   | One `closeDate` per partition, same for every holder in it                             | Per acquisition lot / per holder                             |
| **Window**                  | `closeDate` → `closeDate + 12mo` (T+9mo → T+21mo)                                      | each holder's full-payment date + 12mo                       |
| **What it gates**           | WHETHER any U.S.-person transfer is allowed at all                                     | WHETHER a permitted U.S. resale is exempt + washes the label |
| **Binding?**                | **Yes — always clears last**                                                           | No — always already cleared by the time Regime 1 opens       |
| **Reason for any coupling** | none — independent regime                                                              | only the wash determination links back to a permitted sale   |

Read each column on its own. The only cell where they touch is the bottom row: Reg S is the binding gate; Rule 144 decides the wash. Otherwise they are unrelated.

### Smart Contract Translation

`canTransfer(from, to, amount)` for a U.S.-person recipient at any time T:

```
1. Is the recipient a U.S. person? (read IdentityRegistry)
   If NO  → only check OFAC, KYC → likely ALLOW
   If YES → continue:

2. 🟥 Has the SENDER-PARTITION's Reg S distribution compliance period expired?
   (senderPartition.closeDate != type(uint256).max
    AND block.timestamp >= senderPartition.closeDate + 365 days)
   closeDate = the partition's close date — set at createPartition for a defined
   tranche, or written by the compliance officer at completion of distribution
   for a continuous offering (Section C). Unset sentinel is type(uint256).max.
   If closeDate == max (not closed yet) → BLOCK: the clock has not started.
   (Never use 0 as the sentinel — 0 + 365 days is in the past → fails OPEN.)
   THIS IS THE BINDING GATE.
   If NO  → BLOCK with reason REG_S_US_PERSON_RESTRICTED
   If YES → continue:

3. 🟦 Has the Rule 144 12-month holding period for the lot(s) being sent cleared?
   Regulatory reference: block.timestamp >= lot.acquisitionTimestamp + 365 days
   (per acquisition lot; acquisitionTimestamp = full-payment date, tacking applies)
   On-chain implementation (Section D): block.timestamp >= holdingEnd[from][partition]
   where holdingEnd[from][partition] = conservative max of all acquisition timestamps
   within this partition for this holder (issuanceTimestamp proxy + holdingPeriod),
   raised monotonically, never lowered; scoped PER PARTITION so a longer-period
   partition does not bleed onto this partition's clock.
   Under the continuous offering, closeDate >= every issuanceTimestamp in the
   partition, so this gate has ALWAYS already cleared by the time gate 2 clears —
   it is never the binding blocker here, but it is checked to confirm the Rule 144
   wash applies (the buyer receives unrestricted securities) and for audit mapping.
   If NO  → BLOCK with reason RULE_144_HOLDING_PERIOD_NOT_MET
   If YES → continue:

4. Is the SENDER an affiliate?
   Under the affiliate-free architecture, NO holder is classified as affiliate.
   Affiliate-creating events trigger BLOCKED status instead (Architectural Decision §4).
   If sender is BLOCKED → reject earlier in canTransfer with SENDER_BLOCKED
   Otherwise → ALLOW (Rule 144(b)(1)(ii) non-affiliate path is clear)
```

Gates 2 (🟥) and 3 (🟦) are conceptually distinct — the Reg S strict gate vs. the Rule 144 restricted-securities gate — and **they do NOT clear at the same time.** Gate 2 reads the sender partition's `closeDate + 12 months`; gate 3 reads each lot's `acquisitionTimestamp + 12 months` (= the holder's full-payment date, with tacking — Section D). Because `closeDate` is never in the past and mints stop once it arrives (so every lot's payment precedes `closeDate`), gate 2 always clears at or after gate 3 — **gate 2 (Reg S) is the binding constraint.** Gate 3 is retained because (a) it maps to a distinct source regulation for audit, and (b) it determines whether a permitted U.S. resale washes the Rule 905 restricted label off the buyer's tokens. The two gates clear simultaneously only with **escrow-until-close settlement**, where every holder's acquisition (full-payment) date coincides with the partition's `closeDate` — see Section C / Section D.

---

_Source authority: This document derives every Reg S requirement from [reg-s-checklist.md](../sales-marketing/Service/Content/US%20Compliance/reg-s-checklist.md), every Rule 144 requirement from [rule-144-checklist.md](../sales-marketing/Service/Content/US%20Compliance/rule-144-checklist.md), and every OFAC requirement from [ofac-checklist.md](../sales-marketing/Service/Content/US%20Compliance/ofac-checklist.md). If any of these source documents is updated, this guide must be re-reviewed._
