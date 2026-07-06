---
type: concept
title: "OFAC Sanctions Compliance"
created: 2026-06-04
updated: 2026-06-04
tags:
  - OFAC
  - sanctions
  - Treasury
  - SDN
  - compliance
  - US-law
  - strict-liability
status: current
related:
  - "[[Regulation-S]]"
  - "[[Rule-144]]"
  - "[[US-Fintech-Compliance-Landscape]]"
  - "[[Real-Estate-RWA-Reg-D-Reg-S-Implementation]]"
  - "[[Tornado-Cash-Van-Loon]]"
  - "[[Asset-Tokenization-RWA]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/US Compliance/ofac-checklist.md"
    hash: "67cd6e0afe8d6a5c2b8b58e010e729c2"
    version: "1.0"
    registered: 2026-06-04
    derived_from: this wiki concept + 31 CFR Chapter V + OFAC SDN List + Executive Orders + OFAC October 2021 Virtual Currency Sanctions Compliance Guidance
    purpose: "Source-derived InnBlockchain client-facing OFAC sanctions compliance checklist. 12 sections + scorecard, scoped to 31 CFR Chapter V and OFAC administrative publications. Covers U.S. person scope, sanctions program landscape, the four screening dimensions (SDN identity, SDN wallet address, comprehensive country sanctions, 50 Percent Rule), screening cadence, blocking obligations, reporting forms (TD F 90-22.50, Annual Report of Blocked Property), licensing framework, voluntary self-disclosure, virtual currency guidance, enforcement, and common failure modes. Cross-referenced by reg-s-checklist.md §8.4 and rule-144-checklist.md §11.1."
---

# OFAC Sanctions Compliance

OFAC — the **Office of Foreign Assets Control**, an arm of the U.S. Department of the Treasury — administers and enforces U.S. economic and trade sanctions programs. It applies to every "U.S. person" on a **strict liability** basis: there is no good-faith or knowledge defense for civil violations.

OFAC compliance is independent of and **cumulative with** every other U.S. regulatory regime. Satisfying [[Regulation-S]] does not satisfy OFAC. Satisfying [[Rule-144]] does not satisfy OFAC. Satisfying KYC does not satisfy OFAC. Every U.S. person in the transaction chain has independent OFAC obligations, and a single non-compliant transaction is a separate civil penalty event.

## Who Is a U.S. Person (31 CFR § 560.314 and Parallels)

Any one of the following triggers U.S.-person status:
- **U.S. citizen** (born or naturalized), wherever resident
- **Permanent resident alien** (green card holder), wherever resident
- **Entity organized under U.S. law** — corporations, LLCs, partnerships, statutory trusts (this is how a Florida LLC SPV becomes a U.S. person even if its investors are entirely offshore)
- **Person physically located in the U.S.** at the time of the transaction
- **U.S. branches and subsidiaries of foreign entities** (the U.S. branch itself is a U.S. person)
- For Cuba and Iran programs: **foreign branches and subsidiaries of U.S. persons** are also subject

The single most common mistake is to assume that an offshore Reg S offering means the issuer is "out of U.S. jurisdiction." If the issuer is a U.S.-organized entity, every transaction the issuer touches is a U.S.-person transaction for OFAC purposes — regardless of where the counterparty sits.

## The Four Structural Categories of OFAC Programs

| Category | Examples | What it prohibits |
|---|---|---|
| **Comprehensive country embargoes** | Cuba (CACR, 31 CFR Part 515), Iran (ITSR, Part 560), North Korea (NKSR, Part 510), Syria (SySR, Part 542) | Virtually all transactions with the embargoed jurisdiction or its residents/government, regardless of SDN-list status |
| **Region-specific sanctions** | Crimea, Donetsk, Luhansk, Kherson, Zaporizhzhia regions of Ukraine (URSR, Part 589 + E.O. 14065) | All transactions in or with the sanctioned region, regardless of counterparty identity |
| **List-based (SDN) sanctions** | Specially Designated Nationals and Blocked Persons List | Transactions with specifically named individuals and entities (terrorists, narcotics traffickers, WMD proliferators, cyber actors, human rights abusers, regime officials, plus their owned/controlled entities) |
| **Sectoral sanctions** | Sectoral Sanctions Identifications (SSI) List, Iranian Financial Sanctions, Hong Kong sanctions | Targeted prohibitions on specific industries or transaction types (e.g., debt / equity restrictions for major Russian financial / energy / defense entities) |

## The 50 Percent Rule

> An entity **owned 50% or more, directly or indirectly, individually or in the aggregate**, by one or more SDN-listed persons is itself treated as SDN, even if not explicitly listed.

Aggregation across multiple SDN owners matters: three SDN persons each owning 20% (60% combined) makes the entity SDN. Look-through applies through multi-layered ownership.

**Practical implication for the diligence pipeline:** entity investors require beneficial-ownership analysis going at least three layers deep. The 50 Percent Rule does NOT apply to sectoral sanctions (Directives 1–4) — there, Treasury must separately designate the subsidiary.

(OFAC Revised Guidance on Entities Owned by Persons Whose Property and Interests in Property are Blocked, Aug. 13, 2014; OFAC FAQ 401.)

## The OFAC Lists

- **SDN List** — primary, daily-updated. Includes names, aliases, dates / places of birth, ID numbers, addresses, **and (since 2018) wallet addresses for digital currency**
- **SSI List** — Russia / Ukraine sectoral targets (Directives 1–4 under E.O. 13662)
- **FSE List** — Foreign Sanctions Evaders (non-U.S. persons who violated U.S. sanctions)
- **Non-SDN Iranian Sanctions Act (NS-ISA) List** — secondary sanctions targets
- **Non-SDN Palestinian Legislative Council (NS-PLC) List**
- **13599 List** — Iranian-government-related entities under E.O. 13599
- **CAPTA List** — foreign financial institutions subject to correspondent-banking restrictions
- **Consolidated Sanctions List** — aggregate non-SDN view

Major crypto-address designations of note: 2018 first Iranian-linked Bitcoin addresses; **August 2022 Tornado Cash** mixer addresses (extraordinary because the designations were against contract code, not just user wallets — see [[Tornado-Cash-Van-Loon]] for the subsequent Fifth Circuit holding); 2020–2024 wallets linked to ransomware operators (DarkSide, Conti), North Korean cyber actors (Lazarus), Russian / Iranian / North Korean state actors.

## The Four Screening Dimensions

Every counterparty must be screened across all four dimensions:

1. **SDN identity match** — fuzzy matching against the SDN List with cultural-name normalization (transliteration variants, alias handling)
2. **Wallet address match** — direct screening against OFAC's published crypto-address SDN list, plus indirect-exposure scoring for wallets that have transacted with sanctioned addresses
3. **Comprehensive country / region match** — country of residence, country of nationality, country of operations against the embargoed jurisdictions
4. **50 Percent Rule beneficial-ownership analysis** — for entity counterparties, identify all owners ≥ 10% and screen each; aggregate SDN ownership reaching 50% makes the entity itself SDN

## Screening Cadence

| When | What |
|---|---|
| At onboarding | Block onboarding if any dimension flags |
| Daily | Pull SDN deltas (OFAC publishes updates daily, sometimes intra-day for emergency designations) |
| Pre-transaction | Re-confirm screening currency before each material transaction |
| Quarterly minimum | Full re-screen of the entire counterparty population against the current full SDN List (not just deltas) |

OFAC sanctions compliance programs are evaluated against the OFAC May 2019 "Framework for Compliance Commitments" (five components: management commitment, risk assessment, internal controls, testing / audit, training).

## Blocking Obligations

> "Block" = freeze in place. The property remains in the holder's custody but cannot move, pay out, transfer, or be otherwise dealt with absent OFAC authorization.

When screening identifies a match — at onboarding, in continuous monitoring, or pre-transaction — the affected property must be **immediately frozen**. Tokens stay in the wallet; bank balances stay in the account; but no transfer is permitted.

Distinct from blocking, a **rejected transaction** is one declined upfront (you don't take possession). Both trigger reporting obligations.

## Reporting Obligations

| Form | When | Within |
|---|---|---|
| **TD F 90-22.50 — Report of Blocked Transactions** | After any blocking event | 10 business days |
| **Report of Rejected Transactions** | After any rejection due to sanctions | 10 business days |
| **Annual Report of Blocked Property (ARG)** | Annual roll-up of all blocked property held as of June 30 | By September 30 |
| **Records retention** | All sanctions-compliance records | 5 years (31 CFR § 501.601) |

## Licensing

| Type | Mechanism |
|---|---|
| **General License** | Standing OFAC publication authorizing categories of transactions (humanitarian, journalistic, certain agricultural exports, wind-down following designation) — self-executing if conditions are met |
| **Specific License** | Case-by-case authorization in response to written application — typical 60–90 day timeline; required to release blocked property to a wrongly-blocked or formerly-sanctioned counterparty |

GL terms can be revised, expanded, or revoked at any time. Document contemporaneous compliance with the operative GL conditions in every reliance situation.

## Voluntary Self-Disclosure

Voluntary disclosure of a discovered violation, before OFAC contact, typically results in **substantial penalty mitigation** (often 50%+ reduction from the base civil-penalty calculation). Non-disclosure when OFAC later discovers the violation independently is an aggravating factor that substantially increases penalty exposure.

VSD requires a written submission describing the apparent violation, transaction details, root-cause analysis, remediation steps taken, and a cooperation commitment.

## Penalty Exposure

| Type | Maximum |
|---|---|
| Civil (per violation) | Greater of **~$311,562** (2024 inflation-adjusted) or **2× transaction value** — strict liability, no knowledge defense |
| Criminal (willful, per violation) | **$1,000,000** and/or **20 years imprisonment** for individuals; greater of $1M or 2× gain/loss for corporations |
| Non-monetary | Public enforcement action, U.S. correspondent banking terminations, cease-and-desist, industry notice via SEC / FINRA / FinCEN / OCC / Fed |

Recent crypto enforcement comparables: **Binance** $968M+ OFAC/FinCEN settlement (2023); **Bittrex** $24M (2022); **Kraken** $362K (2023); **BitGo** $98K (2020).

(OFAC Economic Sanctions Enforcement Guidelines, 31 CFR Part 501 Appendix A.)

## Virtual Currency-Specific Issues

The October 2021 "Sanctions Compliance Guidance for the Virtual Currency Industry" applied OFAC's general SCP framework specifically to crypto. Key risk vectors:

- **Anonymous wallets** → address screening necessary but not sufficient; identity layer must tie wallets to verified persons
- **Geographic obfuscation** (VPN, IP spoofing) → multi-factor jurisdiction analysis required (IP + payment instrument + declared residence + KYC docs)
- **DeFi and DAO exposure** → even decentralized protocols are subject to OFAC if a U.S. person is operating them or providing services (the Tornado Cash designation made this concrete; see [[Tornado-Cash-Van-Loon]] for the partial Fifth Circuit limit on this for **immutable** contracts)
- **Wrapped tokens and cross-chain bridges** → exposure can transit a sanctioned address or service across chains
- **Mixers and privacy tools** → high-risk even when not directly sanctioned (typical 60-90 day "recent use" lookback)
- **Stablecoins** → issuers have their own freeze / blacklist capability; coordinate with issuer when blocking obligations attach to stablecoin holdings

## Cross-Regulatory Interactions

| Regime | OFAC overlay |
|---|---|
| [[Regulation-S]] | Reg S doesn't exempt from OFAC. A Reg S Cat 3 offering to a sanctioned offshore investor is an OFAC violation independent of any Reg S analysis. See reg-s-checklist.md §8.4 |
| [[Rule-144]] | Rule 144 resales remain subject to OFAC at every transfer. See rule-144-checklist.md §11.1 |
| BSA / FinCEN | Independent obligations; sanctions screening overlaps with AML CDD but is its own discipline. AML SAR filings are separate from OFAC blocked-transaction reports |
| SEC offering regs (Reg D, Reg A, Reg CF) | No exemption from OFAC — selling securities to a sanctioned investor is an OFAC violation even if the offering itself complies with the SEC exemption |
| Export controls (EAR / ITAR) | Often overlap with comprehensive country sanctions; dual-use goods and software may require both OFAC and BIS authorization |
| State money transmitter / NYDFS BitLicense | Independent state-level sanctions-compliance expectations layered on top of federal OFAC |

## Common Failure Modes

1. **Treating SDN screening as one-time** — newly-designated counterparties continue to transact
2. **Missing the crypto-address dimension** — screening identities but not wallet addresses misses Tornado Cash-style protocol-level designations
3. **Comprehensive country oversight** — focusing on SDN matches while ignoring country-of-residence prohibitions for the four comprehensive embargoes
4. **50 Percent Rule not enforced** — accepting entity investors without beneficial-ownership look-through; failing to aggregate SDN ownership across multiple owners
5. **Geographic obfuscation acceptance** — accepting VPN users without payment-instrument cross-check
6. **Stale screening cache** — relying on screening results past the freshness window
7. **Failure to block on detection** — recording a hit but allowing the transaction pending compliance review
8. **Late or missed reports** — TD F 90-22.50 missed within 10 business days; ARG missed by September 30
9. **Foreign subsidiary blind spot** — Cuba / Iran programs reach U.S.-controlled foreign subsidiaries
10. **License conditions not documented** — relying on a General License but failing to document contemporaneous compliance with its terms

## Note on Tornado Cash and the Van Loon Limit

The 2022 Tornado Cash designation was unprecedented in targeting smart-contract addresses rather than user wallets. The Fifth Circuit's November 2024 decision in *Van Loon v. Department of the Treasury* held that **immutable** smart contracts are not "property" under IEEPA — OFAC delisted Tornado Cash addresses in March 2025. The decision does NOT extend to:
- Mutable contracts
- Governance tokens with admin keys
- Front-end interfaces operated by identifiable parties

OFAC retains broad authority over U.S.-person interaction with sanctioned addresses, and the **Storm criminal trial** (developer prosecution) remains the open question on personal liability for protocol authors. See [[Tornado-Cash-Van-Loon]] for the doctrinal posture.

## Practical Takeaway for InnBlockchain Implementations

For any U.S.-domiciled token issuer, OFAC compliance is non-negotiable and operationally substantial:
- **Daily SDN delta pulls** via a specialized screening provider (Chainalysis KYT, TRM Labs, ComplyAdvantage)
- **All four screening dimensions** enforced before subscription and continuously
- **30-day freshness window** on all OFAC screening results — stale screening blocks transfers
- **Immediate freeze + blocked-transaction event emission** on every new SDN match
- **On-chain BLOCKED status** that overrides any other transfer permission
- **10-business-day off-chain TD F 90-22.50 filing workflow** triggered by blocked-transaction events
- **Annual Report of Blocked Property** by September 30 each year for any still-frozen property

This is implemented on-chain as part of the InnBlockchain real-estate RWA platform — see [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] §A.1 for the platform-specific application of these requirements.
