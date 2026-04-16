---
type: concept
title: "Stablecoins in Cross-Border Payments"
created: 2026-04-16
updated: 2026-04-16
tags:
  - stablecoins
  - payments
  - cross-border
  - blockchain
  - fintech
status: current
related:
  - "[[Blockchain-Fintech-Solutions]]"
  - "[[CBDC-Central-Bank-Digital-Currency]]"
  - "[[JPMorgan-Kinexys]]"
  - "[[Asset-Tokenization-RWA]]"
---

# Stablecoins in Cross-Border Payments

Stablecoins are cryptocurrencies pegged to a fiat currency (typically USD) that combine blockchain settlement speed with price stability. They are the primary mechanism enabling blockchain-based cross-border payments.

## Market Scale

| Metric | Value |
|--------|-------|
| Stablecoin total supply (2025) | $305 billion |
| 5-year supply growth | $5B → $305B (6,000%+) |
| 2024 stablecoin transaction volume | $32 trillion processed |
| Cross-border stablecoin payments (2024) | ~$5.7 trillion |
| Current cross-border market share | ~3% |
| 2030 projected market share | 20% |
| Potential cost savings by 2030 | $10 billion |

## The Stablecoin Sandwich Pattern

The dominant implementation pattern for enterprise cross-border payments:

```
1. Sender converts local currency → stablecoin (at source)
2. Stablecoin transferred globally via blockchain (seconds, 24/7)
3. Recipient converts stablecoin → local currency (at destination)
```

This eliminates correspondent banking (3–5 intermediaries) while maintaining fiat-denominated accounting on both ends.

## Cost and Speed Comparison

| Dimension | Correspondent Banking | Stablecoin |
|-----------|----------------------|------------|
| Fee | 3–8% of transaction | 0.5–2% |
| Settlement time | 3–5 business days | Under 10 minutes |
| Operating hours | Business hours only | 24/7/365 |
| Chargeback risk | Yes | No (irreversible) |
| Transparency | Low (opaque SWIFT chain) | Full audit trail |

## Real-World Adopters

- **JPMorgan Kinexys**: $2B+ daily; institutional 24/7 cross-border flows
- **Stripe**: Building proprietary blockchain for global settlement (2026)
- **Deel**: Contractor stablecoin payroll; eliminates 3-day settlement delays
- **Visa**: Stablecoin settlement layer for card network
- **Tesla**: Enterprise supplier payments in stablecoins

## Regulatory Landmark: GENIUS Act (US, 2025)

The Guiding and Establishing National Innovation for U.S. Stablecoins Act is the first federal stablecoin framework in the United States. It legitimizes stablecoin issuance for regulated banks, removing the key legal barrier to institutional adoption.

Combined with EU MiCA stablecoin provisions, 2025 marks the first year major jurisdictions provided clear legal status to payment stablecoins.

## Challenges

- **Last-mile liquidity**: Converting stablecoins to local currency in developing markets (especially Africa, Southeast Asia) still requires local liquidity providers
- **Regulatory patchwork**: Despite GENIUS Act, global rules are still fragmented — each corridor (US→EU vs US→NG) has different compliance requirements
- **Volatility of pegs**: Algorithmic stablecoins (LUNA/UST collapse 2022) have destroyed confidence in non-collateralized models; fully-backed USDC/USDT dominate institutional use

> [!gap] No data on what percentage of the $32T stablecoin volume (2024) was genuine cross-border payments vs. DeFi-internal swaps. Real cross-border use is likely a fraction of total volume.
