---
type: concept
title: "Copy Trading"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - crypto
  - trading
  - binance
status: developing
related:
  - "[[Can I earn monthly income from Binance copy trading my BTC]]"
sources: []
---

# Copy Trading

**Copy Trading** is a service offered by custodial exchanges (Binance, Bybit, OKX, eToro) where a user automatically mirrors the trades of a selected "lead trader" proportionally to their allocated capital.

## How It Works

1. User deposits funds into the exchange's copy-trading wallet (USDT or similar).
2. User selects a lead trader from a leaderboard (filterable by ROI, drawdown, followers, etc.).
3. Every trade the lead trader executes is mirrored in the user's account, sized to their allocation.
4. Lead trader takes a **10% profit share** on gains; exchange takes standard trading fees on every copied trade.
5. User can stop copying any time; unrealized positions close at market.

## Two Variants

| Variant | Description | Risk Profile |
|---------|-------------|--------------|
| **Spot Copy Trading** | Mirrors actual buy/sell of assets (BTC, ETH, etc.). No leverage. User owns the assets. | Moderate — bounded by asset price to zero |
| **Futures Copy Trading** | Mirrors perpetual futures positions with leverage (5x–125x). User holds contracts, not assets. | High — liquidation risk, funding fees every 8h |

## Structure (Why It's Speculation, Not Income)

**Futures copy trading is zero-sum before fees, negative-sum after.** Every profitable long has a losing short on the other side. After exchange fees + 10% profit share + funding rates, the average participant must lose money mathematically.

**Spot copy trading is positive-sum long-term** because crypto markets grow over time, but fee drag (~4%/year at typical trade frequency) plus profit share means it often underperforms buy-and-hold.

## The Real Incentive Stack

- **Exchanges** profit from trading fees on every copied trade (volume = revenue).
- **Lead traders** profit primarily from the 10% profit share across their copier base. A lead with $5M AUM and 30% annual return earns $150k/year in profit share, often more than their own P&L. This is their real business model.
- **Copiers** bear the fees, profit share, and drawdowns. Incentives are structurally against them.

## Who It's For (Honestly)

- **Learners** — small allocation to study a professional's entries/exits; treat losses as tuition.
- **Diversified holders** — 5–15% slice on top of BTC/ETH positions, as a speculative return stream.
- **Risk-tolerant retail** — who understand it's entertainment-grade speculation, not passive income.

**Not suitable for:** retirement savings, monthly income, or any capital that cannot be fully lost.

## Realistic Spot Copy Returns (Annualized)

| Scenario | Probability | Return |
|----------|-------------|--------|
| Great trader + bull market | ~20% | +50% to +200% |
| Decent trader + sideways market | ~30% | +5% to +20% |
| Underperforms buy-and-hold | ~40% | -10% to +10% |
| Bad trader / bad timing | ~10% | -30% to -60% |

70–85% of retail futures traders lose money over 3–6 months (third-party studies). Spot is better but far from guaranteed.

## Evaluating a Lead Trader

Most users pick on ROI. That's wrong. Look at:

1. **Max drawdown** — aim <30%.
2. **Consistency / Sharpe** — steady beats spiky.
3. **Track record length** — ignore anyone with <6 months.
4. **AUM** — very high AUM dilutes alpha (their entries/exits move markets).
5. **Trade frequency** — <20 trades/month preferred (less fee drag).
6. **Win rate vs avg win/loss ratio** — 40% win rate at 3:1 reward beats 80% win rate at 1:3.

## Non-Custodial Alternatives

For users unwilling to give up self-custody:

- **Copin.io** — copy on-chain wallet trades via your own DEX account.
- **Hyperliquid vaults** — on-chain perps with vault-based copying.
- **GMX / dYdX** — social features and copy-adjacent functionality.

Smaller ecosystems, but keys stay with the user.

## Comparison to Just Holding BTC

Historically, ~95% of active crypto traders — copy traders included — underperform simply holding BTC over 3–5 year windows.

## Confidence

developing — structural claims (custody, incentive stack, zero-sum math on futures) are firm; return probability tables are calibrated estimates from industry data, not guarantees.
