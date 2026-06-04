# Affiliate Trading Capability — Addendum to the Reg S Real Estate RWA Implementation Guide

> ⚠️ **This addendum is NOT part of the base deployment.**
>
> The base deployment ([real_estate_rwa_reg_s.md](real_estate_rwa_reg_s.md)) commits to an **affiliate-free token structure**: no affiliate of the issuer holds tokens, and the platform does not support on-chain Rule 144 affiliate-resale conditions. Affiliates who emerge by operation of law are flagged `BLOCKED` and must liquidate off-platform.
>
> **Use this addendum only if the client decides to expand the platform to support on-chain affiliate trading.** Typical reasons that motivate the expansion:
> - The sponsor wants on-chain liquidity for his own holdings (rare — the LLC promote at the SPV level is usually a better economic instrument)
> - An institutional investor with board representation needs an on-platform resale path
> - The platform is being re-used for a deal where the affiliate-free architecture is not viable (e.g., a deal with a strategic 20% shareholder that requires governance representation)
>
> If the client confirms the expansion, this addendum becomes a binding extension of the base implementation guide. Implement these sections in addition to (not in place of) the base.

**Source authorities:**
- [reg-s-checklist.md](../US%20Compliance/reg-s-checklist.md) — Reg S source content
- [rule-144-checklist.md](../US%20Compliance/rule-144-checklist.md) — **primary source authority for this addendum**; every requirement here derives from Rule 144 (17 CFR § 230.144)
- [real_estate_rwa_reg_s.md](real_estate_rwa_reg_s.md) — the base implementation guide this addendum extends

**Audience:** Same as the base — sponsor, counsel, placement agents, and development team. This addendum is more compliance-dense than the base because Rule 144's affiliate path layers four ongoing conditions onto every affiliate sale.

---

## SOURCING NOTE — WHY THIS IS SEPARATE

The affiliate machinery in this addendum is **NOT from Regulation S itself**. Reg S Rules 901–905 mention "affiliates" only in three narrow places — Rule 903(a) (who is locked into the issuer-side safe harbor), Rule 904(a) (who is excluded from the offshore-resale safe harbor), and Rule 904(b)(2) (officer/director carve-out). Reg S does not define affiliate, set volume caps, impose manner-of-sale rules, require current information, or trigger Form 144.

All of that comes from **Rule 144 (17 CFR § 230.144)**, a separate regulation that Reg S pulls in via **Rule 905**. Rule 905 deems Cat 3 domestic-issuer equity to be "restricted securities" under Rule 144 — and once that label attaches, Rule 144 governs every subsequent U.S. resale. The affiliate conditions below are Rule 144 conditions, not Reg S conditions. They become operationally necessary for the smart contract only because the tokens carry the Rule 905 restricted label indefinitely.

This addendum is kept separate from the base guide so that:
- Future deployments without affiliate trading can use the base unchanged
- A Rule 144 specialist auditing the affiliate machinery has a single document to review
- The line between Reg S (covered in the base) and Rule 144 (covered here) is structurally explicit

---

## A.1 — Affiliate Categories the Identity Registry Must Support

Rule 144(a)(1) defines an affiliate as a person who "directly or indirectly through one or more intermediaries, controls, is controlled by, or is under common control with" the issuer. The test is **control**, not ownership percentage. Control means the power to direct management and policies.

The on-chain identity registry (ERC-3643 / ONCHAINID style) extends the base investor record with an `affiliateStatus` field. The field is a bitmask of the categories below; each is set/cleared by the compliance role via EIP-712 attestation, with an audit-trail event:

- [ ] **`OFFICER_DIRECTOR`** — executive officers, managing members, board members of the SPV. Set at appointment, cleared at resignation
- [ ] **`SPONSOR_GP`** — the founding sponsor / managing member with discretionary authority. Set at deployment if the sponsor is a holder
- [ ] **`TEN_PERCENT_HOLDER`** — wallet (or aggregated identity-group) holding ≥10% of outstanding tokens for a partition. SEC treats this as a presumption of affiliate status; rebuttable via a compliance officer attestation showing no actual control influence
- [ ] **`BOARD_APPOINTEE`** — wallet held by an institutional investor with a board-appointment right (e.g., a fund holding 25% with the right to appoint one of three managers)
- [ ] **`HOUSEHOLD_ATTRIBUTION`** — spouse, dependents, or other household members of an affiliate. SEC household-attribution rule (Rule 144(a)(2)(i)) presumes affiliate status; rebuttable
- [ ] **`GROUP_CONTROL`** — multiple holders acting in concert via voting agreement, shareholder agreement, or other coordination. Aggregate holdings determine affiliate status of the group; status applies to each member
- [ ] **`INDIRECT_CONTROL`** — affiliate status looks through trusts, holding companies, and other intermediaries. The sponsor cannot escape affiliate status by holding through a Cayman trust he controls — the trust wallet is also flagged

**Storage:** `affiliateStatus[wallet]` returns a bitmask of these categories, plus a `lastUpdated` timestamp and the `attestationHash` (the cryptographic fingerprint) of the off-chain compliance determination.

---

## A.2 — Status Transitions

Affiliate status changes over time. The identity registry must support both directions:

- [ ] **Becoming an affiliate** — board appointment, ownership crossing 10%, household formation (marriage), entering a voting agreement. Triggered by an EIP-712 attestation from the compliance officer with an effective-date timestamp. Once flagged, the next transfer attempt routes through the affiliate gate in `canTransfer`
- [ ] **Ceasing to be an affiliate** — resignation, ownership dropping below 10% (and below related-party thresholds), divorce, voting agreement termination. **Rule 144(b)(1) imposes a 3-month tail:** a former affiliate cannot use the clean non-affiliate resale path until both (a) they have not been an affiliate for ≥ 3 months AND (b) their original holding period is met
- [ ] Storage on-chain: `affiliateExitTimestamp` per holder — once set, `canTransfer` for U.S.-person sales uses non-affiliate logic only after `block.timestamp >= affiliateExitTimestamp + 90 days`
- [ ] Re-entering affiliate status before the 3-month tail clears resets the tail to zero

---

## A.3 — Affiliate `canTransfer` Gate Logic

For any U.S.-person-recipient transfer where the sender is currently an affiliate (or within the 3-month tail), all four sub-gates below must pass. This is layered on top of the base `canTransfer` checks (Reg S compliance period, OFAC, KYC, etc.) from Section B of the base guide.

```
canTransfer(sender, recipient=US_person, amount, partition):
  Gate 1: distributionComplianceEnd[partition] passed?     [Reg S clock — base guide §C]
  Gate 2: holder[sender].acquisitionTimestamp + 12mo ≤ now? [Rule 144(d) holding period — base guide §D]
  Gate 3: Sender is affiliate (or within 90-day tail)?
    If YES → enforce sub-gates 3a–3d:
      3a (volume — Rule 144(e)):
         rollingSales[sender, 90 days] + amount ≤ max(
            1% × totalOutstanding(partition),
            avgWeeklyVolume(partition, prior 4 weeks) × 13
         )
         // 13 weeks ≈ 90 days; Rule 144 measures over any 3-month window
         revert if violated → AFFILIATE_VOLUME_CAP_EXCEEDED
      3b (manner of sale — Rule 144(f)):
         recipient address is a registered broker contract OR
         transfer is routed through approved-broker intermediary
         revert if violated → AFFILIATE_MANNER_OF_SALE_VIOLATION
      3c (current public information — Rule 144(c)):
         currentInfoAttestation.lastUpdated + freshnessWindow ≥ now
         // for non-reporting issuer: requires Rule 15c2-11 information statement on file
         revert if violated → AFFILIATE_CURRENT_INFO_STALE
      3d (Form 144 — Rule 144(h)):
         if amount + rollingSales[sender, 90 days] > $50,000 OR > 5,000 tokens:
            Form 144 attestation hash present and matches this transfer?
            revert if violated → FORM_144_FILING_REQUIRED
    If NO → ALLOW (clean non-affiliate Rule 144 path)
```

---

## A.4 — Volume Cap Implementation (Rule 144(e))

Rule 144(e)(1) caps quarterly affiliate sales at the **greatest of** (i) 1% of outstanding, (ii) average weekly trading volume on national exchanges × 13 (to scale to a 90-day window), (iii) average weekly volume reported pursuant to an effective transaction reporting plan.

For an illiquid Reg S token with no national-exchange trading, prongs (ii) and (iii) yield approximately zero, so the **1%-of-outstanding cap is the binding constraint**.

- [ ] Storage on-chain: `affiliateRollingSales[holder][partition]` — array of `(timestamp, amount)` tuples for the prior 90 days. Older entries are pruned on each access
- [ ] On each affiliate sale, append to the array and verify the rolling sum + new amount remains within the cap
- [ ] The cap is **the greater of**:
  - 1% of `totalOutstanding(partition)` snapshotted at the time of sale
  - Average weekly trading volume over the prior 4 weeks × 13 (a heuristic that scales from a 4-week-average to a 90-day window)
- [ ] Average weekly trading volume comes from on-chain DEX trades plus reported off-chain trades. Off-chain trade reporting requires attested submission by a registered transfer agent, via an oracle
- [ ] **Group aggregation:** if the sender is part of a `GROUP_CONTROL` group, the rolling sum is across all group members, not just the selling wallet — prevents splitting sales across coordinated wallets to evade the cap (Rule 144(a)(2) / Section 13(d) concert-action principle)

---

## A.5 — Current Public Information (Rule 144(c)) — The Practical Killswitch

This is usually the binding constraint for a non-reporting domestic issuer. Without satisfying Rule 144(c), affiliates cannot use Rule 144 at all — regardless of holding period or volume.

- [ ] For a **non-reporting issuer**, Rule 144(c)(2) requires that information equivalent to Rule 15c2-11 be **publicly available**. This means:
  - Current financial statements (annual + interim)
  - Description of business operations
  - Officers, directors, control persons
  - Outstanding securities and capital structure
  - Material events disclosure
- [ ] **On-chain attestation:** the issuer (multi-sig) maintains a `currentInformationAttestation` with:
  - URI / IPFS hash fingerprint of the information statement
  - Last refresh timestamp
  - Expiry date (typically 12 months from issue date, or sooner if a material event triggers an update)
- [ ] `canTransfer` rejects affiliate sales if `currentInformationAttestation.expiryTimestamp < block.timestamp`
- [ ] **Strategic implication for the client:** if the issuer does NOT commit to maintaining a current Rule 15c2-11 information statement, the affiliate sub-gate 3c can never pass — meaning even with the full affiliate machinery deployed, affiliates have **zero** U.S. resale path through Rule 144. Maintaining current information is itself a non-trivial operational commitment (ongoing audited financials, material-events monitoring, public publication). Confirm the issuer's commitment before deploying the affiliate machinery
- [ ] Information attestation refresh is itself a smart-contract operation: emit `CurrentInformationRefreshed(uri, hash, expiryTimestamp)` for the audit trail

---

## A.6 — Form 144 Filing Hook (Rule 144(h))

- [ ] Form 144 filing required if the affiliate proposes to sell more than **5,000 tokens** OR more than **$50,000** in any 3-month period
- [ ] Filing is off-chain (SEC EDGAR submission), but the contract gates the sale:
  - Affiliate must obtain a `form144Attestation` — an EIP-712 signature from the issuer's filing agent confirming Form 144 has been filed for this specific sale
  - The attestation references: holder address, partition, amount, sale window, filing date, EDGAR accession number
  - `canTransfer` verifies the attestation matches the current sale parameters and is fresh (within the 3-month filing validity window)
- [ ] Emit `Form144FilingReferenced(holder, partition, amount, edgarAccession)` on every validated affiliate sale that crosses the threshold

---

## A.7 — Off-Chain → On-Chain Attestation Map (Affiliate-Specific)

This extends the base guide's Section L attestation map with affiliate-specific facts:

| Affiliate-related fact | Off-chain action | On-chain mechanism | Freshness |
|---|---|---|---|
| Affiliate category assignment | Compliance officer reviews appointment / ownership / household | EIP-712 attestation → identity registry write | Until status change |
| 10%-holder presumption rebuttal | Compliance officer + counsel opinion that holder has no control | EIP-712 attestation overriding presumption | Annual review |
| Average weekly trading volume | Off-chain trading data aggregation + on-chain DEX data | Oracle contract or signed aggregator update | 24 hours |
| Total outstanding (for 1% cap) | On-chain `totalSupply(partition)` snapshot | Direct on-chain read | Real time |
| Current public information (Rule 144(c)) | Issuer publishes Rule 15c2-11 information statement | Multi-sig writes `currentInformationAttestation` | 12 months or until material event |
| Form 144 filing | Filing agent submits to EDGAR | EIP-712 signature referencing EDGAR accession | 3 months |
| Affiliate exit (resignation, etc.) | Compliance officer records event | EIP-712 attestation → `affiliateExitTimestamp` set | Permanent record |

Same trust-boundary discipline from base guide §L.6 applies: every signer is a potential compromise vector; keys live in multi-sig with time-lock; per-attestation scope is limited.

---

## A.8 — Sponsor Structuring Recommendation (Surface to Client Before Implementation)

The sponsor — by virtue of managing the SPV — is permanently the most restricted holder of his own SPV's tokens if he holds tokens at all. The Rule 144(c) current-information requirement alone is likely to block him from U.S. resales; and even if he satisfies it, the 1% / weekly-volume cap means he can only liquidate a tiny fraction per quarter.

The standard structural alternative — strongly recommended over implementing this addendum's affiliate machinery for the sponsor specifically — is:

- [ ] **Do not have the sponsor hold tokens at all.** Take his economic interest as a **carried interest / promote** at the LLC operating-agreement level — a separate class of LLC units (e.g., "Class B Promote Units") that pays him through the SPV's distribution waterfall
- [ ] Class B Promote Units are **not offered to the public**, so Reg S / Section 5 doesn't reach them. They are a founder's interest in his own LLC, governed by Florida LLC law (Fla. Stat. Ch. 605), not securities law (assuming no general solicitation and a single-holder structure)
- [ ] The token contract issues only Class A (investor tokens) to investors; the sponsor's economics flow through the SPV's off-chain distribution waterfall to his Class B Units, which he redeems for cash on sale or refinance
- [ ] **This addendum is therefore appropriate primarily for institutional-affiliate scenarios** — e.g., a strategic 25% holder with board representation — not for sponsor liquidity. Sponsor liquidity should always go through the LLC promote, not through the token

---

## A.9 — Storage Summary for Affiliate Regime

The identity registry / compliance registry needs the following storage additions on top of the base:

```
struct AffiliateStatus {
    uint256 categoryBitmask;        // OFFICER_DIRECTOR | SPONSOR_GP | ... etc
    uint256 effectiveFrom;          // when affiliate status started
    uint256 affiliateExitTimestamp; // 0 if still affiliate; else exit time
    bytes32 attestationHash;        // off-chain determination evidence
    uint256 groupId;                // 0 if not part of GROUP_CONTROL; else group identifier
}

struct AffiliateSale {
    uint256 timestamp;
    bytes32 partition;
    uint256 amount;
}

mapping(address => AffiliateStatus) affiliateStatus;
mapping(address => mapping(bytes32 => AffiliateSale[])) rollingSales;
mapping(uint256 => address[]) groupMembers;     // for GROUP_CONTROL aggregation

CurrentInfoAttestation public currentInfoAttestation; // for Rule 144(c)
```

---

## CHANGES TO THE BASE GUIDE WHEN THIS ADDENDUM IS ADOPTED

If the client adopts this addendum, the base guide ([real_estate_rwa_reg_s.md](real_estate_rwa_reg_s.md)) needs the following modifications:

1. **Architectural Decision section** — remove or relax the affiliate-free commitment. Specifically:
   - Section 4 (Affiliate-creating events trigger a wallet block) — replace "BLOCKED" with affiliate-status flagging
   - Per-investor 9.99% concentration cap — relax or remove if the deal includes institutional affiliates above 10%
   - Disclosure language in the offering memorandum — update to describe the on-platform affiliate-resale capability
2. **Section B (canTransfer)** — add the `Gate 3` affiliate sub-gates from A.3 above
3. **Section D (Rule 905 restricted status)** — restore the affiliate-flag bullet and the holding-period source logic for issuer/affiliate vs market-resale tacking
4. **Section L (Off-chain → On-chain pattern)** — extend with A.7's affiliate-specific attestation map
5. **Subscription Agreement (base guide §E Document 4)** — update to acknowledge affiliate resale path and its conditions

Maintain version control: track which guide (base only vs base + addendum) is the binding spec for the current deployment.

---

*Source authority: This document derives every Rule 144 requirement from [rule-144-checklist.md](../US%20Compliance/rule-144-checklist.md). Reg S linkage via Rule 905 is documented in [reg-s-checklist.md](../US%20Compliance/reg-s-checklist.md) §5. If either source document is updated, this addendum must be re-reviewed.*
