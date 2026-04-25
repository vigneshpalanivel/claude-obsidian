---
title: "RWA Tokenization Explainers"
type: source
created: 2026-04-25
tags:
  - source
  - tokenization
  - RWA
  - ERC-1400
  - ERC-3643
status: ingested
---

# RWA Tokenization Explainers

**Date ingested:** 2026-04-25
**Source type:** Internal technical documentation (.raw/)
**Files ingested:**
- `rwa_tokenization_explained.md`
- `erc1400_explained.md`
- `erc3643_explained.md`
- `car_rwa_tokenization.md`

**Pages created:** 4 concept pages
- [[RWA-Tokenization-Technical]]
- [[ERC-1400]]
- [[ERC-3643]]
- [[Car-RWA-Tokenization]]

## Key Facts Extracted

- ERC-1400 is a family of 4 sub-standards: ERC-1594 (issuance/redemption), ERC-1410 (partitions/tranches), ERC-1643 (document management), ERC-1644 (forced transfers).
- ERC-3643 (T-REX) uses ONCHAINID (ERC-734/735) for standardized investor identity — key differentiator over ERC-1400.
- ERC-1400 preferred for general/open-source RWA dev; ERC-3643 preferred for EU-regulated and institutional markets.
- InnBlockchain project value: ERC-1400 platform $80K-$400K; ERC-3643 platform $100K-$500K+.
- Car RWA system requires 3 contracts (token, profit distributor, governance) + oracle + IPFS + IoT telematics layer.
- ERC-4626 (Tokenized Vault) is the standard for the Smart Treasury profit-sharing mechanism.
- The SPV Operating Agreement must explicitly designate the blockchain as the official Cap Table for legal enforceability.
- Revenue verification uses a 3-layer hybrid: on-chain crypto bookings (trustless), oracle-verified fiat (Chainlink/TLSNotary), IoT mileage telematics (DIMO).
- Car RWA build cost: $120K-$250K; MVP alone 3-4 months.
