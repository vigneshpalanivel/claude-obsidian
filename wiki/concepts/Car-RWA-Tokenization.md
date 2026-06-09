---
title: "Car RWA Tokenization: System Design"
type: concept
status: current
created: 2026-04-25
updated: 2026-06-09
tags:
  - RWA
  - tokenization
  - car-fleet
  - ERC-1400
  - ERC-4626
  - DAO
  - profit-sharing
  - innblockchain
related:
  - "[[RWA-Tokenization-Technical]]"
  - "[[ERC-1400]]"
  - "[[ERC-3643]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[InnBlockchain]]"
  - "[[Smart-Contracts-Finance]]"
---

# Car RWA Tokenization: System Design

Full system design for a car treated as a revenue-generating Real-World Asset (RWA) with:
- **Fractional ownership** via security token
- **Automated profit sharing** via Smart Treasury
- **DAO governance** for asset decisions

Assets: luxury rental cars (Turo/Avis), commercial vehicles (cab, delivery truck), or collector/exotic cars that appreciate.

---

## Legal Foundation

The car is owned by a **Special Purpose Vehicle (SPV)** — a legal entity holding the physical asset. Token holders own **shares of the SPV**, not the car itself. Revenue from the car flows to the SPV and then to token holders.

### Two Binding Mechanisms (Physical ↔ Digital)

**1. Operating Agreement (off-chain legal tie)**
The SPV's official operating agreement must state: *"The equity shares of this company are exclusively represented by digital tokens deployed on [blockchain] at smart contract address [0x...]."* This makes the blockchain the official Cap Table (shareholder registry).

**2. Document Anchoring (on-chain technical tie)**
The signed Operating Agreement PDF is uploaded to IPFS. The document hash is hardcoded into the smart contract via ERC-1643 Document Management. In any legal dispute, a judge can check the contract hash, find the Operating Agreement, and recognize token holders as legal SPV owners.

---

## Token Design

**Standard:** ERC-1400 or ERC-3643 (backwards-compatible with ERC-20 for MetaMask visibility, but with mandatory compliance layer on all transfers).

### Parameters (Example)

| Parameter | Value |
|-----------|-------|
| Car Value | $100,000 |
| Total Token Supply | 1,000,000 CAR tokens |
| Price per Token | $0.10 |
| Minimum Investment | $100 (= 1,000 tokens = 0.1% ownership) |
| Maximum per Investor | 30% (regulatory cap) |

### Token Partitions (via ERC-1410)

Two classes within one contract:
- **Equity Partition** — profit share + voting rights (founding/primary investors)
- **Revenue Partition** — profit share only, no voting (retail/secondary investors)

**Ownership formula:** `Ownership % = (Investor Token Balance ÷ Total Supply) × 100`

---

## Fractional Ownership System

### Primary Market (Initial Offering)

- SPV defines total car value and divides into a fixed token count.
- Investors buy fractions during a funding window.
- If funding goal is not met by deadline, funds are automatically refunded via smart contract.

### Secondary Market (Liquidity)

After the lock-up period, investors trade fractions on the platform's compliant marketplace (bulletin board or DEX). Smart contract automatically updates the ownership registry, routing the next profit cycle to the new holder.

### Compliance Rules

- Only KYC-verified wallets can hold tokens.
- Transfers restricted during lock-up (e.g., 12 months post-issuance).
- Hard cap: no single wallet can exceed 30% of supply.
- The on-chain holder list is the real-time Cap Table — no manual accounting.

---

## Smart Treasury: Automated Profit Sharing

Unlike manual operator deposits, this system uses a **Smart Treasury Contract (ERC-4626)** that automates the full flow: revenue in, expenses out, profit distributed.

### EIP Standards Used

| Contract / Token | EIP Standard | Purpose |
|-----------------|-------------|---------|
| Car Ownership Token | ERC-1400 / ERC-3643 | Security token: ownership and voting rights |
| Utility / Payment Token | ERC-20 | Platform's internal crypto for on-chain car bookings |
| Fiat / Stablecoin | ERC-20 (USDC/USDT) | Expense payouts and profit distribution |
| Smart Treasury / Profit Pool | ERC-4626 (Tokenized Vault) | Yield-bearing vault: deposits revenue, calculates shares, distributes yield |

### 5-Step Automated Flow

**Step 1 — Revenue Collection**
- Crypto bookings: utility tokens flow directly into the Smart Treasury contract (on-chain, verified automatically).
- Fiat bookings: an oracle syncs Stripe/gateway revenue data into the contract.

**Step 2 — Expense Submission**
- SPV Operator submits expense claims with IPFS hash of receipts/invoices.
- Large expenses (>$1,000) may trigger a DAO vote before funds unlock.

**Step 3 — Expense Payout**
- Smart Treasury automatically releases stablecoins from the gross revenue pool to the Operator.

**Step 4 — Net Profit Calculation**
- `Net Profit = Total Revenue - Reimbursed Expenses` (calculated on-chain at end of cycle).

**Step 5 — Distribution**
- Net Profit channels into the distribution pool.
- Investors "Claim Profit" from their dashboard anytime — exact pro-rata share pulled directly to their wallets.

### Distribution Schedule Options

| Model | Description | Best For |
|-------|------------|---------|
| Monthly | Contract closes accounting every 30 days | Stable rental fleet |
| Quarterly | Accumulates, distributes every 3 months | Lower gas-cost model |
| On-Demand/Streaming | Profit streams block-by-block, claim anytime | High-engagement Web3 UX |

Recommended: Monthly accounting close + On-Demand Investor Claiming (lazy distribution saves gas).

### Revenue Verification: Hybrid Model

Since the SPV Operator owns the rental platform (no third-party API for verification):

**1. Crypto Revenue (Trustless)**
- Booking transactions happen on-chain; utility tokens go to smart contract escrow.
- Revenue split executes automatically: X% to Operator, Y% to Profit Pool.
- Mathematically proven, cannot be faked.

**2. Fiat Revenue (Oracle Gateway)**
- Credit card payments hit a payment gateway (Stripe).
- A Decentralized Oracle (TLSNotary or Chainlink) cryptographically verifies transaction volume from the Stripe API.
- Smart contract checks the Operator's monthly stablecoin deposit against oracle-proven gateway data.

**3. Physical Verification (IoT Telematics)**
- Each car fitted with a tamper-proof IoT device (e.g., DIMO) connected to the blockchain.
- Logs mileage and engine-on time. If the platform claims "$0 revenue" but the IoT oracle proves 500 miles driven, investors are alerted immediately.

### On-Chain Expense Audit

Each monthly cycle, the Operator submits on-chain:
- Period (e.g., March 2026)
- Gross revenue figure
- Itemized deductions (insurance, maintenance, platform fees, management fee)
- Net profit figure
- IPFS Document Hash (bundle of all receipts)

Investors can verify numbers on their dashboard and click the IPFS link to see actual receipts. Full audit trail — no black box.

---

## DAO Governance: Voting System

### Decision Quorum Levels

| Decision Type | Quorum Required | Examples |
|--------------|----------------|---------|
| Operational | 30% of tokens | Change rental platform, replace operator |
| Financial | 51% of tokens | Adjust management fee, increase reserve fund |
| Major | 67% of tokens | Refinancing, major repair >$5,000 |
| Exit / Sale | 75% of tokens | Selling the car, winding down the SPV |

### Voting Rules

- 1 token = 1 vote.
- Minimum 1% of supply to create a proposal (prevents spam).
- Each address votes once per proposal.
- Proposal description stored on IPFS; pulled into dashboard UI.

### Governance Flow

1. Proposal created (above threshold, title + IPFS description + category + 7-day window)
2. Voting period: FOR/AGAINST cast by token holders
3. Quorum check after deadline
4. If quorum met and FOR > AGAINST: proposal approved, Operator legally bound to execute
5. If quorum missed or AGAINST wins: proposal fails with no action

---

## Full System Architecture

### Blockchain Layer (3 Contracts)

- **Car Token Contract (ERC-1400)** — issuance, KYC whitelist, transfer restrictions, ownership records
- **Profit Distributor Contract** — accepts stablecoin deposits, calculates claimable amounts, handles withdrawals
- **Governance Contract** — proposals, votes, quorum logic, approvals

All three share a common KYC Registry and connect to an Oracle for off-chain revenue data.

### Backend Layer

- Expense reporting API (operator monthly reports)
- KYC/AML integration (Sumsub, Onfido)
- Oracle service (bridges real-world revenue to blockchain)
- IPFS document storage (Pinata / Filecoin)
- Notification engine (email and web3 wallet alerts)

### Frontend Layer

**Investor Portal:** token balance and ownership %, profit history and claim button, proposals and voting, token marketplace.

**Admin / SPV Operator Dashboard:** issue/redeem tokens, upload expense reports, deposit net profit, manage KYC whitelist, create governance proposals.

---

## InnBlockchain Revenue Model

| Revenue Stream | Model |
|---------------|-------|
| Token Issuance Fee | 1-3% of total raise |
| Platform Transaction Fee | 0.5-1% per token transfer on secondary market |
| Annual Management SaaS Fee | Charged to SPV operators |
| White-label Licensing | Sell the platform to fleet operators / leasing companies |

---

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Blockchain | Polygon (low gas) or Ethereum L2 (Arbitrum) |
| Token Standard | ERC-1400 or ERC-3643 |
| Profit Currency | USDC (stable) |
| KYC Provider | Sumsub or Onfido |
| Document Storage | IPFS via Pinata |
| Governance | Custom DAO or OpenZeppelin Governor (extended) |
| Frontend | Next.js + ethers.js / wagmi |
| Backend | Node.js + PostgreSQL |
| Oracle | Chainlink (revenue data verification) |

---

## Development Roadmap

| Phase | Deliverables | Timeline |
|-------|-------------|---------|
| Phase 1 — MVP | ERC-1400 token, KYC onboarding, profit distributor, basic dashboard | 3-4 months |
| Phase 2 — Governance | Voting DAO, proposal system, IPFS document upload, expense reports | 2-3 months |
| Phase 3 — Marketplace | Secondary token trading, compliance-gated DEX or OTC portal | 2-3 months |
| Phase 4 — Scale | Multi-car portfolio, white-label for fleet operators | Ongoing |

**Estimated Build Cost:** $120,000 — $250,000 depending on team and jurisdiction scope.

---

## Regulatory Classification

The Car Token (ERC-1400 / ERC-3643 representing SPV equity + revenue rights) is a security token by design — confers ownership, profit share, voting. Jurisdiction mapping:

| Jurisdiction | Regime | Key obligations |
|---|---|---|
| **EU** | **MiFID II + Prospectus Regulation** (token = transferable security; **not** MiCA — Art. 2(4) excludes financial instruments). **AIFMD / UCITS** (the SPV pools capital from passive investors for rental yield + resale value — a *collective investment undertaking* by default, so a fund-manager regime applies and the token is also a unit in a CIU under MiFID Annex I C(3)). The DAO's *periodic* governance votes do **not** amount to the day-to-day control that escapes AIF status, and passive rental yield is **not** the "operating-business" carve-out — so AIFMD is the base case, not optional. Secondary trading on a regulated DLT platform = **DLT Pilot Regime** (DLT MTF / TSS). Issuer authorization or partnership with a licensed investment firm required. | Prospectus or exemption (≤€8M private placement, qualified-investor-only, etc.); **AIFM coverage** — a single small-value SPV sits far below the AIFMD de minimis thresholds (€100M leveraged / €500M unleveraged, AUM), so the realistic path is a **sub-threshold AIFM registration** (national, lighter — but no EU marketing passport) rather than full AIFM authorization; scale to a multi-car portfolio and full authorization + depositary + AIFMD reporting kick in; MiFID-compliant investor categorization; transaction reporting; DLT Pilot operator for secondary venue |
| **US** | Reg D 506(c) (accredited only) or Reg A+ (retail with SEC qualification); secondary on an ATS or licensed exchange. Token is a security under Howey by design. | Investor accreditation verification; SEC filings; transfer restrictions per Reg D |
| **MENA (ADGM / DFSA / VARA)** | Investment Token regime (security token) under FSRA / DFSA / VARA Virtual Asset framework — varies by emirate | Issuer authorization; investor categorization; custody under licensed VASP |

The "30% per-investor cap" and "12-month lock-up" defaults in this design align with EU MiFID retail-protection conventions and US Reg D resale restrictions respectively — both should be set per-jurisdiction during deployment, not hardcoded as global defaults.

---

## Risk Factors and Mitigations

| Risk | Mitigation |
|------|-----------|
| Car depreciation exceeds projections | Depreciation reserve fund locked in contract |
| Operator misreports expenses | Oracle verification + IPFS audit trail + investor vote to replace operator |
| Low rental utilization | SPV operator KPIs enforced via governance proposal |
| Regulatory change | Jurisdiction whitelist, legal wrapper upgradability |
| Token illiquidity | Secondary marketplace with compliant DEX or OTC portal |
| Vehicle total loss | Insurance payout flows to profit pool; token redemption triggered |

---

## Differentiators vs. Basic Tokenization

| Feature | Basic ERC-20 Tokenization | This System |
|---------|--------------------------|------------|
| Compliance | None | KYC/AML enforced |
| Expense transparency | None | On-chain expense reports |
| Profit share | Manual | Automated smart contract |
| Investor governance | None | Full DAO voting |
| Legal wrapper | None | SPV + token = regulated security |
| Secondary trading | Open (illegal) | Compliant gated marketplace |
