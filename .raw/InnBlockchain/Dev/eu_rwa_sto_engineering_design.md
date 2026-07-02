# EU RWA / STO Tokenized Securities — Platform Engineering Design

**What this is:** the CTO-facing **engineering design** for the EU RWA/STO tokenized-securities platform — how we actually build it. It consumes [eu_rwa_sto_smart_contract_design.md](../sales-marketing/Service/Content/Contract%20Design/eu_rwa_sto_smart_contract_design.md) (the *compliance-requirements baseline*: what must be enforced, on-chain vs off-chain, article-mapped) and turns those requirements into architecture, technology decisions, a data model, non-functional targets, a test/audit strategy, and a build roadmap.

**Read order:** requirements doc first (*what must be true*), this doc second (*how we build it*). Every on-chain enforcement item in this doc traces back to an Article in the requirements doc.

**Scope note:** ~80% of the engineering effort is **off-chain** (identity/claims, valuation oracle, matching engine, reporting bridges, screening, indexing, ops). The requirements doc details the on-chain 20%; this doc gives the off-chain systems equal weight because that is where the build cost lives.

**Status:** design baseline for review. Open decisions requiring the CTO's sign-off are consolidated in §11.

---

## 1. The decisions this document makes

| # | Decision | §  | One-line rationale |
|---|---|---|---|
| D1 | **Chain: permissioned / known-validator EVM** (consortium or controlled-sequencer appchain) | §2 | MAR validator-front-running surveillance + DLT Pilot settlement finality + DORA validator control are unsatisfiable on an anonymous public L1 |
| D2 | **ERC-3643 (T-REX) + ONCHAINID** as token/identity base | (req §2.1) | Identity + modular compliance + freeze/recovery as standard primitives |
| D3 | **Off-chain-first architecture** — contracts are the enforcement/settlement layer; identity, valuation, matching, reporting are backend services | §3 | The load-bearing systems are off-chain; design them as first-class |
| D4 | **Role-lane phasing** — issuer core → fund modules → venue → dealer/SI | §9 | Compliance stack compounds ~3× per lane; ship the issuer lane first |
| D5 | **DORA resilience wrapper from day 1**, not retrofitted | §6, §7 | Upgrade/pause/logging/key-mgmt are cross-cutting and cheap early, expensive late |

---

## 2. Chain selection — the foundational decision (D1)

Chain choice is upstream of everything else; the requirements constrain it hard.

**Constraints from the requirements doc:**
- **MAR Art 16 / 12(2):** the venue must surveil **validator/sequencer front-running and transaction-ordering manipulation**. You cannot surveil — let alone control — ordering by anonymous public-L1 validators. → known/permissioned validators or a controlled sequencer.
- **DLT Pilot Art 5(7) + CSDR Art 39:** deterministic **settlement finality** at a defined moment, no probabilistic reversal. → instant-finality consensus (BFT/PoA), not Nakamoto probabilistic finality.
- **DORA Art 12:** validator-set redundancy + quorum you can operate and fail over. → you must run/govern the validator set.
- **DLT Pilot authorisation:** an identifiable operator accountable to the NCA. → not a permissionless network with no operator.
- **GDPR:** no PII on-chain regardless of chain (handled by design in every option).
- **NFR (venue):** predictable low-latency finality and stable, low per-tx cost (§7) — public-L1 gas volatility and MEV are actively hostile to a regulated order book.

**Options considered:**

| Option | Finality | Validator control | MEV/ordering | Verdict |
|---|---|---|---|---|
| Public L1 (Ethereum mainnet) | Probabilistic | None (anonymous) | Uncontrollable | **Rejected** — fails MAR ordering surveillance, DORA validator control, finality determinism, cost stability |
| Public L2 / rollup | L2 fast, L1-anchored | Sequencer often centralized-but-external | Sequencer-dependent | **Weak** — you don't control the sequencer; DLT-Pilot finality + DORA failover become third-party-dependent |
| **Permissioned EVM consortium** (e.g. QBFT/IBFT PoA — Besu-class) | **Instant, deterministic (BFT)** | **Full** — known, contractual validators | **Controllable** — you set ordering policy | **Recommended** for the venue/settlement lane |
| **Controlled-sequencer appchain** (EVM) | Fast + settlement to a base layer | Full over sequencer | Controllable | **Viable alternative** if you want an L1 anchor; adds base-layer dependency |

**Decision (D1): a permissioned, known-validator EVM network** (BFT instant-finality) for the venue/settlement lane. ERC-3643 is EVM-native and portable, so the token/identity core runs unchanged. Keep the network **EVM-standard** so ERC-3643/ONCHAINID, tooling, and auditors are off-the-shelf; keep validator identities and governance under operator + (where DLT Pilot requires) NCA visibility.

**Open sub-decision (→ §11):** consortium-of-participants vs single-operator PoA vs appchain-with-L1-anchor. Drives governance, DORA failover topology, and whether central-bank-money settlement bridges are reachable.

---

## 3. System architecture — the full picture

```
┌── ON-CHAIN (permissioned EVM) ──────────────┐   ┌── OFF-CHAIN SERVICES (the ~80%) ─────────────┐
│                                             │   │                                              │
│  Token (ERC-3643)                           │◄──┤  Identity & Claims service                   │
│   └ canTransfer() ─► Compliance Engine      │   │   (ONCHAINID mgmt, EUDI/QTSP claim intake,   │
│        ├ Identity/eligibility module        │   │    KYC/CDD, LEI/NCI binding)                 │
│        ├ Fund-structure modules (ELTIF…)    │◄──┤  Valuation / NAV oracle service              │
│        ├ Market-integrity (MAR freeze)      │   │   (multi-source, deviation guard, fallback)  │
│        └ Venue/settlement (DLT MTF, DvP)    │◄──┤  Sanctions / PEP / BO screening              │
│  Document Registry (hash+URI)               │◄──┤  ELTIF matching engine (price disc + pro-rata)│
│  DORA wrapper (proxy+timelock+pause+events) │──►┤  Event indexer (surveillance, audit, state)  │
│                                             │──►┤  Reporting bridges: ARM (Art26 T+1),         │
│                                             │   │    APA (transparency), CTP (consol. tape)    │
└─────────────────────────────────────────────┘   │  Admin / governance console (multisig UX)    │
        ▲                                          │  Key-management (HSM / MPC)                   │
        │ external integrations                    └──────────────────────────────────────────────┘
        └─► NCA reporting · EUDI Wallet / QTSP · settlement bank (CeBM/e-money) · qualified custodian
```

**Off-chain services — each is a build workstream, not a footnote:**

| Service | Owns | Talks to chain via | Requirements ref |
|---|---|---|---|
| **Identity & Claims** | ONCHAINID lifecycle, EUDI/QTSP claim intake, KYC/CDD, LEI/NCI, claim revocation | writes claims to Identity Registry; trusted-issuer signer | req §3 |
| **Valuation / NAV oracle** | Price/NAV feed for every quantitative limit; deviation + staleness guard; last-valid fallback | signed push to on-chain oracle adapter | req §4, §10 (the #1 risk) |
| **Sanctions/PEP/BO screening** | Onboarding + list-update re-screening; hit → freeze signal | pushes freeze flags to compliance module | req §3 |
| **ELTIF matching engine** | Off-chain order matching, price discovery, pro-ration; emits matched pairs | submits atomic settlement tx | req §4.4 |
| **Event indexer** | Ingests all contract events for MAR surveillance (wash/MEV/spoofing), audit trail, state reconstruction | read-only event stream | req §5, §8 |
| **Reporting bridges** | ARM (Art 26 T+1), APA (pre/post-trade transparency), CTP (consolidated tape, Jun 2026) | consume `Trade`/`Quote` events, transform, deliver | req §6.2 |
| **Admin/governance console** | Multisig proposal/approval UX, pause control, module config, key rotation | multisig + timelock txns | req §8 |
| **Key management** | HSM/MPC custody of agent/issuance/settlement keys; rotation; break-glass | signer infrastructure | req §8 |

---

## 4. Contract inventory & data model

**Contracts (permissioned EVM, ERC-3643 base):**

| Contract | Responsibility | Requirements module |
|---|---|---|
| `SecurityToken` (ERC-3643) | Transfer w/ `canTransfer()` gate; freeze; forced transfer; recovery | req §2, §3 |
| `IdentityRegistry` + `IdentityRegistryStorage` | Wallet → ONCHAINID; investor tier; jurisdiction; claim presence | req §3 |
| `TrustedIssuersRegistry` / `ClaimTopicsRegistry` | eIDAS/QTSP/KYC claim issuers; required claim topics | req §3 |
| `ModularCompliance` + rule modules | One module per rule, each Article-mapped: `EltifConcentration`, `UcitsFiveTenForty`, `NavBorrowingCap`, `LmtGate`, `HoldingPeriodLock`, `PdmrClosedPeriodFreeze`, `LoanRetention` | req §4, §5 |
| `DocumentRegistry` (ERC-1643 pattern) | Prospectus/MAR disclosure hash + URI, ≥10y | req §7 |
| `SettlementEngine` (venue lane) | Atomic DvP; settlement-finality state; segregation; no-overdraft | req §6.1 |
| `DltPilotCapGate` (venue lane) | Per-instrument + aggregate issuance caps (€500m/€1bn/€6bn; €9bn transition) | req §6.1 |
| `SiQuoteEngine` (dealer lane) | Firm quotes (MiFIR 14–20); PFOF-clean routing audit | req §6.2 |
| `DoraGovernor` (wrapper) | Proxy-admin + timelock + pause + structured event log + key-rotation registry | req §8 |

**Key on-chain state schemas to specify before build:**
- **RTS-22 trade event** — the `Trade` event must be field-complete for MiFIR Art 26 (LEI/NCI, ISIN, price, qty, venue MIC, capacity, short-sell flag, timestamp, waiver/deferral flags). Specify the full field list as the canonical schema; the ARM bridge maps from it. Get this right on day 1 — retrofitting event schemas is painful.
- **Identity claim set** — the minimal claim topics (investor tier, jurisdiction, sanctions-clear, PEP-status, CDD-valid-until) — **hashes/claim refs only, never PII** (GDPR, req §9).
- **Portfolio/position registry** — per-asset NAV-weighted holdings feeding the concentration modules.

---

## 5. Off-chain ↔ on-chain integration patterns

- **Oracles (valuation, sanctions):** signed pushes from an allow-listed oracle signer to an on-chain adapter; adapter enforces **staleness window + max deviation**; on breach → halt issuance/redemption (not silent pass), emit alert. Dual-source with fallback to last-verified value (req §10, §11 risk).
- **Claims:** Identity service (trusted issuer) writes/revokes claims on ONCHAINID; revocation propagates to `canTransfer` immediately (QEAA revocation finality).
- **Reporting extraction:** indexer consumes events → transforms to ARM/APA/CTP formats → delivers off-chain (Art 26 at T+1; transparency near-real-time; CTP real-time from Jun 2026). The chain is the source of truth; bridges are delivery.
- **Matching:** engine watches redemption/exit requests, matches off-chain, submits an atomic settlement tx; on-chain records the matched transfer + price for audit.

---

## 6. Upgradeability & key management

- **Upgrade pattern:** UUPS/transparent proxy (ERC-1967) behind `DoraGovernor` — **M-of-N multisig + ≥48h timelock** on any implementation change; every upgrade emits `(old, new, executor, ts)`. Alternative for immutable-critical contracts: deploy-new + migration-flag. (req §8, DORA Art 9)
- **Key management:** agent/issuance/settlement keys in **HSM or MPC (threshold sig)** — no single-key authority over freeze/mint/settlement-finality. On-chain key-rotation registry + audit trail; separate **break-glass** recovery key in isolated custody, usable only in documented recovery mode. (req §8)
- **Circuit-breaker:** role-gated `pause()`; auto-trip on oracle-anomaly signal; redemption-only fallback mode; unpause requires full multisig. (DORA Arts 11–12)

---

## 7. Non-functional requirements

| Dimension | Target / constraint | Driver |
|---|---|---|
| **Finality** | Deterministic, sub-block (BFT); no reversal after finality state | DLT Pilot Art 5(7), CSDR Art 39 |
| **Settlement latency** | "As quickly as technologically practicable" — atomic DvP at block finality | MiFIR Art 29(2) |
| **Clock accuracy** | Block/UTC timestamp to ESMA RTS granularity | MiFIR Art 22c |
| **Throughput** | Sized to venue peak order/trade rate (define with venue lane; permissioned BFT gives head-room public L1 can't) | venue NFR |
| **Cost** | Stable, low per-tx (permissioned = no gas auction) | venue economics |
| **Availability / RTO-RPO** | DORA-grade; validator + service redundancy; documented failover | DORA Art 12 |
| **Data retention** | Prospectus/disclosure ≥10y; comms 5–7y (off-chain) | Prospectus Art 21, MiFID II Art 16(7) |

---

## 8. Security, testing & audit strategy

Regulated-securities contracts — the enforcement modules are the crown jewels.

- **Unit + integration** across all `canTransfer` paths and every compliance module.
- **Property-based / fuzz testing** on the quantitative modules (concentration, 5/10/40, NAV caps) — these are where a silent arithmetic error passes a limit breach.
- **Formal verification** of the highest-stakes invariants: "a transfer that would breach a hard limit always reverts," "frozen wallets cannot transfer," "DvP legs are atomic (no half-settlement)."
- **External audit** (≥1, ideally 2 independent) of the full contract set; the audit report is a **Prospectus Art 4.2 disclosure item** and an NCA review input — plan the timeline around it.
- **The Article→function map** (from the requirements doc) is the audit's acceptance checklist: every on-chain enforcement item traces to an Article, and the audit confirms the code matches.
- **Testnet + supervised pilot** on the permissioned network before any real issuance; **bug bounty** post-audit.
- **Oracle/matching-engine** get their own security review — they are off-chain but load-bearing (a bad NAV silently passes every limit).

---

## 9. Build phasing / roadmap (D4)

Sequenced to the compliance role-lanes; DORA wrapper is cross-cutting from Phase 0.

| Phase | Deliverable | Contracts / services | Unblocks |
|---|---|---|---|
| **0 — Foundation** | Chain stood up; token + identity core; DORA wrapper | `SecurityToken`, `IdentityRegistry`, `TrustedIssuers/ClaimTopics`, `DoraGovernor`; Identity & Claims service; key-mgmt | Any compliant issuance (issuer-only lane MVP) |
| **1 — Fund + disclosure** | Pooled-fund enforcement + document registry | `ModularCompliance` + ELTIF/UCITS/NAV/LMT/holding modules; `DocumentRegistry`; Valuation oracle; Sanctions/PEP/BO screening | AIFMD/UCITS/ELTIF funds; prospectus/MAR disclosure |
| **2 — Venue** | DLT MTF/SS/TSS: trading + settlement + reporting | `SettlementEngine`, `DltPilotCapGate`; matching engine; indexer; ARM + APA bridges | Investor-to-investor secondary trading |
| **3 — Dealer/SI + MiFID III** | SI quoting; consolidated tape; PFOF-clean routing | `SiQuoteEngine`; CTP bridge; routing audit | Own-book dealing; Jun 2026 MiFID III items |

**Critical path:** chain selection (D1) → identity core → valuation oracle (gates all Phase-1 modules) → venue settlement. The **valuation oracle is the tightest dependency** — Phase 1 cannot be trusted without it, and it needs its own hardening time.

---

## 10. Team & skills (shape, not headcount)

Solidity/EVM security engineers (contracts + audit liaison); backend engineers for the off-chain services (identity, oracle, matching, indexer, reporting bridges); a DevSecOps/key-management owner (HSM/MPC, DORA ops); and a compliance-engineering liaison who owns the Article→function traceability. The off-chain services span more disciplines than the contracts — staff accordingly.

---

## 11. Open decisions for the CTO

1. **Network topology (D1 sub-decision):** consortium-of-participants vs single-operator PoA vs appchain-with-L1-anchor — drives governance, DORA failover, DLT-Pilot operator accountability, and CeBM-settlement reachability.
2. **Settlement asset:** central-bank money (via trigger/bridge — issuer-identity + bridge atomicity concerns) vs tokenized commercial-bank e-money (issuer must be a credit institution) vs off-chain payment leg with on-chain confirmation. Shapes the `SettlementEngine` DvP design.
3. **Custody model:** self-custody (ONCHAINID wallets) vs qualified custodian vs hybrid — interacts with AIFMD depositary + DLT Pilot segregation.
4. **Build vs buy** for the load-bearing off-chain systems: Tokeny/managed T-REX stack vs in-house; oracle (Chainlink/Pyth vs proprietary custodian feed); ARM/APA/CTP reporting vendor vs in-house bridge.
5. **QEL status (eIDAS Art 45k–45l):** pursue "qualified electronic ledger" presumption? Requires the operator to be/contract a QTSP — shapes operator structure early.
6. **DLT Pilot cap as governance parameter** vs hard-coded — permanence package (proposed Apr 2026) may change thresholds; recommend parameterized.

---

See also: [eu_rwa_sto_smart_contract_design.md](../sales-marketing/Service/Content/Contract%20Design/eu_rwa_sto_smart_contract_design.md) (compliance requirements — the source) · [erc3643_explained.md](erc3643_explained.md) · [erc1400_explained.md](erc1400_explained.md) · [rwa_tokenization_explained.md](rwa_tokenization_explained.md) · [RWA-STO-EU-Compliance-Landscape.md](../sales-marketing/Service/Content/EU%20Compliance/RWA-STO-EU-Compliance-Landscape.md)
