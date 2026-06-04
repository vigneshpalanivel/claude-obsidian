---
type: concept
title: "Real Estate RWA Tokenization — Reg S Implementation (Affiliate-Free)"
created: 2026-06-04
updated: 2026-06-04
tags:
  - real-estate
  - RWA
  - tokenization
  - Regulation-S
  - Rule-144
  - OFAC
  - ERC-1400
  - implementation
  - smart-contract
status: current
related:
  - "[[Regulation-S]]"
  - "[[Rule-144]]"
  - "[[OFAC-Sanctions]]"
  - "[[Real-Estate-RWA-Reg-S-Affiliate-Addendum]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[US-Fintech-Compliance-Landscape]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/Dev/real_estate_rwa_reg_s.md"
    hash: "8ac97d5d423f016520014cbbe2b04972"
    registered: 2026-06-04
    derived_from: this wiki concept + reg-s-checklist.md v1.6 + rule-144-checklist.md v1.0 + ofac-checklist.md v1.0
    purpose: "Full implementation guide for a U.S.-domiciled real-estate sponsor doing a Reg S Cat 3 offshore-only STO under an affiliate-free architecture. Covers identity registry, transfer validation, distribution compliance period mechanics, Rule 905 permanent restricted-securities tracking, ERC-1643 documents, ERC-1644 controller operations, hedging detection, off-chain compliance monitoring events, subscription flow, architecture, EIP-712 / Merkle / Oracle attestation mechanisms, and pre-deployment verification. Companion document: real_estate_rwa_reg_s_affiliate_addendum.md (NOT implemented in base deployment; preserved as optional extension)."
---

# Real Estate RWA Tokenization — Reg S Implementation (Affiliate-Free)

A reference architecture for a U.S.-domiciled real-estate sponsor (Florida LLC or Delaware LLC / statutory trust holding U.S.-situs real estate) running a **Regulation S Category 3 offshore-only** STO with no on-platform affiliate-trading capability. The architecture is built on the ERC-1400 security-token standard family and enforces Reg S, [[Rule-144]] (non-affiliate path only), and [[OFAC-Sanctions]] compliance at every on-chain transaction.

## Confirmed Issuer Profile

| Attribute | Value | Source |
|---|---|---|
| Issuer location | U.S. (Florida or Delaware) | Client input |
| Business | Real estate (U.S.-situs assets) | Client input |
| Domestic vs Foreign | **Domestic issuer** | Rule 902(e) — fails Rule 405 FPI exclusion on both prongs |
| Reporting status | **Non-reporting issuer** | Rule 902(i) — no §12(b)/(g) registration, no §15(d) filings |
| Security type | **Equity** (LLC membership interest tokenized) | Token represents pro-rata cash flow and disposition rights |
| Reg S Category | **Cat 3 — domestic-issuer equity** | Rule 903(b)(3)(iii) |
| Distribution compliance period | **12 months** per closing | Rule 903(b)(3)(iii)(A) 1-year branch |
| Restricted-securities status | **Permanent under Rule 905** | Rule 905 + Rule 144(a)(3)(v) |
| Rule 144 holding period for U.S. resale | **12 months** | Rule 144(d) non-reporting threshold |

## Operational Constraints Accepted

Reg S-only is the chosen path. The client has accepted four constraints baked into the platform:

1. **No U.S.-person sales during the 12-month lockup per closing tranche.** Distribution channel must be built offshore (foreign placement agents, non-U.S. introducers, offshore investor lists).
2. **Tokens are permanent restricted securities under Rule 905.** Post-lockup U.S. resale requires the 12-month Rule 144 holding period to clear plus (for affiliates) ongoing Rule 144(b)(2) conditions that this platform does NOT support.
3. **No directed selling efforts into the U.S.** Website, marketing, social channels, PR all geo-fenced. A single U.S.-readable promotion collapses the safe harbor.
4. **The sponsor cannot personally subscribe under Reg S.** As a U.S. person, sponsor economics come through LLC promote at the operating-agreement level, not token subscription.

## The Architectural Decision: Affiliate-Free Token Structure (Locked)

**No affiliate of the issuer holds tokens.** This single design decision removes a substantial layer of compliance machinery from the on-chain logic — [[Rule-144]] volume caps, manner-of-sale routing, current-public-information attestations, Form 144 hooks, and household / group-control attribution.

Five structural commitments maintain the architecture:

1. **Sponsor economics through Class B Promote Units at the LLC operating-agreement level** — not tokens. The smart contract never mints to the sponsor's wallet.
2. **Per-investor 9.99% concentration cap** enforced in `canTransfer` and `mint` — aggregated across all wallets bound to the same investor identity in the identity registry (no split-wallet evasion).
3. **No governance attached to tokens** — all governance sits with the LLC managing member under the operating agreement.
4. **Affiliate-creating events trigger BLOCKED flag** — a holder who becomes an affiliate by operation of law (officer appointment, voting agreement, household attribution, group control) is flagged BLOCKED rather than carrying an "affiliate" classification.
5. **Mandatory offering memorandum disclosure** — prominent language committing token holders not to become affiliates, plus binding covenant in the subscription agreement.

Trade-off: zero affiliate trading capability in exchange for dramatic contract simplification.

If a deal structure cannot maintain the affiliate-free architecture (e.g., requires a strategic institutional holder with board representation), the full Rule 144 affiliate machinery is preserved in [[Real-Estate-RWA-Reg-S-Affiliate-Addendum]] as an optional extension.

## Reg S Safe Harbor Scope — What It Does Not Cover

> [!warning] Reg S is a safe harbor from Section 5 registration only
> Even when the platform enforces every Reg S condition correctly, the issuer and its agents remain subject to:
> - **Anti-fraud provisions** — Section 17(a) Securities Act and Section 10(b) / Rule 10b-5 Exchange Act
> - **Broker-dealer registration** (Section 15) for placement agents
> - **State securities laws (blue sky)** — federal-only safe harbor; states retain authority
> - **Exchange Act reporting** if the issuer is already a reporting company
> - **OFAC sanctions** — strict liability, see [[OFAC-Sanctions]]
> - **Federal and state tax law** — including FIRPTA (IRC § 1445) and §§ 1441/1442 withholding on non-resident distributions
>
> The platform does NOT enforce any of these — they are managed off-chain by counsel and the compliance team.

## Standards Stack

| Standard | Role |
|---|---|
| **ERC-1400** | Security token base standard with built-in compliance hooks |
| **ERC-1410** | Partitioned tokens — one partition per closing tranche so each carries its own 12-month clock independently |
| **ERC-1594** | Transfer validation (`canTransfer`) — the on-chain enforcement point |
| **ERC-1643** | Document registry — publishes the five required legal documents with URI + hash fingerprint |
| **ERC-1644** | Controller operations — issuer's force-transfer / force-burn authority for non-compliant transfers |
| **ERC-3643** / ONCHAINID | On-chain identity registry binding wallets to KYC-verified investor records |
| **ERC-1066** | Ethereum status codes for transfer rejection reasons |
| **EIP-712** | Typed structured-data signatures for compliance attestations |

## On-Chain Components

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

The token contract is minimal. Every Reg S / Rule 144 / OFAC rule lives in the upgradeable ComplianceRegistry behind a multi-sig + time-lock — so as SEC and OFAC guidance evolves, rules can be updated without redeploying the token.

## Transfer Validation Gates

The `canTransfer` hook returns `false` with a specific reason code when:

- Recipient is not in the identity registry → `NO_KYC`
- Recipient is a U.S. person AND distribution compliance period has not expired → `REG_S_US_PERSON_RESTRICTED`
- Sender or recipient is OFAC-flagged (any of 4 dimensions per [[OFAC-Sanctions]]) → `OFAC_BLOCKED`
- OFAC screening result > 30 days old → `OFAC_SCREENING_STALE`
- Sender is BLOCKED (includes affiliate-creating events) → `SENDER_BLOCKED`
- KYC > 12 months old for either party → `KYC_EXPIRED`
- Transfer is "for the account or benefit of a U.S. person" (per EIP-712 compliance officer attestation gate for high-value transfers) → `ACCOUNT_OR_BENEFIT_US_PERSON`
- Recipient is U.S. person post-compliance period and sender's Rule 144 12-month holding period has not cleared → `RULE_144_HOLDING_PERIOD_NOT_MET`
- Transfer would push recipient aggregate balance > 9.99% of partition `totalSupply` → `CONCENTRATION_CAP_EXCEEDED`
- Transfer to a known hedging venue during compliance period → `HEDGING_BLOCKLIST`

The default-block discipline is non-negotiable: if any required attestation is missing, stale, or unverifiable, the transfer is rejected. There is no emergency-allow path.

## Off-Chain → On-Chain Attestation Mechanisms

Most Reg S decisions cannot be computed on-chain (KYC review, residency analysis, OFAC list maintenance happen off-chain), but the contract must enforce them at every transfer. Four mechanisms bring off-chain decisions onto the chain:

| Mechanism | Use for |
|---|---|
| **Identity registry state (push)** | KYC status, OFAC status, U.S.-person flag, residency, accredited status — slow-moving and broadly applicable |
| **EIP-712 signed attestations (pull)** | Per-event, fact-specific decisions — mint authorization (Rule 902(h) Prong B), high-value transfer "not for U.S. benefit" determinations, distributor confirmation acknowledgements |
| **Merkle proof at mint** | Initial subscription whitelist — large, slow-changing eligible-investor list |
| **Oracle contract** | Cross-protocol shared state (KYC provider aggregator, sanctions feed) — used when multiple tokens share the same investor universe |

Trust boundaries are documented per role: KYC provider, sanctions screening provider, compliance officer, sponsor / GP, placement agent, contract upgrader. Each role's keys live in multi-sig + time-lock arrangements with documented rotation procedures.

## Five Required Legal Documents (ERC-1643)

The token publishes these via the document registry, each with name + URI + hash fingerprint:

1. Reg S unregistered-securities legend
2. Hedging-restriction legend (Cat 3 domestic equity)
3. Transfer-restriction legend (Cat 3 domestic equity)
4. Subscription / Purchase Agreement template hash (with purchaser certifications and resale covenants)
5. Property-specific PPM / offering memorandum

Documents are versioned via `setDocument` events. Prior versions are never deleted.

## Subscription / Mint Flow

Initial issuance verifies, before any tokens are minted:
- Signed off-chain subscription agreement hash
- Purchaser classification (Merkle proof or oracle attestation from KYC provider)
- EIP-712 purchaser certification per Rule 903(b)(3)(iii)(B)(1) (not a U.S. person AND not acquiring for U.S. account/benefit)
- Resale-restriction and hedging covenant captured (Rule 903(b)(3)(iii)(B)(2))
- EIP-712 placement-agent mint-authorization attestation (Rule 902(h) Prong B) — 24-hour freshness
- OFAC screening fresh (within 30 days) across all 4 dimensions
- Recipient wallet in identity registry
- Concentration cap (≤ 9.99%) not breached

Emits `PurchaserCertified` event linking the new holding to the subscription agreement, the certification type, and the closing tranche; for real estate, also links the mint to a property record (property NFT or on-chain registry entry).

## Events for Off-Chain Monitoring

Rich event stream for compliance audit and regulator inquiry:
- `TransferAttempted` — every attempt with reason code (lets monitoring detect probing)
- `KYCStatusChanged`, `OFACScreeningCompleted`, `SDNStatusChanged`
- `BlockedTransactionRecorded` — triggers TD F 90-22.50 filing within 10 business days
- `BlockedPropertyHeld` — feeds Annual Report of Blocked Property (Sept 30)
- `DistributorConfirmationRequired` — triggers off-chain Rule 903(b)(3)(iv) notice workflow
- `PartitionComplianceExpired` — public signal that partition is now eligible for Rule 144 secondary trading
- `RestrictedSecuritiesNoted` — tracks U.S.-person sales post-compliance for Rule 144 evidence
- `PurchaserCertified`, `HedgingRestrictionAcknowledged`, `Form144FilingReferenced` (the last only relevant if affiliate addendum is adopted)

## The Single Biggest Design Risk

> [!warning] Two separate states, both must be checked independently
> **Treating Cat 3 domestic equity restrictions as expiring at 12 months.** They don't. Rule 905 makes them restricted securities perpetually. The contract logic needs:
> 1. **Reg S compliance period active** — time-limited (12 months for non-reporting), gates U.S.-person transfers entirely
> 2. **Rule 144 restricted-status** — permanent, gates U.S.-person resales unless registration or exemption is available
>
> Conflating the two will let restricted tokens leak into unrestricted U.S. trading after the 12-month period — creating Section 5 / Section 12(a)(1) rescission liability for the issuer and the offshore reseller. The on-chain `canTransfer` must check both states independently.

## Pre-Deployment Verification

Before mainnet:
- Independent smart contract security audit (compliance logic + standard reentrancy / access control / upgrade safety)
- Reg S condition mapping document — every contract function annotated with the Rule it enforces (auditor and SEC-reviewer friendly)
- Test coverage for every `canTransfer` reason code (pass + fail paths)
- Test coverage for ERC-1410 partition compliance period transitions (before / at / after expiry)
- Test coverage for Rule 144 holding-period math for the affiliate-free non-reporting issuer scenario
- Test coverage for ERC-1644 controller force-transfer with multi-sig governance
- Test coverage for concentration-cap aggregation across multiple wallets bound to the same identity
- Test coverage for EIP-712 signature verification, expiry, and revocation
- Test coverage for Merkle proof verification at mint
- Test coverage for oracle staleness behaviour (block on stale data)
- Legal review of every on-chain legend text against the offering document text (verbatim match required)
- Securities counsel sign-off on the compliance registry rule set before deployment

## Cross-Referenced Source Checklists

The implementation is anchored to three source-derived compliance checklists, each scoped strictly to its own regulatory framework:

- [[Regulation-S]] → `.raw/InnBlockchain/US Compliance/reg-s-checklist.md` (17 CFR §§ 230.901–230.905)
- [[Rule-144]] → `.raw/InnBlockchain/US Compliance/rule-144-checklist.md` (17 CFR § 230.144)
- [[OFAC-Sanctions]] → `.raw/InnBlockchain/US Compliance/ofac-checklist.md` (31 CFR Chapter V + SDN List + Executive Orders)

The implementation guide cross-references each by section so a counsel or auditor can trace every on-chain enforcement back to the source-derived regulatory provision.
