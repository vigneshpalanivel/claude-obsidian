# Real Estate RWA Tokenization under Regulation S — Implementation Guide for Sponsors, Counsel, and Builders

**Source authorities:**

- [reg-s-checklist.md](../US%20Compliance/reg-s-checklist.md) — single source of truth for Regulation S requirements (17 CFR §§ 230.901–230.905)
- [rule-144-checklist.md](../US%20Compliance/rule-144-checklist.md) — single source of truth for Rule 144 resale conditions (17 CFR § 230.144), reached from Reg S via the Rule 905 bridge
- [ofac-checklist.md](../US%20Compliance/ofac-checklist.md) — single source of truth for OFAC sanctions compliance (31 CFR Chapter V, SDN List, Executive Orders, program-specific regulations, virtual currency guidance), applied independently of and cumulatively with Reg S and Rule 144

**Token standard:** **ERC-1400** (the security-token standard) — a family of related Ethereum specifications:

- **ERC-1410** — _partitioned tokens_. Lets one token contract hold multiple "partitions," each carrying its own compliance state. Used here for one partition per closing tranche so each closing's 12-month lockup runs independently.
- **ERC-1594** — _transfer validation_. Defines the `canTransfer` hook the token calls before every transfer to check whether it's allowed; this is where the Reg S and Rule 144 rules are enforced.
- **ERC-1643** — _document registry_. A standard way for the token to publish references (URI + hash fingerprint) to the offering memorandum, legends, and other legal documents.
- **ERC-1644** — _controller operations_. A built-in capability for the issuer to force-transfer or burn tokens to remediate non-compliant transfers, exercised through governance-controlled keys.

**Identity layer:** **ERC-3643** (also called T-REX) / **ONCHAINID** — an on-chain identity registry standard. Each wallet that holds tokens is bound to an identity contract that stores KYC status, jurisdiction, OFAC screening, and other compliance claims. The same investor identity can be reused across multiple deals.

**Audience:** Florida real estate sponsor, his counsel, his placement agents, and the development team building the token platform. Technical terms are used where industry-standard vocabulary exists; each is explained in business context the first time it appears.

**Document scope:** What the platform must enforce on-chain, what must be handled off-chain by people and process, and how the two connect. Code is intentionally omitted; the development team translates these requirements into Solidity.

---

## CONFIRMED ISSUER PROFILE

| Attribute                                   | Value                                                         | Source                                                                                                         |
| ------------------------------------------- | ------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Issuer location                             | Florida, USA                                                  | Client input                                                                                                   |
| Business                                    | Real estate (U.S.-situs assets)                               | Client input                                                                                                   |
| Likely entity form                          | Florida LLC, Delaware LLC, or Delaware statutory trust        | Standard real estate SPV practice                                                                              |
| **Domestic vs Foreign**                     | **Domestic issuer**                                           | Rule 902(e) — fails Rule 405 FPI exclusion on both prongs (U.S. ownership + U.S. management/assets/operations) |
| **Reporting status**                        | **Non-reporting issuer**                                      | Rule 902(i) — no §12(b)/(g) registration, no §15(d) filings, no 12-month reporting history                     |
| **Security type**                           | **Equity** (LLC membership / beneficial interest tokenized)   | Token represents pro-rata ownership in property cash flows and disposition proceeds                            |
| **Reg S Category**                          | **Category 3 — domestic-issuer equity** (Rule 903(b)(3)(iii)) | Cross-ref: [reg-s-checklist §3.2 Category 3](../US%20Compliance/reg-s-checklist.md)                            |
| **Distribution compliance period**          | **12 months**                                                 | Rule 903(b)(3)(iii)(A) — 1-year period because non-reporting (6 months would only apply if reporting)          |
| **Restricted-securities status**            | **Permanent under Rule 905**                                  | Rule 905 makes domestic-issuer equity acquired under Reg S "restricted securities" under Rule 144 indefinitely |
| **Rule 144 holding period for U.S. resale** | **12 months**                                                 | Rule 144(d) — non-reporting issuer threshold                                                                   |

## OPERATIONAL CONSTRAINTS THE CLIENT HAS ACCEPTED

Reg S-only is the chosen path. The client has accepted the following constraints — the platform enforces them on-chain, and the offering documents must disclose them prominently:

1. **No sales to any U.S. person for the entire 12-month distribution compliance period, per closing tranche.** Floridians and other U.S.-resident investors cannot subscribe during this window. If the sponsor's existing network is U.S.-heavy, the distribution channel must be built offshore (foreign placement agents, non-U.S. introducers, offshore investor lists).
2. **Tokens are permanent restricted securities under Rule 905.** Even after the 12-month Reg S lockup closes, U.S. resale is gated by Rule 144. For non-affiliate holders — which under the affiliate-free architecture means every holder — the Rule 144 12-month holding period runs **concurrently** with the Reg S compliance period under Rule 144(d)(1)(ii) tacking (measured from the partition's closing date), so both clear at the same moment. The total time from a partition's close to its first eligible U.S. resale is 12 months, NOT 24. For affiliates by operation of law, ongoing restrictions (volume caps, broker-only sales channels, current public information, Form 144 filings) apply that this platform does not support — wallet is `BLOCKED` instead.
3. **No directed selling efforts into the U.S.** Website, marketing, social channels, PR — all must be geo-fenced and U.S.-investor-excluded. A single U.S.-readable promotion can collapse the Reg S safe harbor.
4. **The sponsor cannot personally subscribe under Reg S.** The Florida-resident sponsor is a U.S. person; he cannot buy tokens. His economics come through the LLC promote (see Architectural Decision §1 — Sponsor economics — below), not through token subscription.

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

## ARCHITECTURAL DECISION: AFFILIATE-FREE TOKEN STRUCTURE (LOCKED)

**No affiliate of the issuer will hold tokens.** This is the single most consequential design decision in the project. It removes a substantial layer of compliance machinery from the on-chain logic — Rule 144(e) volume caps, Rule 144(f) manner-of-sale routing, Rule 144(c) current public information attestations, Rule 144(h) Form 144 filings, and the Rule 144(a)(2) household / group-control attribution rules.

The five structural commitments below maintain the affiliate-free architecture:

### 1. Sponsor economics

- [ ] The sponsor does not receive tokens. The sponsor does not subscribe, is not allocated founder tokens, is not granted carry tokens
- [ ] The sponsor's economic interest is structured as **Class B Promote Units** at the LLC operating-agreement level — a separate class of LLC interests outside the token contract entirely
- [ ] Class B Promote Units are paid through the SPV's off-chain distribution waterfall (preferred return → return of capital → split with promote). The token contract never mints to the sponsor's wallet
- [ ] Class B Promote Units are governed by the applicable state LLC law and the LLC operating agreement, not by securities law (assuming a single-holder structure and no public offering of these units)

### 2. Per-investor concentration cap (on-chain enforced)

- [ ] **Hard maximum holding per identity: 9.99% of the token's total supply across ALL partitions** — prevents any single holder from triggering the SEC's presumptive 10%-holder affiliate flag. The affiliate presumption is measured at the **class** level, and the partitions are fungible tranches of one class (segregated only for compliance clocks), so the cap must be the class-wide aggregate — NOT 9.99% of each partition (which would let a holder reach ~N×10% of the class across N closings)
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
  - Household attribution under Rule 144(a)(2)(i) — relative or spouse sharing the same home as an SPV affiliate. The (a)(2)(i) attribution is technically for Rule 144(e) sales-aggregation, but combined with the related party's affiliate status, the holder is treated as a presumptive affiliate under Rule 144(a)(1)
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
  - **Accredited / institutional status flags** (narrow relevance — Rule 902(k)(1)(viii) carve-out for institutional accredited investors)
  - **OFAC / sanctions screening result set** — see §A.1 below for the full framework. Includes: SDN match flag, crypto-address SDN flag, comprehensively-embargoed jurisdiction flag, 50-Percent-Rule beneficial-ownership flag, last screening timestamp, SDN list version at screening, screening provider ID
  - **Investor classification:** `DISTRIBUTOR` (placement agent's own holding), `NON_US_PERSON` (standard offshore investor), `US_PERSON_QUALIFIED` (rare — purchase did not require registration), `BLOCKED` (suspended for any reason, including affiliate-creating events or OFAC flag)
- [ ] The identity registry must be **updatable** by an authorized compliance role — investors can become U.S. persons (move residency), lose accredited status, get sanctioned. Status changes propagate immediately to every subsequent `canTransfer` decision
- [ ] The identity registry contract is **separate and upgradeable** independently of the token contract. KYC rules and identity claims can evolve without redeploying the token; the same identity is reusable across multiple security tokens

---

## A.1 — OFAC Sanctions Compliance — Implementation

> **Source authority for this section:** [ofac-checklist.md](../US%20Compliance/ofac-checklist.md) — single source of truth for the OFAC sanctions framework (31 CFR Chapter V, SDN List, Executive Orders, program-specific regulations, virtual currency guidance). This section describes only the implementation-specific application of those requirements to the platform; refer to the checklist for: U.S.-person scope, the full landscape of OFAC programs, the SDN/SSI/FSE/non-SDN list inventory, screening provider selection, blocking and reporting workflows, General and Specific License framework, voluntary self-disclosure procedure, virtual-currency-specific guidance, recent crypto enforcement actions, and penalty structure.

### A.1.1 — Why OFAC Applies to This Deployment

The issuer is U.S.-domiciled. Every U.S. person in the transaction chain (issuing SPV, placement agent, KYC provider, smart contract operator, brokers, transfer agents) is subject to OFAC on a **strict liability** basis. OFAC obligations are **independent of and cumulative with** Reg S, Rule 144, and AML — satisfying any of those does not relieve OFAC. See [ofac-checklist.md §1](../US%20Compliance/ofac-checklist.md) for the full U.S.-person scope.

### A.1.2 — On-Chain Implementation of the Four Screening Dimensions

The identity registry (Section A) stores the OFAC screening result set covering all four dimensions defined in [ofac-checklist.md §4.1](../US%20Compliance/ofac-checklist.md):

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

See [ofac-checklist.md §4.2](../US%20Compliance/ofac-checklist.md) for full screening cadence requirements and [§9.1](../US%20Compliance/ofac-checklist.md) for the OFAC-recommended five-component Sanctions Compliance Program.

### A.1.4 — Blocking and Reporting Workflow

When screening identifies a match (at subscription, during continuous re-screening, or pre-distribution):

- [ ] **Immediate on-chain freeze** — wallet flagged `BLOCKED` in identity registry. All outgoing transfers and incoming distributions revert in `canTransfer`. Tokens remain in the wallet (not seized) but cannot move
- [ ] **`BlockedTransactionRecorded` event** triggers the off-chain workflow to file **TD F 90-22.50 — Report of Blocked Transactions** with OFAC within **10 business days** (per [ofac-checklist.md §6.1](../US%20Compliance/ofac-checklist.md))
- [ ] **`BlockedPropertyHeld` event** feeds the **Annual Report of Blocked Property (ARG)** due by September 30 each year (per [ofac-checklist.md §6.3](../US%20Compliance/ofac-checklist.md))
- [ ] **No release without OFAC authorization** — `BLOCKED` status can only be cleared by manual compliance officer action with documented OFAC license (General or Specific — see [ofac-checklist.md §7](../US%20Compliance/ofac-checklist.md)). On-chain audit trail records the license reference

### A.1.5 — Items NOT Implemented On-Chain (Refer to OFAC Checklist)

| Concern                                                                                                                           | Location                                                                                          |
| --------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| OFAC General License terms (compliance with humanitarian, journalistic, etc. exceptions)                                          | Compliance officer + counsel; see [ofac-checklist.md §7.1](../US%20Compliance/ofac-checklist.md)  |
| Specific License applications                                                                                                     | Counsel; see [ofac-checklist.md §7.2](../US%20Compliance/ofac-checklist.md)                       |
| Voluntary self-disclosure procedure                                                                                               | Counsel; see [ofac-checklist.md §8](../US%20Compliance/ofac-checklist.md)                         |
| Sanctions Compliance Program (SCP) framework — management commitment, risk assessment, internal controls, testing/audit, training | Firm-level; see [ofac-checklist.md §9.1](../US%20Compliance/ofac-checklist.md)                    |
| 5-year sanctions records retention (31 CFR § 501.601)                                                                             | Off-chain compliance database; see [ofac-checklist.md §6.4](../US%20Compliance/ofac-checklist.md) |

### A.1.6 — Penalty Exposure (Founder-Level Awareness)

Civil: up to the greater of ~$311,562 per violation (2024) or 2× transaction value, strict liability. Criminal (willful): up to $1M and 20 years per individual violation. Plus reputational and banking-relationship consequences. See [ofac-checklist.md §10](../US%20Compliance/ofac-checklist.md) for the full penalty framework and recent crypto enforcement comparables.

The offering memorandum discloses the OFAC compliance framework; the compliance officer receives mandatory OFAC training; OFAC penalty exposure is included in the firm's risk register and D&O insurance scope.

---

## B. Transfer Validation — `canTransfer` / `canTransferByPartition`

_Cross-reference: checklist §3.2 Category 3, §6.3 (Investor Verification & KYC Controls)_

The ERC-1594 `canTransfer` hook (and its partition-aware counterpart `canTransferByPartition`) is the on-chain enforcement point for every Reg S and Rule 144 rule. It runs before every transfer and either allows it or reverts with a specific reason code. ERC-1066 status codes are used where they apply, so wallets and explorers can display human-readable rejection reasons.

The hook enforces both:

- **Rule 903 conditions** (issuer-side safe harbor) — applies at mint and to any transfer from the issuer, a distributor, or any of their affiliates. The Rule 903 path is the primary issuance path through `mint` (§I)
- **Rule 904 conditions** (offshore-resale safe harbor) — applies to peer-to-peer secondary transfers by non-issuer holders. Rule 904's universal conditions are enforced through these gates: (a) the offshore-transaction prong (Rule 902(h)) is enforced via the U.S.-person check below — the sale is not made to a person in the U.S.; (b) the "no directed selling efforts by the seller" condition is captured as a binding covenant in the Subscription Agreement (§E Document 4) and is not on-chain enforceable — relies on the seller's covenant plus off-chain monitoring; (c) the Rule 904(b)(1) dealer-confirmation notice requirement is handled via the `DistributorConfirmationRequired` event (§H) routed to the placement agent's off-chain workflow

The hook returns `false` (reject) when:

- [ ] Recipient is **not in the identity registry** (no KYC) → reason: `"NO_KYC"`
- [ ] Recipient is a **U.S. person** AND the distribution compliance period has not expired AND recipient is not classified as `DISTRIBUTOR` → reason: `"REG_S_US_PERSON_RESTRICTED"`. This is the core Rule 903(b)(3)(iii)(A) gate during the 12-month lockup
- [ ] Recipient or sender is **OFAC-flagged** in the identity registry — covering any of the four OFAC failure modes from §A.1.2: (1) SDN-listed identity, (2) SDN-listed wallet address, (3) comprehensively-sanctioned country of residence (Cuba, Iran, North Korea, Syria, Crimea/Donetsk/Luhansk/Kherson/Zaporizhzhia), or (4) 50%+ aggregated ownership by SDN-listed persons. Strict liability — check applies on both sender AND recipient on every transfer → reason: `"OFAC_BLOCKED"`. Stale OFAC screening (>30 days old) also rejects → reason: `"OFAC_SCREENING_STALE"`
- [ ] Sender is flagged `BLOCKED` (covers any holder who became an affiliate by operation of law under the affiliate-free architecture) → reason: `"SENDER_BLOCKED"`
- [ ] Sender or recipient identity record has **stale KYC** beyond the re-verification window (e.g., 12 months since last KYC refresh) → reason: `"KYC_EXPIRED"`
- [ ] Transfer is **for the account or benefit of a U.S. person** — pure on-chain detection is impossible; the hook requires either (a) an EIP-712 signed attestation by the compliance officer for transfers above a threshold, or (b) a beneficial-ownership claim recorded in the identity registry — see Section L for the off-chain → on-chain pattern
- [ ] Transfer would breach the **Rule 144 holding period** for a U.S.-person recipient relying on Rule 144 (12 months for this non-reporting issuer) — see Section D
- [ ] Transfer would push the **recipient's aggregate balance over 9.99% of the token's total supply across all partitions** (concentration cap; enforces the affiliate-free architecture) → reason: `"CONCENTRATION_CAP_EXCEEDED"`. The cap is checked against the sum of balances across all wallets **and all partitions** linked to the recipient's identity in the registry — the class-level aggregate, not just the destination wallet or partition

Return codes follow ERC-1066 (Ethereum Status Codes) where possible for explorer and wallet compatibility.

---

## C. Distribution Compliance Period Logic (the 12-Month Lockup per Closing)

_Cross-reference: checklist §3.2 Category 3 equity (Rule 903(b)(3)(iii)(A))_

**Locked for this issuer profile: 12-month compliance period per closing tranche.** (`isReportingIssuer = false` → Rule 903(b)(3)(iii)(A) 1-year branch applies. The 6-month branch would only apply if the issuer were a public reporting company.)

- [ ] Storage on-chain: a `distributionComplianceEnd` timestamp **per partition** (closing tranche), set per Rule 902(f)'s "later of" rule — the LATER of (a) the date securities were first offered to persons OTHER than distributors, or (b) the date of closing of the offering. In typical primary offerings the closing date controls; in rare structures where non-distributor offers begin after closing, the offer date controls. The issuer sets the value at each closing based on the actual offer/close timeline
- [ ] Storage on-chain: an `isReportingIssuer` boolean — hard-coded `false` for this client until/unless he later registers under the Exchange Act. The boolean stays in the contract so the same code can serve a future reporting-issuer deployment without redeployment
- [ ] **Per-partition compliance period** via ERC-1410 partitions — real estate offerings typically close in waves (subscription period → first close → interim closes → final close). Each closing tranche gets its own ERC-1410 partition with an independent 12-month clock starting from that closing date. A single global clock would force every subscriber to wait until the last close before any tokens become tradeable, which is unfair to early subscribers
- [ ] **Rule 902(f) interpretation caveat:** Rule 902(f)(2) states that in a _continuous offering_, the distribution compliance period commences upon "completion of the distribution, as determined and certified by the managing underwriter." A strict reading treats the entire rolling-close offering as a single offering with one compliance period beginning at final close. The per-tranche-per-partition approach used here is a practitioner interpretation treating each closing tranche as a discrete offering for distribution-compliance purposes. This is the dominant practice for real estate STOs but is not the only defensible reading of Rule 902(f). Confirm with counsel that the chosen interpretation matches the offering's distributor-agreement and offering-document language, and consider documenting the per-tranche treatment explicitly in the placement agent's distribution-completion certification
- [ ] During the 12-month compliance period for a given partition, `canTransfer` enforces all of Section B's checks plus:
  - Distributor confirmation event emission when a token is transferred to a known dealer or selling-concession recipient (Rule 903(b)(3)(iv)) — emits `DistributorConfirmationRequired` for the off-chain placement agent to action
  - Buyer recertification event when a partition is transferred to a new wallet during the period — the new holder must reaffirm non-U.S.-person status (Rule 903(b)(3)(iii)(B)(1))
- [ ] **After** the 12-month period expires for a given partition, U.S.-person transfers become eligible for Rule 144 analysis but the **restricted-securities status persists indefinitely** — see Section D

> **Architecture note:** ERC-1410 partitions are the correct mechanism for tranche segregation. They give each closing tranche its own clock and its own Rule 144 holding period, while keeping the tokens fungible for distribution and reporting purposes.

> **Client conversation point:** Confirm with the sponsor that the offering has a defined final-close date. If the deal stays open-ended (rolling close indefinitely), each new subscription doesn't reset prior subscribers' clocks, but each new partition adds another 12-month clock to manage. Three or more years of overlapping clocks is operationally manageable but worth surfacing.

---

## D. Permanent Restricted-Securities Status — Rule 905

_Cross-reference: checklist §5 (Resale Limitations), §8.3 (Rule 144 interaction)_

**This is the trap most token issuers miss.** Even after the Reg S compliance period expires, the tokens remain Rule 144 "restricted securities" **forever** because the issuer is domestic. The compliance period is time-limited; the restricted-status is permanent.

Under the affiliate-free architecture, every holder is by structural commitment a **non-affiliate**. Rule 144's clean non-affiliate path (Rule 144(b)(1)(ii) for non-reporting issuers) applies: after 12 months of holding (with automatic tacking from the partition's issuance date), a non-affiliate can resell to U.S. persons with no volume cap, no manner-of-sale restriction, no current-information requirement, no Form 144.

- [ ] **Per-partition storage on-chain: `issuanceTimestamp`** (= the closing date of the partition's tranche). This is the date the securities first left the issuer for that partition, and the date from which the Rule 144 12-month clock measures for **ALL** holders in the partition. Under the affiliate-free architecture, every transfer chain is non-affiliate-to-non-affiliate, so Rule 144(d)(1)(ii)'s "any subsequent holder" tacking applies — the clock measures from the partition's `issuanceTimestamp`, NOT from each holder's personal acquisition date (see [rule-144-checklist.md §5.1a](../US%20Compliance/rule-144-checklist.md) for the verbatim source)
- [ ] **No per-holder `acquisitionTimestamp` needed for Rule 144 purposes.** All non-affiliate holders in the same partition share the same Rule 144 clock — measured from `partition.issuanceTimestamp`. A per-holder `lastReceivedTimestamp` may still be useful for audit trail, distribution snapshots, or tax reporting, but it does NOT factor into the Rule 144 holding-period check
- [ ] **Rule 144 clock and distribution compliance period clock ALIGN.** Under this implementation, `partition.distributionComplianceEnd = partition.issuanceTimestamp + 12 months` (for non-reporting issuer Cat 3 equity per Rule 903(b)(3)(iii)(A); 6 months for the reserved reporting-issuer path). The Reg S distribution compliance period and the Rule 144 12-month holding period CLEAR AT THE SAME MOMENT for every non-affiliate holder in the partition. The two gates in `canTransfer` are checking effectively the same condition — passing one means passing the other. This alignment is a real architectural simplification flowing from the affiliate-free decision plus the choice to use partition-level (not per-holder) Rule 144 clock tracking
- [ ] `canTransfer` checks: if recipient is a U.S. person and is not relying on registration or another exemption, has `block.timestamp >= partition.issuanceTimestamp + 365 days` been satisfied?
- [ ] **No affiliate-seller branching needed in `canTransfer`** — under the affiliate-free architecture, the identity registry never carries an "affiliate" classification. Any holder who becomes an affiliate by operation of law is flagged `BLOCKED` instead, and the affiliate path is closed entirely. The full Rule 144 affiliate-seller conditions (volume cap, manner-of-sale, current public information, Form 144) are described in [rule-144-checklist.md](../US%20Compliance/rule-144-checklist.md) §§ 6–9 — referenced for completeness but not implemented in this contract

---

## E. Legends & Documents — ERC-1643

_Cross-reference: checklist §3.2 Category 3 (B)(3), §6.2 (Legend Requirements)_

ERC-1643's document registry is a standardized way for the token to publish references to legal documents. Each document is registered as a (name, URI, hash) triple — the URI points to the document's hosted location, the hash is the cryptographic fingerprint that lets any reader verify they're looking at the authentic version. The platform publishes the following:

- [ ] **Document 1: Reg S unregistered-securities legend** — _"The securities … have not been registered under the U.S. Securities Act of 1933, as amended, and may not be offered or sold in the United States or to U.S. persons (other than distributors) unless registered under the Act or an applicable exemption from registration is available."_
- [ ] **Document 2: Hedging-restriction legend** — _"Hedging transactions involving these securities may not be conducted unless in compliance with the U.S. Securities Act of 1933."_
- [ ] **Document 3: Transfer-restriction legend** (Cat 3 domestic equity) — transfer prohibited except per Reg S / registration / exemption
- [ ] **Document 4: Subscription / Purchase Agreement template hash** — the cryptographic fingerprint of the executed agreement template, with purchaser certifications and resale covenants
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
- [ ] Emit a `HedgingRestrictionAcknowledged` event when a purchaser signs their subscription — creates an on-chain audit trail of the investor's acknowledgement
- [ ] Block transfers to contracts flagged as short-position venues during the compliance period — same blocklist mechanism
- [ ] Block deposits into wrap contracts (e.g., bridging to a synthetic short via a wrapper that mints a transferable representation) — wrap contracts effectively transfer beneficial ownership and would be a hedging route around the on-chain rule

---

## H. Events for Off-Chain Monitoring

_Cross-reference: checklist §6.4 (Monitoring During the Distribution Compliance Period)_

On-chain compliance monitoring depends on rich, structured events emitted by the token and identity registry. The platform emits:

- [ ] `TransferAttempted(from, to, partition, amount, reasonCode, allowed)` — emitted on every transfer attempt, including rejected ones, so off-chain monitoring can detect probing patterns (e.g., sanctioned wallets repeatedly trying to receive tokens)
- [ ] `KYCStatusChanged(investor, oldStatus, newStatus, timestamp)` — for compliance audit and investor onboarding history
- [ ] `OFACScreeningCompleted(investor, timestamp, result, screeningProviderId, sdnListVersion)` — sanctions trail; SDN list version is required for the audit record (which version of the list was the screening run against?)
- [ ] `SDNStatusChanged(investor, oldStatus, newStatus, listVersion)` — emitted when an existing holder is newly added to OR removed from the SDN list during continuous re-screening. Triggers immediate freeze (added) or release (removed, subject to OFAC license requirements per §A.1.5)
- [ ] `BlockedTransactionRecorded(party, counterparty, transactionType, amount, partition, reasonCode, timestamp)` — emitted every time a transfer is rejected for OFAC reasons. Feeds the off-chain workflow for filing TD F 90-22.50 (Report of Blocked Transactions) with OFAC within **10 business days** of the blocking event (§A.1.4)
- [ ] `BlockedPropertyHeld(holder, partition, amount, blockingDate)` — emitted on the original blocking event and tracked for the Annual Report of Blocked Property due September 30 each year (§A.1.4)
- [ ] `DistributorConfirmationRequired(distributor, downstreamDealer, partition)` — triggers the off-chain Rule 903(b)(3)(iv) confirmation notice workflow at the placement agent
- [ ] `ComplianceFlagRaised(holder, flagType, evidence)` — when off-chain monitoring detects a suspicious pattern (e.g., a wallet receiving tokens from a known mixer)
- [ ] `PartitionComplianceExpired(partition, timestamp)` — emitted when a partition's distribution compliance period ends; signals the world that the partition is now eligible for Rule 144 secondary trading
- [ ] `RestrictedSecuritiesNoted(holder, partition, amount)` — emitted on every U.S.-person sale post-compliance-period to flag the Rule 144 tracking obligation

These events form the SEC evidence file. Every off-chain monitoring tool and every future SEC inquiry will reconstruct compliance posture from this event stream.

---

## I. Subscription / Mint Flow

_Cross-reference: checklist §6.1 (Pre-Offering Documentation), §6.3 (Investor Verification)_

Initial issuance happens through the `mint` function (or its partition-aware equivalent). Every primary sale must satisfy the **Rule 902(h) two-prong offshore-transaction test**:

- **Prong A** — the offer is not made to a person in the United States. Enforced via the recipient U.S.-person check (item below). Implicit in the identity-registry classification: the recipient must not be flagged `US_PERSON` (unless qualified under the narrow U.S.-person carve-out)
- **Prong B** — at the time the buy order is originated, the buyer is outside the United States, or the seller (issuer / placement agent) reasonably believes so. Enforced via the EIP-712 mint-authorization attestation signed by the placement agent (per §L.1 item 6) — the attestation represents the placement agent's contemporaneous reasonable belief based on KYC, IP geolocation, and the purchaser's declared location at the time of the order

**Rule 902(h)(2) exclusion — U.S. citizens abroad:** offers and sales specifically targeted at identifiable groups of U.S. citizens abroad (e.g., U.S. armed forces personnel serving overseas) are NOT offshore transactions, regardless of physical location. Distribution channels must not specifically target U.S. citizens abroad as a class. This is enforced through marketing policy (§J) and the placement agent's binding representations in its placement agreement.

Before any tokens are minted, the platform must verify:

- [ ] Signed off-chain subscription agreement hash present — the cryptographic fingerprint of the executed agreement is recorded
- [ ] Purchaser-classification proof — either a Merkle proof against the published subscription whitelist, or an oracle attestation from the KYC provider (see Section L for the mechanism trade-offs)
- [ ] Signed certification that the purchaser is not a U.S. person AND not acquiring for U.S. account/benefit, OR is a U.S. person whose purchase did not require registration (Rule 903(b)(3)(iii)(B)(1)) — typically an EIP-712 signed message from the investor
- [ ] **Resale-restriction and hedging covenant from purchaser** (Rule 903(b)(3)(iii)(B)(2)) — the executed Subscription Agreement (§E Document 4) contains the purchaser's binding covenant to (a) resell only in accordance with Reg S, registration, or another exemption, AND (b) not engage in hedging transactions unless in compliance with the Securities Act. The platform records the agreement hash; the covenant itself is enforced via legal recourse, not via on-chain check
- [ ] EIP-712 mint-authorization attestation by the placement agent (Rule 902(h) Prong B) — fresh within a 24-hour window; signed by the placement agent's compliance signer; attests to the offshore-buyer reasonable belief based on KYC + IP geolocation + declared location at order origination
- [ ] OFAC screening result is fresh (within e.g. 30 days) at mint time
- [ ] Recipient wallet is registered in the identity registry; mints to unregistered wallets are rejected
- [ ] Recipient's resulting balance does not exceed the 9.99% concentration cap (measured on the identity's class-wide aggregate across all wallets and partitions)
- [ ] Emit `PurchaserCertified(investor, subscriptionHash, certificationType, partition)` event at mint
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
| Concurrent Reg D integration analysis (§8.1)                                                                | Counsel + offering structure                                                             |
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

1. **ERC-1410 Partitioned Token** — one partition per closing tranche. Each partition carries its own 12-month compliance clock independently
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
│  - Rule 144 tracking    │      │  - KYC status          │
│  - Hedging blocklist    │      │  - U.S. person flag    │
│  - Compliance periods   │      │  - OFAC status         │
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

| #   | Compliance check                                                       | Off-chain action                                                             | What gets to the chain                                             | On-chain validation point                                                                                                                                                  |
| --- | ---------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | KYC identity verification                                              | KYC provider (Jumio, Onfido, Sumsub) runs document + liveness check          | Status flag + verification timestamp written to identity registry  | `canTransfer` reads registry every transfer                                                                                                                                |
| 2   | U.S. person classification (Rule 902(k))                               | KYC review + residency + entity-structure analysis                           | Boolean flag + ISO jurisdiction code in identity registry          | `canTransfer` rejects U.S.-flagged recipient during compliance period                                                                                                      |
| 3   | OFAC SDN screening                                                     | Sanctions screening service (Chainalysis, TRM Labs, ComplyAdvantage)         | Status flag + screening timestamp in identity registry             | `canTransfer` blocks on flagged sender OR recipient                                                                                                                        |
| 4   | "For account or benefit of U.S. person" determination (Rule 902(h))    | Compliance officer manual review for nominee structures, trust beneficiaries | EIP-712 signed attestation per transfer above threshold            | `canTransfer` verifies signature + expiry for high-value transfers                                                                                                         |
| 5   | Reg S purchaser certification (Rule 903(b)(3)(iii)(B)(1))              | Investor signs subscription agreement off-chain                              | Document hash + investor EIP-712 signature recorded at mint        | `mint` requires signed certification reference                                                                                                                             |
| 6   | Reasonable belief buyer is offshore at order origination (Rule 902(h)) | Sponsor / placement agent based on KYC, IP geolocation, declarations         | EIP-712 signed mint-authorization attestation by compliance signer | `mint` verifies signature freshness (24-hour window)                                                                                                                       |
| 7   | Distributor confirmation notice sent (Rule 903(b)(3)(iv))              | Placement agent emails confirmation off-chain                                | Notice hash + recipient + timestamp emitted in event log           | Per transfer to known dealer/concession recipient                                                                                                                          |
| 8   | Reg S compliance period (Rule 903(b)(3)(iii)(A))                       | None — pure timestamp arithmetic                                             | N/A (fully on-chain)                                               | `canTransfer` compares `block.timestamp` to partition's `distributionComplianceEnd`                                                                                        |
| 9   | Rule 144 holding period (post-compliance period U.S. resale)           | None — pure timestamp arithmetic                                             | N/A (fully on-chain)                                               | `canTransfer` for U.S.-bound resale checks `block.timestamp >= partition.issuanceTimestamp + 365 days` (partition-level clock; Rule 144(d)(1)(ii) tacking — see Section D) |

Items 8 and 9 are the only purely on-chain checks. Everything else is a hybrid where off-chain decisions need a trustworthy path onto the chain.

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

| Off-chain role               | What they attest to                                        | On-chain mechanism                                    | Compromise impact                                                        |
| ---------------------------- | ---------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------ |
| KYC provider                 | Identity, residency, U.S.-person status                    | Identity registry write role (provider's address)     | Bad actors get KYC clearance → identity gate fails for some investors    |
| Sanctions screening provider | OFAC / sanctions status                                    | Identity registry write role (separate from KYC)      | Sanctioned actors clear screening → OFAC violation                       |
| Compliance officer           | Edge-case determinations, beneficial-ownership reviews     | EIP-712 signer                                        | Signed-off bad transfers; mitigated by per-attestation amount limits     |
| Sponsor / GP                 | Mint authorization, offering close timestamps              | Multi-sig controller (M-of-N)                         | Unauthorized mints; mitigated by M-of-N and time-lock on threshold mints |
| Placement agent              | Distributor notification, offshore-buyer reasonable belief | EIP-712 signer (separate key from compliance officer) | False offshore-buyer claims; signer scope limited to specific facts      |
| Contract upgrader            | Compliance rule changes                                    | Multi-sig + time-lock + governance                    | Rule changes; mitigated by 7+ day time-lock allowing investor review     |

Every role above is a potential compromise vector. **Multi-sig + time-lock + segregated signer scope** is non-negotiable for production deployment. Document each role, its key custody arrangement, and its rotation schedule in the offering memorandum.

---

## M. Single Biggest Design Risk

**Treating Cat 3 domestic equity restrictions as expiring at 12 months.** They don't. Rule 905 makes them **restricted securities perpetually**. The contract logic needs two **separate states**:

1. **Reg S compliance period active** — time-limited (12 months for this non-reporting issuer), gates U.S.-person transfers entirely
2. **Rule 144 restricted-status** — permanent for the life of the token, gates U.S.-person resales unless registration or exemption is available

Conflating the two will let restricted tokens leak into unrestricted U.S. trading after the 12-month compliance period expires, creating Section 5 / Section 12(a)(1) rescission liability for the issuer and the offshore reseller. The on-chain `canTransfer` logic must check both states independently — passing one is not enough.

---

## N. Pre-Deployment Verification Checklist

Before mainnet deployment:

- [ ] Independent smart contract security audit (compliance logic + standard reentrancy / access control)
- [ ] Reg S condition mapping document — every contract function annotated with the Rule it enforces (auditor and SEC-reviewer friendly)
- [ ] Test coverage of every `canTransfer` reason code with both pass and fail paths
- [ ] Test coverage of ERC-1410 partition compliance period transitions (before / at / after expiry)
- [ ] Test coverage of Rule 144 holding period math for the affiliate-free non-reporting issuer scenario (and the reserved reporting-issuer path for future deployments)
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
- **The offering** — Reg S Category 3, single primary close at **T=0** (chosen for simplicity; production deployments typically use multiple per-tranche closings, each carrying its own 12-month clock per ERC-1410 partitioning)
- **Compliance period** — 12 months per Rule 903(b)(3)(iii)(A), non-reporting issuer branch
- **Rule 144 holding period** — 12 months per Rule 144(d)(1)(ii), non-reporting issuer threshold

### Cast

| Actor       | Location    | Status                                      |
| ----------- | ----------- | ------------------------------------------- |
| Investor A  | Mexico City | Non-U.S. person                             |
| Investor B  | Munich      | Non-U.S. person                             |
| Investor C  | Tokyo       | Non-U.S. person                             |
| Investor D  | Los Angeles | U.S. person (accredited)                    |
| Investor E  | New York    | U.S. person (retail)                        |
| The Sponsor | Florida     | U.S. person AND affiliate (manages the SPV) |

### The Two Clocks

- 🟥 **Distribution compliance period clock** — runs from T=0 to T+12mo. The Reg S strict gate.
- 🟦 **Rule 144 holding period clock** — starts independently for each holder on the date they acquire tokens; runs 12 months. The restricted-securities gate.

---

### Scenario 1 — Primary Offering Day (T=0)

**1a. Investor A buys 1,000 tokens directly from the SPV**

- Investor A is in Mexico City; signs subscription offshore; wires from a Mexican bank
- 🟥 Distribution clock just started — Investor A is non-U.S. person → fine
- 🟦 Rule 144 clock starts for Investor A at T=0
- **Result: ✅ ALLOWED.** Investor A holds 1,000 tokens
- Tokens carry the permanent "restricted securities" label under Rule 905

**1b. Investor D tries to buy 500 tokens directly from the SPV**

- Investor D is a U.S. resident
- 🟥 Distribution clock active — Reg S blocks ALL U.S.-person sales during this window
- Accredited status does not help. Signing from a Bali villa does not help. Investor D is a U.S. resident under Rule 902(k)
- **Result: ❌ BLOCKED** — `REG_S_US_PERSON_RESTRICTED`

**1c. The Sponsor tries to subscribe for 5,000 tokens**

- Sponsor is U.S. resident AND an affiliate of the SPV
- 🟥 Distribution clock active — same gate as Investor D
- **Result: ❌ BLOCKED.** Sponsor economics must come through LLC-level Class B Promote Units, not through tokens. (This is the affiliate-free architectural commitment.)

---

### Scenario 2 — Three Months Later (T+3mo)

**2a. Investor A wants to sell 100 tokens to Investor B (offshore-to-offshore)**

- Both non-U.S. persons
- 🟥 Distribution clock still active (9 months remaining)
- Transfer is offshore-to-offshore — Rule 902(h) offshore-transaction test satisfied via the Rule 904 secondary-resale path
- 🟦 Rule 144 clock: only 3 months elapsed for Investor A — but Rule 144 only matters for U.S.-person sales
- **Result: ✅ ALLOWED.** Investor B now holds 100 tokens
- Tokens in B's hands are still "restricted securities" — the label travels with the tokens

**2b. Investor A wants to sell 100 tokens to Investor D (offshore to U.S.)**

- Investor D is a U.S. person
- 🟥 Distribution clock still active — strict no-U.S.-persons rule applies regardless of who is selling
- 🟦 Rule 144 holding period: only 3 months — insufficient anyway
- **Result: ❌ BLOCKED.** Both gates fail; the Reg S strict gate alone is sufficient

**2c. Investor C sells 200 tokens to Investor E**

- 🟥 Distribution clock still active
- **Result: ❌ BLOCKED.** Same reason as 2b

---

### Scenario 3 — Eleven Months In (T+11mo)

**3a. Investor B wants to sell to Investor D**

- 🟥 Distribution clock still active (1 month to go)
- **Result: ❌ BLOCKED.** Even with 30 days remaining, the strict Reg S rule still applies. The smart contract does not care that the clock is "almost done"

---

### Scenario 4 — Day After Distribution Period Expires (T+12mo + 1 day)

🟥 **Distribution compliance period: EXPIRED.** The Reg S strict gate is now OPEN.

The tokens are still "restricted securities" — the label is permanent. Now Rule 144 governs U.S. resales.

**4a. Investor B wants to sell 100 tokens to Investor D**

- 🟥 Distribution clock: ✅ EXPIRED
- 🟦 Rule 144 holding period for Investor B: **tacks back to Investor A's original acquisition at T=0** — automatic non-affiliate-to-non-affiliate tacking under Rule 144(d)(1)(ii). The 12-month clock measures from when the securities first left the issuer, not from each subsequent transfer. 12 months + 1 day has elapsed since T=0 → ✅ MET
- Investor B is a non-affiliate
- **Result: ✅ ALLOWED.** Investor D now holds 100 tokens
- Tokens in D's hands lose the "restricted" label — Rule 144 non-affiliate sale washed it off

> 💡 **Tacking rule (Rule 144(d)(1)(ii)):** _"a minimum of one year must elapse between the later of the date of the acquisition of the securities from the issuer, or from an affiliate of the issuer, and any resale of such securities in reliance on this section **for the account of either the acquiror or any subsequent holder of those securities.**"_ When Investor A (a non-affiliate) sold to Investor B at T+3mo, B's Rule 144 clock tacked back to A's original acquisition at T=0 — it did NOT restart at T+3mo. This automatic tacking is the general rule for ordinary non-affiliate-to-non-affiliate transfers; it is NOT one of the Rule 144(d)(3) "special situations." Without this rule, restricted securities could never trade in a secondary market in any practical way.

> ⚠️ **When tacking does NOT apply (counterfactual):** If Investor B had instead acquired the tokens directly from the issuer at T+3mo (hypothetically — not possible in a Reg S Cat 3 offshore-only offering, but illustrative), OR from an **affiliate** of the issuer at T+3mo, B's Rule 144 clock would start fresh on the date B acquired. Purchase from an affiliate is treated like purchase from the issuer for Rule 144 holding-period purposes. Tacking only applies between non-affiliates. This is the practical reason the affiliate-free architecture matters — any holder who becomes an affiliate by operation of law would disrupt the tacking chain for tokens passing through their hands.

**4b. Investor A wants to sell 100 tokens to Investor D**

- 🟥 Distribution clock: ✅ EXPIRED
- 🟦 Rule 144 holding period for Investor A: acquired at T=0, has held 12 months + 1 day — ✅ MET
- Investor A is a non-affiliate (passive investor)
- Rule 144 non-affiliate path for non-reporting issuers (Rule 144(b)(1)(ii)) — no volume cap, no manner-of-sale restriction, no current-info requirement, no Form 144
- **Result: ✅ ALLOWED.** Investor D now holds 100 tokens
- Tokens in D's hands **lose the "restricted" label** — the Rule 144 non-affiliate sale washed it off

> ⚠️ **Critical contrast:** if Investor A had instead sold via Rule 904 (offshore-to-offshore) at the same moment, the tokens would **stay** restricted regardless of how many times traded offshore. The label only comes off via a Rule 144 non-affiliate resale.

**4c. The Sponsor (counterfactually holding tokens) tries to sell to Investor E**

- Note: under the affiliate-free architecture, the Sponsor **does not hold tokens**. This scenario is a counterfactual to illustrate why
- 🟥 Distribution clock: ✅ EXPIRED
- 🟦 Rule 144 holding period: assume ✅ MET
- BUT the Sponsor is an **affiliate** → ongoing Rule 144 restrictions never lift:
  - Volume limit (Rule 144(e)): greater of 1% of outstanding OR average weekly trading volume × 13 (90-day window)
  - Manner of sale (Rule 144(f)): broker transaction or to a market maker only
  - Current public information (Rule 144(c)): non-reporting issuer must maintain a Rule 15c2-11 information statement on file — the practical killswitch
  - Form 144 (Rule 144(h)): required if sale > 5,000 tokens OR > $50,000 in 3 months
- **Result: ⚠️ Theoretically ALLOWED, practically near-frozen.** This is precisely why the affiliate-free architecture exists — the Sponsor never holds tokens to begin with

---

### Scenario 5 — Two Years In (T+24mo)

**5a. Investor D (who bought from Investor A at T+12mo+1 day) wants to sell to Investor E**

- Investor D's tokens are NOT restricted — the label was washed when Investor A made the Rule 144 non-affiliate sale to Investor D
- No Reg S analysis, no Rule 144 analysis needed
- **Result: ✅ ALLOWED.** Investor E now holds the tokens free and clear

**5b. Investor B (who never sold) wants to sell 100 tokens to Investor E**

- 🟥 Distribution clock: ✅ EXPIRED long ago
- 🟦 Rule 144 holding period for Investor B: 24mo - 3mo = 21 months ✅ MET
- Non-affiliate, non-reporting issuer, holding period > 12 months
- **Result: ✅ ALLOWED.** Investor E now holds B's tokens free of restriction (label washed off via Rule 144 non-affiliate path)

---

### The Two Clocks Distinguished

| Concept                               | What is it?                                | When does it apply?                                                                                               | What does it do?                                                                                                                                                                            |
| ------------------------------------- | ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🟥 **Distribution compliance period** | A TIME WINDOW measured from offering close | T=0 → T+12mo (12 months total)                                                                                    | Blocks every U.S.-person sale by anyone — issuer, distributors, secondary sellers. After expiry, the Reg S gate is OPEN                                                                     |
| 🟦 **Restricted-securities status**   | A LABEL on the token itself (Rule 905)     | Forever — the label never comes off as long as the security exists in someone's hands who acquired it under Reg S | Gates U.S. resales through Rule 144 conditions (mainly the holding period). Once a non-affiliate properly resells under Rule 144, the tokens in the buyer's hands lose the restricted label |

### Smart Contract Translation

`canTransfer(from, to, amount)` for a U.S.-person recipient at any time T:

```
1. Is the recipient a U.S. person? (read IdentityRegistry)
   If NO  → only check OFAC, KYC → likely ALLOW
   If YES → continue:

2. 🟥 Has the distribution compliance period for the SENDER's partition expired?
   (block.timestamp >= partition.distributionComplianceEnd)
   If NO  → BLOCK with reason REG_S_US_PERSON_RESTRICTED
   If YES → continue:

3. 🟦 Has the Rule 144 12-month holding period for the partition cleared?
   (block.timestamp >= partition.issuanceTimestamp + 365 days)
   Under Approach B + Rule 144(d)(1)(ii) tacking, this measures from the
   partition's issuance date (closing date), NOT from each holder's personal
   acquisition. All non-affiliate holders in the partition share this clock.
   For non-reporting issuer Cat 3 equity, this gate clears at the SAME
   moment as gate 2 (both = partition.issuanceTimestamp + 12 months).
   If NO  → BLOCK with reason RULE_144_HOLDING_PERIOD_NOT_MET
   If YES → continue:

4. Is the SENDER an affiliate?
   Under the affiliate-free architecture, NO holder is classified as affiliate.
   Affiliate-creating events trigger BLOCKED status instead (Architectural Decision §4).
   If sender is BLOCKED → reject earlier in canTransfer with SENDER_BLOCKED
   Otherwise → ALLOW (Rule 144(b)(1)(ii) non-affiliate path is clear)
```

Gates 2 (🟥) and 3 (🟦) are conceptually distinct — the Reg S strict gate vs. the Rule 144 restricted-securities gate — but under Approach B (partition-level Rule 144 clock) plus non-reporting issuer Cat 3 equity, they measure the same underlying value (`partition.issuanceTimestamp + 12 months`) and clear simultaneously. Keeping them as separate checks preserves the audit trail's mapping back to source regulations and forward-compatibility with hypothetical deployments where the two clocks could differ. Under the standard non-reporting Cat 3 deployment documented in this guide (and the reserved reporting-issuer 6-month branch), they always align.

---

_Source authority: This document derives every Reg S requirement from [reg-s-checklist.md](../US%20Compliance/reg-s-checklist.md), every Rule 144 requirement from [rule-144-checklist.md](../US%20Compliance/rule-144-checklist.md), and every OFAC requirement from [ofac-checklist.md](../US%20Compliance/ofac-checklist.md). If any of these source documents is updated, this guide must be re-reviewed._
