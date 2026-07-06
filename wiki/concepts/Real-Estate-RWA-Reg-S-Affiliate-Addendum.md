---
type: concept
title: "Real Estate RWA Reg S — Affiliate Trading Addendum (Optional Extension)"
created: 2026-06-04
updated: 2026-06-04
tags:
  - real-estate
  - RWA
  - tokenization
  - Regulation-S
  - Rule-144
  - affiliate
  - implementation
  - smart-contract
  - optional-extension
status: optional-extension
related:
  - "[[Real-Estate-RWA-Reg-D-Reg-S-Implementation]]"
  - "[[Rule-144]]"
  - "[[Regulation-S]]"
  - "[[OFAC-Sanctions]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/Dev/real_estate_rwa_reg_s_affiliate_addendum.md"
    hash: "b4a8785ce1eac575f5405e26768d523a"
    registered: 2026-06-04
    derived_from: this wiki concept + rule-144-checklist.md v1.0
    purpose: "Optional extension to the affiliate-free base implementation in real_estate_rwa_reg_d_reg_s.md. Preserves the full Rule 144 affiliate-condition machinery for deployments where the affiliate-free architecture is not viable — e.g., a strategic institutional investor with board representation. NOT implemented in base deployments; adopted only on explicit client decision to support on-platform affiliate trading."
---

# Real Estate RWA Reg S — Affiliate Trading Addendum (Optional Extension)

> [!warning] Optional extension — NOT part of the base implementation
> The base [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] commits to an **affiliate-free token structure**. No affiliate of the issuer holds tokens, and the platform does not support on-chain Rule 144 affiliate-resale conditions. Affiliates who emerge by operation of law are flagged `BLOCKED` and must liquidate off-platform.
>
> **This addendum is adopted only if a deal scenario requires on-chain affiliate trading capability** — typically when an institutional investor with board representation is part of the cap stack, or when a sponsor specifically requires token-level liquidity (unusual — sponsor liquidity should always go through LLC promote at the operating-agreement level).

## When This Addendum Applies

Adoption is appropriate in three scenarios:

1. **Sponsor wants on-chain token-level liquidity** — rare. The LLC promote at the operating-agreement level is the better economic instrument for sponsor economics. If the sponsor insists on holding tokens, this addendum applies.
2. **Institutional investor with board representation** — a strategic 20%+ holder with the right to appoint an SPV manager or vote on operations triggers affiliate status under [[Rule-144]](a)(1). If the deal structure cannot avoid this, the affiliate-resale machinery is needed.
3. **Re-use of the platform for a deal where the affiliate-free architecture is not viable** — e.g., a token issuance structure that grants on-chain voting rights or where the cap-stack design materially differs from the base scenario.

If none of these conditions hold, **do NOT adopt this addendum** — it adds substantial contract complexity and pre-deployment legal review burden for no benefit.

## Sourcing — Why It Lives in a Separate Document

The affiliate machinery is **NOT from Regulation S itself**. Reg S Rules 901–905 mention "affiliates" only in three narrow places — Rule 903(a), Rule 904(a), and Rule 904(b)(2). Reg S does not define affiliate, set volume caps, impose manner-of-sale rules, require current information, or trigger Form 144.

All of that comes from **[[Rule-144]]** (17 CFR § 230.144), pulled into the Reg S workflow via the Rule 905 bridge. Rule 905 deems Cat 3 domestic-issuer equity to be "restricted securities" under Rule 144 indefinitely — and once that label attaches, Rule 144 governs every subsequent U.S. resale.

This addendum is kept structurally separate from the base implementation so that:
- Future deployments without affiliate trading can use the base unchanged
- A Rule 144 specialist auditing the affiliate machinery has a single document to review
- The line between Reg S (covered in the base) and Rule 144 (covered here) is structurally explicit

## Affiliate Categories the Identity Registry Must Support

[[Rule-144]](a)(1) defines an affiliate as a person who "directly or indirectly through one or more intermediaries, **controls, is controlled by, or is under common control with**" the issuer. The test is **control**, not ownership percentage.

When the addendum is adopted, the identity registry adds an `affiliateStatus` field — a bitmask of:

- **OFFICER_DIRECTOR** — executive officers, managing members, board members
- **SPONSOR_GP** — the founding sponsor with discretionary authority
- **TEN_PERCENT_HOLDER** — wallet (or aggregated identity-group) holding ≥ 10% of outstanding tokens for a partition; SEC presumption rebuttable via compliance attestation
- **BOARD_APPOINTEE** — wallet held by an institutional investor with board-appointment rights
- **HOUSEHOLD_ATTRIBUTION** — spouse, dependents, household members of an affiliate (Rule 144(a)(2)(i))
- **GROUP_CONTROL** — multiple holders acting in concert via voting / shareholder agreements
- **INDIRECT_CONTROL** — affiliate status through trusts, holding companies (Carlos cannot escape by holding through a controlled Cayman trust)

## Status Transitions — The 3-Month Tail

Becoming an affiliate is straightforward (board appointment, ownership crossing 10%, marriage, voting agreement). Ceasing to be an affiliate carries a **Rule 144(b)(1) 3-month tail**: a former affiliate cannot use the clean non-affiliate resale path until both (a) they have not been an affiliate for ≥ 3 months AND (b) their original holding period is met.

On-chain: `affiliateExitTimestamp` per holder. `canTransfer` for U.S.-person sales uses non-affiliate logic only after `block.timestamp >= affiliateExitTimestamp + 90 days`. Re-entering affiliate status before the tail clears resets it.

## Affiliate canTransfer Gate Logic

For any U.S.-person-recipient transfer where the sender is an affiliate (or within the 3-month tail), four sub-gates must pass on top of the base [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] gates:

1. **Volume cap (Rule 144(e))** — rolling 90-day window; ≤ greater of (1% of `totalOutstanding(partition)`) OR (average weekly trading volume × 13). For illiquid securities, the 1% cap binds. Group aggregation across `GROUP_CONTROL` members prevents split-sale evasion.
2. **Manner of sale (Rule 144(f))** — recipient is a registered broker contract OR transfer is routed through an approved-broker intermediary.
3. **Current public information (Rule 144(c))** — `currentInformationAttestation.expiryTimestamp ≥ block.timestamp`. For non-reporting issuers, requires a Rule 15c2-11 information statement on file.
4. **Form 144 (Rule 144(h))** — if amount + rolling sales > $50,000 OR > 5,000 tokens, an EIP-712 attestation from the issuer's filing agent confirming Form 144 has been filed (with EDGAR accession number) must accompany the transfer.

## Rule 144(c) Is the Practical Killswitch

> [!warning] The single most important strategic decision
> For a **non-reporting issuer**, Rule 144(c)(2) requires that publicly available information equivalent to Rule 15c2-11 be on file. Without it, sub-gate 3c never passes — affiliates have **zero** U.S. resale path through Rule 144, even with the full affiliate machinery deployed.
>
> Maintaining a current Rule 15c2-11 information statement is itself a non-trivial operational commitment (ongoing audited financials, material-events monitoring, public publication). Confirm the issuer's commitment to this before deploying the affiliate machinery — if the issuer will not commit, the affiliate machinery provides no value.

## Volume Cap Implementation

- Storage: `affiliateRollingSales[holder][partition]` — array of (timestamp, amount) tuples for the prior 90 days; older entries pruned on access
- On each affiliate sale, append + verify rolling sum + new amount remains within the cap
- Cap is **the greater of**:
  - 1% of `totalOutstanding(partition)` snapshotted at sale time
  - Average weekly trading volume × 13 (4-week average scaled to 90-day window)
- Off-chain trading volume comes from on-chain DEX trades + reported off-chain trades; off-chain trades require attested submission by a registered transfer agent via oracle
- **Group aggregation**: if sender is part of a `GROUP_CONTROL` group, rolling sum is across all group members (Rule 144(a)(2) / § 13(d) concert-action principle)

## Sponsor Structuring Recommendation (Strategic)

Even with the affiliate machinery available, **the sponsor should not hold tokens**. Rule 144(c) current-information requirement alone is likely to block sponsor U.S. resales; even if satisfied, the 1% / weekly-volume cap means the sponsor can only liquidate a tiny fraction per quarter.

The standard structural alternative — recommended over implementing this addendum for sponsor liquidity specifically:

- **Do not have the sponsor hold tokens at all.** Take economic interest as **carried interest / promote** at the LLC operating-agreement level — a separate class of LLC units that pays through the SPV's distribution waterfall.
- Class B Promote Units are **not offered to the public**, so Reg S / Section 5 doesn't reach them. Founder's interest governed by state LLC law (Florida Ch. 605 or Delaware), not securities law.
- This addendum is therefore **appropriate primarily for institutional-affiliate scenarios** — e.g., a strategic 25% holder with board representation — not for sponsor liquidity.

## Storage Summary (Solidity-Adjacent)

The identity registry / compliance registry needs these storage additions on top of the base:

```
struct AffiliateStatus {
    uint256 categoryBitmask;        // OFFICER_DIRECTOR | SPONSOR_GP | ... etc
    uint256 effectiveFrom;          // when affiliate status started
    uint256 affiliateExitTimestamp; // 0 if still affiliate; else exit time
    bytes32 attestationHash;        // off-chain determination evidence
    uint256 groupId;                // 0 if not part of GROUP_CONTROL
}

struct AffiliateSale {
    uint256 timestamp;
    bytes32 partition;
    uint256 amount;
}

mapping(address => AffiliateStatus) affiliateStatus;
mapping(address => mapping(bytes32 => AffiliateSale[])) rollingSales;
mapping(uint256 => address[]) groupMembers;
CurrentInfoAttestation public currentInfoAttestation;
```

## Changes to the Base Guide If This Addendum Is Adopted

1. **Architectural Decision section** — relax or remove the affiliate-free commitment:
   - The "BLOCKED" treatment of affiliate-creating events is replaced by affiliate-status flagging
   - The 9.99% per-investor concentration cap may need relaxation if the deal includes institutional affiliates above 10%
   - Offering memorandum disclosure language updated to describe the on-platform affiliate-resale capability
2. **Section B (canTransfer)** — add the 4-sub-gate affiliate logic
3. **Section D (Rule 905 restricted status)** — restore the affiliate-flag bullet and the holding-period source logic for issuer/affiliate-vs-market-resale tacking
4. **Section L (Off-chain → On-chain pattern)** — extend with the affiliate-specific attestation map (affiliate category assignment, 10%-holder rebuttal, current information attestation, Form 144 filing, affiliate exit)
5. **Subscription Agreement (base §E Document 4)** — update to acknowledge affiliate resale path and its conditions

Maintain version control: track whether the deployment is base-only or base + addendum, and price accordingly.

## Cross-References

- [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] — the base implementation this addendum extends
- [[Rule-144]] — the source-of-authority concept for the affiliate-seller conditions implemented here
- [[Regulation-S]] — the parent regulatory framework; Rule 905 is the bridge that makes Rule 144 apply to Reg S Cat 3 domestic-issuer equity
- [[OFAC-Sanctions]] — applies cumulatively to every affiliate transfer
