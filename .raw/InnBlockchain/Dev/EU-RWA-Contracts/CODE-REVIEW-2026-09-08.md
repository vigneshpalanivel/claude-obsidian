---
title: Code Review — EU-RWA-Contracts vs design rev 49 and the blog family
date: 2026-09-08
reviewed: 28 .sol files / 30 contracts in this folder; eu_tokenized_securities_smart_contract_design.md rev 49; the 10 drafted articles + Series Plan + PARKED Venue Lane; checklists consulted: aml, gdpr, eidas2, mifid2, prospectus, priips, dora, mar, aifmd, aifmd2, ucits, eltif, eltif-rts, dlt-pilot, mifir
method: full read of every contract by four layer reviewers; every HIGH below re-read at the cited lines by the lead reviewer; compile with solc 0.8.22 (optimizer, viaIR). No test harness exists in the folder, so nothing below is runtime-verified.
status: ⚠️ FINDINGS AS AT THE REVIEW. All nine HIGHs and the MEDIUMs were fixed the same day — see the outcome note below and `REMAINING-COMPLIANCE.md` §11 for what is still open. Read this file as the record of what was wrong and why, not as a live worklist.
---

> ## Outcome — 2026-09-08, same day
>
> **All nine HIGH defects are fixed and verified at the cited lines. The suite compiles clean** (solc 0.8.22, optimizer, viaIR: 0 errors, 0 warnings, 30 contracts). The MEDIUM list was worked through in the same pass; the design doc went to **rev 52** and `REMAINING-COMPLIANCE.md` was re-synced from rev 36 with a new §11.
>
> **What is still open, and none of it is a code fix:**
> - **D20 blocks any proxy deployment.** 95 immutables, no contract cleared. `SubscriptionEscrow` is now marked never-proxied; the rest is undecided.
> - **Does the escrow mint?** The design says yes, the code mints nothing, S1 and Pure Issuer describe the mint. **Decide, then sweep whichever side is wrong.**
> - **The ELTIF RTS Art 5(5)–(6) redemption cap is still not built** — `LmtGate` is a correct Annex V toolkit and nothing more. S2 claims otherwise.
> - **No issuer-lane surveillance emitter exists** for the Art 16(2) own-trading duty. M5 and S3 describe one.
> - **Native asset only** on both value-moving paths; D6 has no code either way.
> - **No test harness.** Everything here and in the fix pass is reading plus compiling, never running.
>
> Section 5 below (blog divergences) drove a correction pass across the article family; the Series Plan carries the current per-article state.

# Verdict

**The folder compiles clean but is not deployable as a compliance engine, and the design doc has moved 13 revisions past what the folder tracks.** Nine HIGH defects are confirmed in code. Three are "the control the design says is mandatory can be switched off or walked around" (forced transfer, escrow settlement, fund sync). Two brick a live path outright (a recursion in the covenant registry, every burn blocked once a receive-covenant is configured). Two are the same defect the tracker already claims closed (the oracle "auto-trip" pauses nothing; DoraGovernor is unswept). The rev-38 standing rule (interface-typed, settable, never-null references) is violated in 9 contracts. `REMAINING-COMPLIANCE.md` is at rev 36 against a rev-49 design and states three things the design has since withdrawn.

**Compile:** solc 0.8.22 + optimizer + viaIR → 30 contracts, 0 errors, 0 warnings, largest init code 9.5 KB. Without viaIR, `SiQuoteEngine.sol:363` stack-too-deep (known; parked lane). No build config pins viaIR.

---

# 1. HIGH — confirmed at the cited lines

| # | Contract | Defect | Failing scenario | What the source says |
|---|---|---|---|---|
| H1 | `SecurityToken.sol:484-486` | **`forcedTransfer` never calls `restrictions.assertTransferPermitted`.** It runs `identityRegistry.checkEligible(to)` + `compliance.checkTransfer` only. The NatSpec at :456-457 says the sender's hold is enforced "because `compliance.checkTransfer` still runs `RestrictedPartyGate`" — i.e. through the removable module list. | `removeModule(RestrictedPartyGate)` or `emergencyBypass(gate)` → agent `forcedTransfer(anyone, blockedWallet, n)` lands units on a listed person; `forcedTransfer(blockedWallet, nonPermittedAddr, n)` releases them. | Design §4:511-513, §17a note 14, `DEPLOYMENT-DEFAULTS.md:78-82`: "no wiring exists in which either contract runs without a restriction store". Rev 48's guarantee holds for `_move` paths only. |
| H2 | `CovenantRegistry.sol:492-500 ↔ 523-531 ↔ 579-580` | **Infinite recursion once an opt-up covenant is set.** `effectiveTier` → `_satisfied(optUpCovenantId)` → `appliesTo` → `effectiveTier` with no base case when `tier == ProfessionalOnRequest`. | `setOptUpCovenant` live + any elective-professional holder → every `assertSatisfied`, `mayUpgradeTier`, `diagnose` reverts (stack/gas). Every transfer of that holder fails. | Blog M3 §5 rule 4 recommends exactly this configuration for retail distribution. |
| H3 | `CovenantRegistry.sol:699-700` (`CovenantGate`) | **Any RECEIVE-gated covenant blocks every burn.** On burn `to == address(0)` → `assertSatisfied(0, RECEIVE)` → `tierOf(0) == Unset` → `(false,false)` → `!evaluable` → `Blocked()`. `SecurityToken.burn` runs the full hook (:410-412, :287-291). The other three adapters skip the zero leg. | Configure PRIIPs Art 13 / ELTIF Art 26 / DLT Pilot 4(2)(g) as RECEIVE (all are) → redemptions, buy-back burns (`BuybackAgent.disposeUnits`), maturity burns all revert. | Design §4a: covenants are checked at mint/send/receive; a burn is an exit and should be gated on SEND only if at all. |
| H4 | `SubscriptionEscrow.sol:542-550, 526-534` | **`settle()` is permissionless and blocks only on windows already pushed.** A subscription with no window yet can be settled one block after `subscribe()`; `withdrawAcceptance` then reverts `AlreadySettled` (:500). No offer-close timestamp exists. | `finalPriceOmittedAtFiling == true`: every subscription is settle-able before `publishFinalPrice` — Art 17(2) right destroyed for the whole offer. Same for Art 23(2) on anything settled before a supplement lands. | Design §8:1172 says release is "immediate… a no-op" when no window is open. **The design is wrong on this point**, not just the code — both withdrawal rights arise from events that happen *after* acceptance. |
| H5 | `EltifConcentration.sol:189-206`, `UcitsFiveTenForty.sol:255-271` | **Permissionless sync takes caller-supplied classification.** `syncAssetValuation(assetId, isEligibleLongTerm, isSts, isOtcRepo, isCrossHolding)` and `syncLegValuation(legId, legType, entityId, isNonUcits)` are open to anyone and book the oracle delta under whatever flags the caller passes. Only `isCreditInstitution` is persisted at trade time (Ucits:237). | Anyone passes `isEligibleLongTerm=false` on a price fall → 55% floor breach hidden; passes a garbage `entityId` → Art 52(4) roll-up understated; wrong `legType` → value booked into a second mapping. The header's "a caller can no longer corrupt the book" (Eltif:186-187) is false. | Design §5 and REMAINING-COMPLIANCE §8: permissionless sync is safe *because the figure is oracle-guarded*. The classification is not. Persist classification at `recordAssetTrade` and drop the arguments from sync. |
| H6 | `NavBorrowingCap.sol:243-250`, `UcitsFiveTenForty.sol:205-212`, `LmtGate.sol:201-207` | **`syncNav` zeroes `cashSinceValuation` / `payoutsSinceValuation` on every call**, with no check that `acceptedAt` advanced since the last sync. | `onBurn(X)` → anyone calls `syncNav()` while the oracle still holds the pre-redemption figure → `nav()` overstated by X, every ratio understated, next `rollWindow` oversized by the erased payouts — the dilution LmtGate's own header says it prevents. | REMAINING-COMPLIANCE §8 "NAV is two fields… they fail differently". Store the `acceptedAt` absorbed; skip or revert when unchanged. |
| H7 | `DoraGovernor.sol` whole file; `:71, :155, :185, :239, :289-296` | **(a) Unswept after rev 46/49:** still carries `queueUpgrade` with the `documentStatus` gate (:178-218), `revealUpgrade` (:225-237), `executeUpgrade` doing arbitrary `target.call` (:239-253), `MIN_TIMELOCK_DELAY = 12 hours` (:47) against the design's ≥48h, a locally re-declared `IDocumentRegistry` (:4-8), and NatSpec (:18-32) asserting the exact "approved BEFORE deployment" inversion rev 49 corrected. **(b) `paused` is read by nothing outside this contract.** Only its own `whenNotPaused` (gating the withdrawn queue) reads it; `SecurityToken` has an independent agent-set `paused` (:118, :251); grep `pause` hits only DoraGovernor, SecurityToken, ValuationOracle. So `ValuationOracle._tripCircuitBreaker → tripFromOracle` flips a flag with no consumer. | Oracle deviation halt → "protocol pause" → nothing that moves tokens or cash stops. The real halt is the fund modules' fail-closed `value()` reads, which need no trip. | REMAINING-COMPLIANCE §9 #5 claims the "auto-trip satisfied only by an event" defect **closed**. It is not: a call that sets an unread flag is an event. `UPGRADE-ARCHITECTURE.md:253` "halts the modules that read it" — none do. Design §17 row 1566 says the contract's remaining surface is pause + incidents + key rotation; rev 46 entry admits it is "NOT yet swept". |
| H8 | `NavBorrowingCap.sol:189-191, 346, 359`; `UcitsFiveTenForty.sol:160-162`; `LmtGate.sol:285-291` | **Active-path "fail-closed" checks oracle *freshness* but computes the ratio on the *last-synced* `navAtValuation`.** Sync is permissionless, so the AIFM simply does not call it. | Oracle accepts a lower NAV; nobody syncs; AIFM draws leverage against the old higher figure and passes. `rollWindow` passes `freshNav` but sizes off stale `navAtValuation`. | Design §5:773 "a wrong NAV silently passes a breach" is the harm §5's halt rule exists for. `_requireFreshNavIfIncreasing` must also require `oracle.acceptedAt == lastSyncedAt` or sync inline. |
| H9 | `UcitsFiveTenForty.sol:298-309, 346-352` | **The Art 52(2) 40% band aggregate drifts.** Membership in `issuerBandAggregateValue` is decided at touch time; a NAV move that carries issuer X across 5% neither adds X's base value nor removes it. No issuer set exists to sweep; `_recheckAll` rechecks two aggregates only. | NAV falls, X crosses 5% between touches → X never enters the band → 40% cap understated. | ucits-checklist.md:292 — Art 52(2) is the core UCITS rule. |

**Also HIGH by regulatory consequence, already recorded as open at rev 49 and still open:**

- **`SubscriptionEscrow.subscribe()` reads `currentVersionHash` (:349-356), never `approvedAt`.** A version anchored via `anchorVersion` (`DocumentRegistry.sol:185-194`, `approvedAt: 0`) is current immediately, so subscriptions are accepted against an unapproved prospectus. Art 12 runs from approval (prospectus-checklist.md:349). `extendProspectusValidity` (:316-320) records no approval either.

---

# 2. MEDIUM

### Token, identity, restrictions
- **M-T1** `ModularCompliance.sol:96-117` — `removeModule` does not clear `bypassed[module]`; `addModule` does not reset it. Bypass → remove → re-add: the module is silently skipped with no `ModuleBypassed` event. Contradicts "logged, never silent" (:34-37).
- **M-T2** `SecurityToken.sol:452 vs :486` — NatSpec says "holding periods do not apply" on forced transfer; the call reaches `HoldingPeriodGate` with the real `from`, so a seizure during ramp-up reverts `StillInRampUp`. Design §4:506 says the carve-out exists so orders can execute.
- **M-T3** `RestrictedPartyRegistry.sol:400` — `screeningIsStale` is false while `sweptToVersion >= listVersion`, and both start at 0. A deployment that never calls `advanceListVersion` mints forever unscreened. `DEPLOYMENT-DEFAULTS.md:183` and design note 14 say "until a sweep is recorded every mint reverts" — not true.
- **M-T4** `ClaimTopicsRegistry.sol:22`, `IdentityRegistry.sol:453, 498` — `TOPIC_AML_SCREENED = 2` is a per-wallet screening slot beside the store; `rawClaim` exposes `AssertedFalse` publicly and `checkEligible` reverts naming the topic. A vendor that records a hit as `AssertedFalse` on topic 2 instead of `blockRecord` rebuilds the two-slot leak rev 48 removed. No NatSpec forbids it. `Interfaces.sol:93-95` says `checkEligible` reverts with "a single generic code"; it reverts with three typed errors (:492-498).
- **M-T5** `ModularCompliance.sol:144-147` — still states the unqualified propagate-the-module's-error rule; no informative/generic classification, no Art 76 carve-out NatSpec (REMAINING-COMPLIANCE §5 "fifth", open since 2026-09-07). `RestrictedPartyGate` also raises a *second* error `ScreeningStale()` (:245, :441) on the transfer path, contradicting "THE ONLY ERROR ON THE TRANSFER PATH" (:226).
- **M-T6** `IdentityRegistry.sol:74, 418, 448` — `expiresAt == 0` means "never expires" and is accepted from any trusted issuer with no floor. The Art 20 refresh cadence M2 §4 calls "the claim's expiry" is opt-in per write.
- **M-T7** `ClaimTopicsRegistry.sol:96-104` — "topics 8 and 22–26 retired, never reassigned" is comment-only; `addBaselineTopic(8)` succeeds.
- **M-T8** `HoldingPeriodLock.sol:75, 92` — `recordSubscription` resets the clock on every call despite the "once" comment; a secondary-market recipient with no `subscribedAt` is permanently blocked by `NoSubscriptionRecorded`.

### Documents, covenants, escrow
- **M-D1** `CovenantRegistry.sol:436-442, 599-601` — `signCovenant` has no attestor check; an `OperatorAttestation` covenant (ELTIF Art 26 suitability) is satisfied by the investor's own transaction.
- **M-D2** `SubscriptionEscrow.sol:331` — `subscribe()` reads only `jurisdictionOf`. No `checkEligible`, no `IRestrictedParty`, no mint (so no hook). Cash is accepted from and refunded to a restricted or ineligible wallet. Design §8:1165 assumes the pending-state mint carries the gate; **the escrow mints, burns and touches no token at all** (imports no token interface; `withdrawAcceptance` is refund-only, :503-509). Design §17 row 1558 "burn + refund on withdrawal" and blog S1:128 / Pure Issuer:80 describe a mint that does not exist. Cash leg is native ETH only — the D6 stablecoin/EMT leg has no code.
- **M-D3** `SubscriptionEscrow.sol:156, 161` — `supplementWindowDurationSeconds` / `finalPriceWindowDurationSeconds` are read by nothing, have no setter, and no floor is enforced: governance can push `closesAt == opensAt`. Dead state inside the contract the design uses as its §11 worked example.
- **M-D4** `SubscriptionEscrow.sol:451` — `publishSupplement` accepts any approved hash from any slot/regime; a KID hash opens an Art 23 window. `DocumentRegistry.sol:207-208` fires `SupplementPublished` on *any* second Prospectus-slot anchoring, including a replacement base prospectus.
- **M-D5** `DocumentRegistry.sol:250-299` — `anchorConcealed`/`revealConcealed` (Art 17(4) delayed disclosure, insider-list artefacts) exists in code and blog M4 §7 but is **unspecified in the design**: §17b's Art 17(1a) row says on-chain = "None" (:970, :1741) and the Art 18 row says "no anchoring contract" (:1747). Also: reveal skips the `VersionHashAlreadyUsed` check (:293-294), emits no `SupplementPublished`/`KidRevised` (:297-298), and a second `anchorVersion` on the slot strands the commitment (:282-283).
- **M-D6** `ValuationOracle.sol:399` / `DoraGovernor.tripFromOracle` — `tripFromOracle` returns nothing, so Solidity's pre-call `extcodesize` check is **not** caught by `try/catch`; `setCircuitBreaker(EOA)` reverts every deviation-halt post, contradicting the oracle's NatSpec (:80-81, :394-396).

### Fund structure
- **M-F1** Active path `navNow == 0 → return` passes any draw/buy (`NavBorrowingCap.sol:347`, `Ucits:360`, `Eltif:268, 286`). First oracle acceptance skips the deviation band (`ValuationOracle.sol:374`) so 0 can be accepted. Fail-closed on acquisition should revert on a zero denominator.
- **M-F2** `LmtGate.sol:281-291, 306-328, 345-365` — no minimum window duration (AIFM can roll after every payout); first-processed-first-paid, not pro-rata (ELTIF Art 18(2)(e), eltif-checklist.md:303, design :800); `requestRedemption` takes caller-supplied `shares`/`cashValue` with no balance check; `processRedemption` moves no cash, burns no units, runs no gate — a listed holder is "paid" on the books. Carried amounts are haircut twice (:365 → :345-354).
- **M-F3** `LmtGate.sol:255-257` — selection enforces only `selectedCount >= 2`; the "from points 2–8, not 5 and 6 alone" constraints (aifmd2-checklist.md:36, ucits-checklist.md:632-634, design :724) are not enforced and `SidePocket`/`DualPricing` count toward the two.
- **M-F4** Suspension relief applied to **every** bucket (`Eltif:274, 291, 342-352`; `NavBorrowingCap:357, 423-433`), whereas eltif-checklist.md:190 scopes Art 17(1)(c) to the 55% floor and 16(4) to borrowing; NavBorrowingCap applies an ELTIF relief to UCITS Art 83 buckets. `liftSuspension` → re-activate restarts the 365-day clock indefinitely (:410-421; Eltif:329-340) despite the "not an indefinite escape hatch" comment.
- **M-F5** No Art 17(1)(a) / Art 16(3) start-date input in Eltif or NavBorrowingCap; Ucits Art 56 ramp-up derived from `deployedAt` (:80, :169, :398) not the authorisation date (ucits-checklist.md:614). `HoldingPeriodLock.sol:10` cites 17(1)(c) for what is 18(2)(a).
- **M-F6** Every AIFM / ManCo / subscriptionAgent / regulator key in the four fund modules and HoldingPeriodLock is `immutable` — unrotatable, against §9 (the oracle got two-step rotation at rev 35; its consumers did not).
- **M-F7** `EltifConcentration.sol:174-175` — `recordAssetTrade` checks feed freshness then books the AIFM's *own* delta; the oracle figure is adopted only on a later passive sync, so a nominal delta passes the active check and the true value is flagged passive.
- **M-F8** Article labels: Eltif calls the 30% cross-holding cap "Art 13(5)" (:38, :64, :73); it is Art 15(1) (eltif-checklist.md:234). 13(5) is the covered-bond uplift. Ucits applies 10% to all non-UCITS CIUs (:37, :328); design :720 and checklist :318 give 20% (flagged "interpretation"). No Art 15(2) counter exists (S2 claims six counters; code has five).

### Economics, MAR
- **M-E1** `BuybackAgent.sol:132` — **no instrument-type gate.** mar-checklist.md §2.1 (:92-100) is written for own *shares*; the contract lets a debt-token or fund-unit issuer run a programme labelled as an Art 5 harbour. Series Plan, S3 §9, M5 §7 are right; design §5a row 867 / §17 row 1565 and the contract header (:7) are wrong.
- **M-E2** `DistributionAgent.sol:288-289, 310-330` — no per-distribution spend invariant; all distributions share one ETH balance. Agent anchors `totalUnits` below the leaf sum → later holders paid from another distribution's funding, which runs dry mid-register (the "partial payment" §5a:870 says must be impossible). No on-chain check that Σ leaf units == `totalUnits`.
- **M-E3** `DistributionAgent.sol:18-23 vs :427-430` — header claims `EntitlementUnclaimed` fires identically for a failed push; in fact `_send` reverts `PayoutFailed(to, amount)`, so the event fires **only** on gate failure — the "only ever fires for compliance reasons" tell M5 §3 warns about, naming the wallet (indexed).
- **M-E4** `BuybackAgent.sol:454-497, 546-563, 606-614` — `executePurchase` is `payable` but never reconciles `msg.value` (surplus trapped, no `receive`, no sweep); `recordPublication` accepts `publicationRef = 0` and checks nothing against `documents` (self-attested Art 5(1)(c)); `disposeUnits` burns any amount from treasury, unbounded by `boughtUnits`, callable on a `Disclosed` programme.
- **M-E5** `PdmrClosedPeriodFreeze.sol:195-203, 216-222` — `cancelPeriod` lifts a *live* window with no evidence hash; no `reschedule` exists, so the ordinary "report slips a week" case requires exactly this call and the audit trail cannot distinguish slip from evasion. The Art 19(12) override is `onlyIssuer`, not governance (design §6:912, S3 §3 say governance-gated).
- **M-E6** `PdmrRegister.sol:132-134, 229, 259-266, 276` — `WalletDeclared(wallet, personId, pdmrId, role, declarationHash)` publishes permanently, three keys indexed, that a wallet is a PDMR/PCA **and which PDMR a PCA is associated with** — the relationship S3 §4:70 and the code header (:59-62) say never goes on-chain. `purgeWallet` leaves `_walletsOfPerson` and `lastAttestedAt`. `revokeWallet` is registrar-only, unconditional, immediate — unfreezes mid-window. Same class as D22.
- **M-E7** `CouponSchedule.sol:95-96, 288-290, 343-346` + `DistributionAgent.sol:224` — zero-coupon notes cannot reach redemption (`declareDistribution` reverts `ZeroRate`; every period must be Settled or Defaulted). `DistributionWaterfall.sol:336-338` demands `totalUnits * ratePerUnit == owed` exactly — no solution when `owed` is not divisible.
- **M-E8** `DistributionAgent.sol:399, 412-421` — `redeemUnclaimed` after `sweepUnclaimed` underflows (`unclaimedOf` not zeroed).
- **M-E9** M5 §8 / S3 §10 promise an issuer-lane order-lifecycle surface for Art 8(1) replay; **no issuer-lane contract implements `IMarketEventSchema`** (only `SiQuoteEngine`). `BuybackAgent` emits `PurchaseExecuted` only; no order create/modify/cancel exists. `BuybackAgent.checkIssuerMaySell()` (:623-626) is read by nothing.

### Parked venue lane (recorded, not prioritised)
- `DltPilotCapGate.sol:283-286` — €6bn test is "already at", not "would reach" (dlt-pilot-checklist.md:183); candidate value not added before the test.
- `SettlementEngine.sol:225-229, 306-385` — never touches `SecurityToken`; securities are an internal governance-credited book; no hook, no identity check on either leg.
- `SiQuoteEngine.sol:6-8` re-declares `IIdentityGate` locally — the "two types with one name" hazard §3:426 forbids.
- `Interfaces.sol:188-192` declares an unimplemented `IMarketEvents.emitTrade` carrying raw `buyer`/`seller` addresses — dead code contradicting `MarketEventSchema.sol:99-101`.

---

# 3. Rev-38 standing rule — reference discipline violations

Rule (design §3:413-428): reference by interface, behind a governance setter, never `immutable`, never null; one declared exception (`CovenantRegistry → IdentityRegistry` pending D19). Rev 39/40 entries claim every contract is converted with two exceptions. Actual state:

| Contract | Reference | Immutable | Setter | Zero check | Typed |
|---|---|---|---|---|---|
| `IdentityRegistry.sol:111-112` | `claimTopics`, `trustedIssuers` | yes | none | none | interface |
| `SubscriptionEscrow.sol:56` | `identity` | yes | none | yes | interface |
| `SubscriptionEscrow.sol:120` | `documents` | no | **none** (constructor-only) | **nullable** in Exempt mode | interface |
| `DoraGovernor.sol:37` | `documents` | yes | none | ? | **locally re-declared** interface |
| `PdmrClosedPeriodFreeze.sol:66` | `register` | yes | none | none | concrete import |
| `HoldingPeriodLock.sol:113` (`HoldingPeriodGate`) | `lock` | yes | none | none | concrete |
| `CovenantRegistry.sol:687` (`CovenantGate`), `PdmrClosedPeriodFreeze.sol:367` | adapter → module | yes | none | — | concrete (the adapter pattern; only the closed-period one is named as an exception at rev 40) |
| `BuybackAgent.sol:301-306`, `CouponSchedule.sol:196-198`, `DistributionWaterfall.sol:169-170` | all deps | no | yes | **constructor accepts address(0)** | interface |
| Fund modules ×4 (`oracle`) | settable, but typed as **concrete `ValuationOracle`**; `IValuationFeed` is implemented by nothing | | | | concrete |
| `SettlementEngine:45-48`, `MemberEligibility:113`, `SiQuoteEngine:39` | identity etc. | yes | none | none | (parked) |
| `IdentityRegistry.sol:88-94` | re-declares `Tier` locally instead of importing `Interfaces.sol`; never declares `is IIdentityGate` | | | | **the exact hazard §3:426 names** |

`DEPLOYMENT-DEFAULTS.md:152` "nothing is immutable afterwards" is false.

**D20 (proxy) inventory:** 95 `immutable` declarations across 28 files (rev 42 said ~60 across 24). Note the rev-42 mechanism is imprecise: immutables read the *implementation's* constructor values through a proxy, not zero. Silently load-bearing examples: `ModularCompliance.governance` (module list can never be populated → every transfer passes the module layer), `ClaimTopicsRegistry.governance` (required set empty forever), `HoldingPeriodLock.aifm` (locks stay disabled), `NavBorrowingCap.fundType` (enum 0 = `EltifRetail` → a UCITS instance runs the 50% ELTIF rule), `SubscriptionEscrow.mode` (Exempt → no Art 12 / Art 6 gate), `finalPriceOmittedAtFiling` (window B never opens). `UPGRADE-ARCHITECTURE.md` never names which contracts are proxied. **D20 is unresolved on both sides and blocks any proxy deployment.**

---

# 4. Where the design doc is wrong (change the design, not the code)

1. **§8:1172 "release is immediate when no window is open"** — defeats Art 17(2)/23(2), which arise *after* acceptance. Needs an offer-close timestamp; settlement waits for it (H4).
2. **§5a row 867 / §17 row 1565** — Art 5 safe harbour applied to any "buy-back / redemption ROI" token; mar-checklist §2.1 is own shares, three purposes. Series Plan already flagged; not yet swept.
3. **§17b:1653 "C1 hook rejects on tier mismatch"** — no tier read exists in `checkEligible`; tier is read by escrow/covenants/settlement only. Blog M1:165 inherits.
4. **§3:436 / §4:466 "on-chain verification of the attestation signature"** — `setClaim` is an authorised-caller write; no signature is verified anywhere. Blog M2:146 inherits.
5. **§10:1314** still says the on-chain surface "carries only the wallet address, claim hashes and ZK attestations"; the `Investor` record holds `personType, tier, jurisdiction, lei, nationalClientIdHash, verifiedAt, expiresAt`. D21 is the honest state; the §10 paragraph is stale. Blog S4:48 inherits.
6. **§4:485 vs §4:499** — internal contradiction: "one generic code for the whole class incl. lapsed CDD, jurisdiction gate" vs "`RecordExpired` / `MissingRequiredClaim` legitimately stay typed". Code follows :499; `Interfaces.sol:93-95` and blog M1:39 follow :485. Pick one.
7. **§4a:643 vs §17:1548 / :2132** — covenant revert generic (`Blocked()`) vs Article-named adapter errors. Code took generic; the NatSpec's Art 76 rationale does not describe a curable, non-suspicion block.
8. **D20:1501 / rev 42 "PdmrRegister's uncorrectable running total"** — the contract explicitly refuses the Art 19(1a) aggregation (:37-44). The control described does not exist.
9. **§17a note 3:1616** "Art 49(2) is a transfer-hook control" contradicts §5 gate (c), §11 and §17:1551.
10. **§9 / §17:1566 / `UPGRADE-ARCHITECTURE.md:253`** name a protocol pause that "halts the modules that read it" — no module reads it (H7b). Either wire `paused()` into the fund modules' active paths and the token, or stop claiming a trip.
11. **§17b Art 17(1a) "on-chain: None", Art 18 "no anchoring contract"** vs `DocumentRegistry.anchorConcealed` and blog M4 §7. Specify it or delete it.
12. **Design §5a:840 "typically in a stablecoin"**; `DistributionAgent` and `SubscriptionEscrow` are native-ETH only. D6 has no code on any leg; review finding 1.12 (Travel Rule) is unreachable rather than unresolved.
13. **§3 rev 40 entry "every dependency interface-typed and settable, two exceptions"** — see §3 table above.
14. Housekeeping: header line 43 and :368 still "six capabilities"; §3 C5 row still lists "sanctions freezes" post-rev 48 (Series Plan already logged both).

---

# 5. Where the blogs are wrong

| Article | Claim | Reality |
|---|---|---|
| **P0** :69 "No custom contract sits on the upgrade path" | `DoraGovernor.executeUpgrade` does until stripped (H7a) |
| **P0** :78, **M2** :106, :110 "the token reads [the store] above the module list"; "forced transfer runs the transfer gate" | True for `_move`; false for `forcedTransfer` (H1) |
| **M1** :39 "Sanctions freeze, lapsed due diligence, suspicion block, jurisdiction gate — all return the same `TRANSFER_NOT_PERMITTED`" | Lapsed CDD → `RecordExpired(wallet, expiredAt)`; jurisdiction → `MissingRequiredClaim(wallet, topic)` |
| **M1** :165 "tier … on the transfer hook" | Tier is never read by the hook |
| **M2** :146 attestation signature verified on-chain | Nothing verifies a signature |
| **M2** :72, **M1** :53 "the eligibility claim carries a validity window" | Optional per write; `expiresAt = 0` = never (M-T6) |
| **M3** :98 "`mayUpgradeTier()` refuses without it"; §5 rule 4 recommends the opt-up covenant | `IdentityRegistry` never calls it; the recommended configuration triggers H2 |
| **M3** :114 back-record "through `recordAttestation()`" | Impossible for `InvestorSignature` entries (:451) |
| **M4** :102 "overdue review … the subscription path stops accepting retail investors" | Escrow reads `currentVersionHash`, never `isCurrent`; the block lives on a token mint the escrow does not perform |
| **S1** :37, :128 subscribe "mints into a pending, non-transferable state"; `withdrawAcceptance()` "burns the tokens" | No token is touched (M-D2) |
| **Pure Issuer** :104, :127-129 "the upgrade function requires a disclosure-artefact hash… reverts" | Rev-46-withdrawn gate; only true of stale `DoraGovernor` |
| **Pure Issuer** :78, :147 "approved country list" | No country list exists; any non-zero jurisdiction passes |
| **Pure Issuer** :92 Window B "two working days" vs **S1** :174 "three" | Code default 3, and it is unread (M-D3) |
| **S2** :135, :200 "`LmtGate` takes the forecast as a fed input… Redemption cap enforced" | **False** — ELTIF RTS Art 5(5)–(6) is open per `LmtGate.sol:28-35` and REMAINING-COMPLIANCE §8. Highest-risk claim in the family. |
| **S2** :82 "20% per single non-UCITS fund"; :87 "configured limit set + Art 54 governance flag"; :195 "six counters"; :197 "commitment denominator"; :116 "remediation clock"; :117 "six months from authorization"; :129 three selection constraints "bind either way" | 10% for all; hard constants; five counters; divides by `nav()`; only `startedAt` stored; from deployment; ≥2 only |
| **S3** :70, **M5** §9 "relationships never go on-chain" | `WalletDeclared` indexes `pdmrId` + `role` permanently (M-E6) |
| **S3** :§3 "`grantPermission()` is governance-gated" | `onlyIssuer` |
| **S3** §10, **M5** §8 issuer-lane order-lifecycle surface / `checkIssuerMaySell()` "is what the sale path reads" | Not implemented in the issuer lane; read by nothing (M-E9) |
| **M5** §2 "AMLR Arts 21, 75" | Code comment still Arts 20/75 (`DistributionAgent.sol:348-349`) |
| **Series Plan** :66 "1.1, 1.10, 1.11 already implemented" | 1.1, 1.11 yes; 1.10 is a citation fix the code has not taken |
| **PARKED Venue Lane** :5 "None of that content is wrong" | See the parked-lane items above |

---

# 6. Tracker staleness

- `REMAINING-COMPLIANCE.md` frontmatter: "26 .sol files", status rev 36. Folder: 28 files / 30 contracts; design at rev 49. §3 still says "GDPR: Nothing personal on-chain" (withdrawn at rev 43) and "Venue: … done", "Trading: … done" (both parked). §9 #5 claims the auto-trip closed (H7b). §8 "widen the band and let sources repost" describes a path that does nothing while halted (`ValuationOracle.sol:360` returns before `_tryAccept`).
- `DEPLOYMENT-DEFAULTS.md`: has the five rev-48 items; missing the Art 11 Safe-composition rule (`UPGRADE-ARCHITECTURE.md:71-73` says it must be mirrored), any Safe/Timelock/ProxyAdmin wiring, `setOracleTripSource` / `setCircuitBreaker`, `DocumentRegistry`/`SubscriptionEscrow` in the wiring order, and a role-grant section.
- Series Plan §3 matrix: `RestrictedPartyRegistry` / `RestrictedPartyGate` rows still missing (already logged there).

---

# 7. Known Dev/ items from the rev 36–49 log — status

| Item | Status |
|---|---|
| Rev 44 events publish PII | **Fixed** — `InvestorRegistered(wallet)`, `InvestorUpdated(wallet)`, `IdentifierBound(wallet, lei)`; `lei` only for legal persons. `ClaimSet(wallet, issuer)` indexes the issuer — a vendor-specific issuer key still tells which vendor wrote against the wallet. |
| Rev 44 erasure | **Fixed inside IdentityRegistry** (per-person wallet index, claim-topic worklist, backwards pop). Survivors elsewhere: `RestrictedPartyRegistry._blockedRecords/_blockedWallets` (caseRef + since), `HoldingPeriodLock.subscribedAt`, `PdmrRegister._walletsOfPerson`, balances/`frozenUnits`. |
| Rev 45 `recordPointerOf` | Fixed |
| Rev 48 one-store consolidation, three `setRestrictions`, same error both paths, mandatory-layer read in `_move` and `DistributionAgent._gate` | Fixed — except `forcedTransfer` (H1) |
| Rev 45/48 permitted-destination sender-limb only; staleness blocks mint only | Fixed (but the carve-out also relieves *voluntary* transfers out of a restricted wallet, `SecurityToken` :447 runs on every path — LOW) |
| Rev 46 `DoraGovernor` sweep | **Open** (H7a) |
| Rev 47 UPGRADE-ARCHITECTURE Art 11 rule, which-document table, Art 23 bound; DocumentRegistry `approvedAt` NatSpec | Fixed |
| Rev 49 `subscribe()` never reads `approvedAt` | **Open** |
| Rev 49 two `SupplementPublished` signatures | **Open** — different topic0 so ABI-decoding is safe; a name-keyed subgraph handler collides, and the reconciliation join the escrow NatSpec prescribes is the query most likely written by name |
| REMAINING-COMPLIANCE §5 fixes 1–4 | #1 topic 8 retired (comment-only, M-T7); #2 DoraGovernor local `IDocumentRegistry` **still there**; #3 multi-jurisdiction fail-closed present but flag-dependent (`needsMultiJurisdiction` set by the configurer, nothing derives it); #4 SiQuoteEngine still needs viaIR |
| REMAINING-COMPLIANCE §5 "fifth" (module classification / Art 76 NatSpec) | **Open** (M-T5) |
| Rev 35 oracle hardening (7 items) | All present in `ValuationOracle.sol` — verified line by line |
| Rev 36 adapters, `SubscriptionEscrow → DocumentRegistry`, `tripFromOracle`, no fund adapters | Present; `tripFromOracle` reaches nothing (H7b) |
| `LmtGate` ≠ ELTIF RTS Art 5(5)–(6) | Still open, header says so |

---

# 8. Recommended fix order

1. **H1** — add `restrictions.assertTransferPermitted(from, to)` to `forcedTransfer` (the permitted-destination carve-out already relieves the sender limb, so the seizure path still works). One line; the whole rev-48 argument rests on it.
2. **H3, H2** — `CovenantGate`: skip the zero leg on burn (match the other adapters); `effectiveTier`: evaluate the opt-up covenant with the *raw* tier, not `effectiveTier`.
3. **H4 + rev-49 open item** — escrow: add `offerClosesAt`; `settle` waits for it; `subscribe` requires `documentStatus(...).approvedAt != 0` and runs the prospectus validity from it; add `checkEligible` + `isBlocked` on `subscribe`; decide whether the escrow mints (design says yes; code says no) and make design, code and S1/Pure Issuer agree.
4. **H5, H6, H8** — fund sync: persist classification at trade time and strip the flags from sync; record `acceptedAt` absorbed; require sync-currency on the active path.
5. **H7** — strip `DoraGovernor` to pause + incidents + key rotation + `tripFromOracle`; then either wire `paused()` into the fund modules' active paths and `SecurityToken._check`, or delete the trip and stop claiming it. Rewrite its NatSpec off the rev-49 inversion.
6. **H9, M-F1..F8** — fund modules second pass against the checklists (band membership set, zero-NAV revert, pro-rata LMT, suspension scope, ramp-up start date, key rotation).
7. Reference discipline sweep (§3 table) and a single decision on D20 (which contracts are proxied). Until D20 is decided, no proxy deployment.
8. `BuybackAgent` instrument gate; `PdmrRegister` / `PdmrClosedPeriodFreeze` event and cancel hardening (D22 decision).
9. Then re-sync: `REMAINING-COMPLIANCE.md` to rev 49; the design §4/§8/§17b points in section 4; S1, S2, M1–M5, P0 and Pure Issuer per section 5 before any of them publishes.

**Not reviewed:** gas at scale (no holder-set enumeration exists — DistributionAgent uses Merkle proofs, so payouts page naturally); economic/game-theory attacks on the oracle beyond the even-quorum note; national-law layer (out of scope by design).
