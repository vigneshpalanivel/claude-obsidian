---
title: ERC-3643 Conformance & Deviation Register — EU-RWA-Contracts
date: 2026-09-11
status: derived from the 31 .sol files in this folder + §3a–§3d of eu_tokenized_securities_smart_contract_design.md (rev 54)
scope: licence provenance, conformance grade per interface, every declared deviation, every residual
---

# ERC-3643 Conformance & Deviation Register

**This file is a deliverable, not a comment.** Seventeen NatSpec blocks across six contracts point
at it, and the conformance test suite (§13 of the design) fails when a member of the EIP set is
absent or altered and **not listed here**. A deviation that is not in this file is a defect,
whether or not the code is right.

Read it before writing "ERC-3643" in anything an NCA, an investor or a venue sees.

---

## 1. The licence firewall — the EIP is not the codebase

**The rule, and it is absolute:**

1. **EIP-3643 is a specification.** Implementing a specification creates no licence obligation.
   Concepts, interfaces, function names and semantics are not copyrightable.
2. **Tokeny's T-REX is an implementation of it, and it is GPL-3.0** (dual-licensed, with a
   proprietary option sold separately). ONCHAINID's Solidity implementation is likewise GPL-3.0.
3. **No T-REX or ONCHAINID source enters this suite, in whole or in part, ever** — not copied,
   not adapted, not "used as a reference while typing". Copying it would make a client's
   proprietary build a derivative work, and every engagement on this suite is permissive or
   proprietary.
4. Every file here carries `SPDX-License-Identifier: MIT` and imports nothing outside this folder.

**The line is source code, not vocabulary.** Naming a function `freezePartialTokens` because the
EIP names it that is conformance. Pasting T-REX's body into it is infringement. Writing
`interface ICompliance { function canTransfer(...) external view returns (bool); }` from the
specification text is fine; the same text arrived at by opening `T-REX/contracts/compliance/` is
not, even though the bytes match — provenance is the thing being tested, and it is not
recoverable from the diff.

**Enforcement is mechanical, not editorial.** CI must check three things, because a rule that
depends on a reviewer remembering it has already failed:

| Check | What it catches |
|---|---|
| SPDX header on every `.sol` is `MIT` | a GPL file arriving by copy-paste with its header intact |
| dependency allow-list — no package resolves to `@tokenY/*`, `@onchain-id/*` or T-REX | the same arriving through `package.json` |
| import graph is closed over this folder | a transitive pull nobody looked at |

**What closing D0 did NOT buy.** Stated because the opposite is the natural assumption:

- **No implementation is inherited.** Five of thirty-one contracts are standard-bound; all five
  are written here. The other twenty-six are unchanged by the decision.
- **No compliance obligation moved.** MiFID II, Prospectus, AMLR, DLT Pilot, DORA, GDPR — the
  standard addresses none of them. `ModularCompliance` still holds every Article.
- **No identity model was decided.** §16 D19 is open. See §4.2 below.
- **No GDPR question was answered.** §16 D21 is open, and the standard pushes it the wrong way.
  See §4.3 and §5.1.

---

## 2. Conformance grade, per interface

| Interface | Implemented by | Grade | Deviations |
|---|---|---|---|
| `IERC3643` | `SecurityToken` | **full** | — |
| `ICompliance` | `ModularCompliance` | **full signature, 2 semantic** | D-C1, D-C2 |
| `ITrustedIssuersRegistry` | `TrustedIssuersRegistry` | **full signature, 2 semantic** | D-T1, D-T2 |
| `IClaimTopicsRegistry` | `ClaimTopicsRegistry` | **full signature, 1 semantic** | D-K1 |
| `IIdentityRegistry` | `IdentityRegistry` | **declared deviation** | D-I1 … D-I5 |
| `IIdentity` | *nothing* | **not implemented** | D-I2 (§16 D19 open) |

Every one of those contracts carries `is <Interface>` in its declaration. That is load-bearing:
it makes the **compiler**, not a reviewer, check that every function and event is present with
the exact signature. A conformance suite that only reads source can be satisfied by a lookalike;
inheritance cannot.

### The claim you may make

> "The token implements the ERC-3643 (EIP-3643) interface. The identity registry carries declared
> deviations, listed in the issuer's conformance register."

### The claim you may not make

> ~~"ERC-3643 compliant."~~

Unqualified, and anywhere an NCA or an investor reads it. **The token standard is a Prospectus
Art 6 / Art 16(1) content item**, so an overstated conformance claim is a defect in a disclosure
document — an Art 23 supplement with a withdrawal window, not a README correction.

---

## 3. Capability → standard binding

The §3 capability set is what the suite owes. The standard delivers some of it.

| | Capability | Binds? | Standard member |
|---|---|---|---|
| C1 | transfer pre-validation | ✅ | `ICompliance.canTransfer` |
| C2 | identity binding | ⚠️ deviation | `IIdentityRegistry` |
| C3 | trusted issuers + revocable claims | ✅ | `ITrustedIssuersRegistry`, `IClaimTopicsRegistry` |
| C4 | rule modularity | ✅ | `ICompliance`, `setCompliance` |
| C5 | freeze / forced transfer / recovery | ✅ | `setAddressFrozen`, `freezePartialTokens`, `forcedTransfer`, `recoveryAddress`, `pause` |
| C6 | partitions / tranches | ❌ | none — custom (`DistributionWaterfall`) |
| C7 | investor covenants | ❌ | none — custom (`CovenantRegistry`) |
| — | document anchoring | ❌ | none — custom (`DocumentRegistry`); ERC-1643 is a separate standard |

**C1's best property came free.** `canTransfer` returns a **bool**, with no reason attached and
no room to attach one. That is exactly what AMLR Art 76 (tipping-off) demands of a stop linked to
a specific person's eligibility — and here the *interface* enforces it rather than a review
convention. `SecurityToken._assertCompliant` treats the boolean as authoritative and falls back
to `IComplianceGate.checkTransfer` only to recover a reason, and only where the failing module's
class permits one.

**C6 is the largest custom component and the standard does not touch it.** Under ERC-1400,
partitions would have come free from ERC-1410. A reader who assumes ERC-3643 delivered the §5 and
§8 machinery under-scopes the build by its biggest piece. **This token is ERC-3643-BASED, not
ERC-3643-ONLY.**

---

## 4. Declared deviations

Each has an id, a statement of what the standard says, what this suite does, and why. The
"why" is the part a reviewer is entitled to and the part that cannot be reconstructed from code.

### 4.1 `ICompliance` — `ModularCompliance`

**D-C1 — `bindToken` is one-shot; `unbindToken` always reverts.**

- *Standard:* the compliance contract is rebindable.
- *Here:* `bindToken` fires once and `unbindToken` reverts `UnbindNotSupported()`.
- *Why:* the modules behind this contract hold running, Article-mapped state — concentration
  denominators, holding clocks, cap registers — that only means anything against **one**
  instrument's history. Unbind → rebind presents a second instrument with the first one's
  counters: a breach that reports clean, or a clean position that reports as a breach. Neither is
  recoverable from the logs afterwards.
- *Supported route:* `SecurityToken.setCompliance` pointed at a **fresh** `ModularCompliance`.
  One governance act, emits `ComplianceAdded` on the token, leaves the old contract's history
  intact.
- *Consequence:* `TokenUnbound` is declared and **never emitted**.

**D-C2 — the post-trade trio and `notifyTransfer` are one fan-out behind two faces.**

- *Standard:* the token calls `transferred` / `created` / `destroyed`.
- *Here:* it does exactly that. `notifyTransfer` (the suite's flat form, mint as `from == 0`)
  survives as the internal fan-out and is **not** called by the token.
- *Why:* a caller that invokes both double-advances every counter-keeping module.
  `EltifConcentration` would book each transfer twice and report a breach that never happened.
  A draft of `SecurityToken._notify` called both, on the reasoning that the two faces were
  different contracts' concerns; they are not. **Recorded because the bug was reasoned into
  existence, not typed into it.**

### 4.2 `IIdentityRegistry` — `IdentityRegistry`

This is the one interface graded **declared deviation** rather than full.

**The three collisions, and only one of them resolves.** The distinction that does the work is
**storage versus interface**:

| | Collision | Status |
|---|---|---|
| 1 | the standard's registry is **wallet-keyed**; this design is **person-keyed** | ✅ **resolves** |
| 2 | the standard expects a per-investor **`IIdentity` contract** | ❌ does not resolve — §16 D19 |
| 3 | the standard mandates an on-chain **`uint16` ISO-3166 country** | ❌ does not resolve — §16 D21 |

**Collision 1 resolves** because rev 53's re-key was about where attributes are *stored*, never
about the shape of a read. A wallet-keyed *interface* over person-keyed *storage* is faithful:
every EIP read resolves `wallet → personId → attribute`. What the standard cannot express — two
wallets of one person disagreeing — is here **unrepresentable** rather than merely checked, which
is stronger than conformance, not weaker. `PersonAttributesMismatch` guards the write paths where
divergence could be introduced.

**D-I1 — `registerIdentity` binds a wallet to an existing person; it does not create one.**

- *Standard:* wallet + country + identity → a registration. No person anywhere.
- *Here:* the identity handle is resolved to a `personId`; `_country` must **agree** with the
  person's stored jurisdiction or it reverts `PersonAttributesMismatch`; the wallet is bound.
  An unknown handle reverts `UnknownIdentity`, an unmapped country reverts `UnknownCountryCode`.
- *Why:* implemented literally it writes a country **per wallet**, and one person's two wallets
  can again read FR/Retail and DE/PerSeProfessional. That is directly monetisable twice over —
  subscribe from whichever wallet's Member State still has **Prospectus Art 3(2)** headroom, or
  from whichever reads as qualified and skip the **Art 1(4)(b)** 149-person headcount. This is
  the exact defect rev 53 closed, and a conformant `registerIdentity` re-opens it.
- *Note on `_country`:* checked, never written. Accepting and discarding it would let a caller
  believe they had set something the gates do not read; accepting and writing it is the defect.
  Agreement is the only safe third option.

**D-I2 — `identity()` returns a non-dereferenceable handle, not a contract.** *(§16 D19 — OPEN)*

- *Standard:* a deployed per-investor `IIdentity` contract. The EIP states a conforming token
  "MUST be used in combination with an onchain Identity system."
- *Here:* option **(c)** — `address(uint160(uint256(personId)))`. Stable per person, comparable,
  never callable.
- *Why not option (a) (a real contract):* **a deployed per-investor identity contract is a
  persistent, unique, on-chain identifier bound to an identified natural person, and it cannot be
  erased.** The suite discharges GDPR Art 17 by deleting the off-chain record and orphaning an
  on-chain anchor (`PersonErasure`); a deployed contract — storage *and* CREATE2 address — does
  not degrade that way. Second limb: an identity reused across issuers correlates one investor
  across every platform they touch. That is a commercial feature of the model and a
  data-protection problem.
- *Why not option (b) (`address(0)`):* cheapest and least honest — a conformant signature over an
  absent capability. **If chosen it must be disclosed in the prospectus, not defaulted into.**
- *Status:* **(c) is provisional and reversible.** Nothing in the suite dereferences the result;
  switching to (a) changes `identity()` and the population of `_personIdOfHandle`, nothing else.
  **This is a data-protection decision before it is an engineering one. Do not resolve it by
  writing code.** DPO sign-off and a DPIA entry are prerequisites either way.
- *Known break:* a venue whose tooling **dereferences** the result breaks against us. That is a
  disclosure item, and the loudness of the failure is why (c) was preferred to (b).
- *Also:* `IIdentity` as declared in `IERC3643.sol` is **deliberately not ERC-734/ERC-735**.
  Those were never merged as EIPs — abandoned 2017 proposals, a fact Tokeny's own published audit
  records. Transcribing a withdrawn draft to look more standard would be conformance theatre.

**D-I3 — `updateIdentity` always reverts.**

- *Standard:* "this investor's identity contract address changed" — a redeploy of their ONCHAINID.
- *Here:* reverts `IdentityRebindingNotSupported()`.
- *Why:* the handle is derived from `personId` and cannot change for a given person, so the event
  the standard describes cannot occur. The *other* reading — re-point a wallet at whatever person
  the new handle resolves to — changes that wallet's jurisdiction, tier, claims and Art 1(4)(b)
  headcount unit in one call, under a name whose EIP meaning is "nothing about the person
  changed". **Two divergent meanings behind one selector is a trap.** Supported route:
  `unbindWallet` then `bindWallet` — two acts, because it is two acts.
- *Consequence:* `IdentityUpdated` is declared and **never emitted**.

**D-I4 — `updateCountry` moves every wallet the person holds.**

- *Standard:* keyed on a wallet.
- *Here:* resolves to the person and changes the single stored jurisdiction.
  `_emitCountryUpdated` then fans `CountryUpdated` out across the person's whole wallet set.
- *Why:* residence is an answer about a person; a second address does not give someone a second
  country. Emitting for one wallet only would leave a listener believing the others still hold
  the old code — the divergence made unrepresentable in storage, reintroduced in the log.

**D-I5 — no `IdentityRegistryStorage`; `IdentityStorageSet` never emitted.**

- *Standard:* an optional storage contract shared across tokens.
- *Why not:* sharing one person register across issuers is the **linkability limb of D19**, not an
  optimisation. The event is declared and dead.

**`deleteIdentity` is not an erasure.** It deletes a *pointer* — one wallet binding — and leaves
every personal attribute, because the person is still a client and this is the compromised-key
operation. GDPR Art 17 is `erasePerson`, which is deliberately **not reachable** from the
standard's surface. The EIP's signature also has no room for a `reasonHash`, so this passes zero;
prefer `unbindWallet`.

### 4.3 `ITrustedIssuersRegistry` — `TrustedIssuersRegistry`

**D-T1 — `removeTrustedIssuer` revokes retroactively; it does not delete.**

- *Here:* `isTrustedIssuer` goes false, `getTrustedIssuers()` drops the issuer, every claim it
  ever wrote stops counting — the EIP's reading, delivered. The **record survives**.
- *Why:* a deleted issuer has no revocation timestamp, and without one nobody can afterwards
  evaluate a claim it wrote — including the operator reconstructing, for an NCA, why a transfer in
  2027 was permitted. `getTrustedIssuers()` honours the standard; `issuerList()` is the full
  history and is the audit surface.
- *Why retroactive and not prospective:* removal through the EIP's surface carries no reason, and
  an unexplained withdrawal of trust is the case where grandfathering past attestations is least
  defensible. Where past work **is** still good, `revokeProspectively` says so on the record.
- *Log note:* both revocation shapes emit `TrustedIssuerRemoved`, because under the standard's
  reading the issuer has left `getTrustedIssuers()` in both cases — which is true. A listener
  reading only EIP events **cannot tell the two shapes apart**; `IssuerRevoked` carries the
  `retroactive` flag and is the event that can.

**D-T2 — `addTrustedIssuer` registers with an empty eIDAS anchor.**

- *Why:* the EIP's signature has no field for `qtspIdentifier`.
- *Consequence:* an issuer with a zero anchor **cannot be reconciled against the published EU
  Trusted List**, which is the whole reason this is a registry rather than a signer address. A
  zero anchor is a **deployment defect, not a supported state**; `issuers(addr).qtspIdentifier`
  is public and is what a reviewer greps for.
- *Supported route:* `registerIssuer` (which takes the anchor), or `addTrustedIssuer` followed by
  `setQtspIdentifier` in the same governance batch.
- *Related:* the EIP types issuers as `IClaimIssuer`, a **contract**. This suite does not require
  one — every issuer is an address that signs off-chain, the parameters are typed for signature
  conformance only, and nothing calls `isClaimValid`. Per-provider claim-issuer contracts are the
  ONCHAINID shape and are part of D19.

### 4.4 `IClaimTopicsRegistry` — `ClaimTopicsRegistry`

**D-K1 — `getClaimTopics()` returns the baseline tier only, and therefore understates.**

- *Standard:* one global list.
- *Here:* a baseline set plus a per-jurisdiction **additional** set, unioned and never
  substituted. `addClaimTopic` / `removeClaimTopic` / `getClaimTopics` address the **baseline**.
- *Consequence and the reason this one is flagged loudest:* **a holder in a jurisdiction with
  additional topics must satisfy more than `getClaimTopics()` reports.** A caller that treats
  that array as the admission test builds a UI that clears an investor the registry will refuse.
  `requiredTopics(jurisdiction)` is the real answer and is what `IdentityRegistry` reads.
- *Why it cannot be designed away:* collapsing to one global list either under-requires every
  Member State to the loosest one's set, or imposes one State's additions on holders everywhere.
  EU rules are not uniform; the standard predates that constraint rather than rejecting it.
- *Log note:* per-jurisdiction additions deliberately do **not** emit `ClaimTopicAdded` — the
  standard's event has no jurisdiction field, so emitting it would announce a global requirement
  that does not exist and every listener would over-require every holder. Silence under-reports
  and is recoverable from `AdditionalTopicAdded`; a wrong topic id over-reports and is not.

---

## 5. Residuals — conformance costs that are not mitigated

A residual is different from a deviation. A deviation is somewhere the suite declined to follow
the standard. **A residual is somewhere it followed the standard and paid for it.** These are
listed so the DPIA and the prospectus can carry them, not because a code change is pending.

### 5.1 `setAddressFrozen` rebuilds the two-store observability leak

`IERC3643` requires `setAddressFrozen(address, bool)` and `isFrozen(address)`, so `SecurityToken`
now carries a **public, wallet-keyed, whole-address stop** — the exact shape
`RestrictedPartyRegistry` was consolidated to be the only instance of. Not negotiable: the
function is in the interface and the compiler checks.

*Mitigated:* the revert is `AddressIsFrozen()` — argument-free, generic-class, and the **same
error for both sides**, because naming the side is the disclosure (AMLR Art 76).
`AddressFrozenReason` carries a `reasonHash`, never a reason. NatSpec on both contracts states
that `setAddressFrozen` is the **operational** stop and that sanctions or suspicion belongs in the
person-keyed store.

*Not mitigated:* `isFrozen(wallet)` is a public boolean anyone can call, per wallet, and a wallet
frozen for one reason is indistinguishable from one frozen for another. A person-keyed listing
follows the human across every address; a wallet freeze does not, so freezing "the investor"
means freezing each address and each one is separately observable. **Operational rule, no on-chain
enforcement.** This sits alongside the pre-existing `freezePartialTokens` leak
(`REMAINING-COMPLIANCE.md` §5 item 1) and is the worse of the two.

### 5.2 `recoveryAddress`'s third parameter

`recoveryAddress(address lostWallet, address newWallet, address investorOnchainID)` puts a
**second per-person identifier in the calldata** of the suite's one deliberate privacy exception.
Implemented as a **consistency check only** — never used as authority, `address(0)` accepted —
but the parameter and the `RecoverySuccess` event both carry it. `RecoverySuccess` therefore adds
a **third identifier** to a log about an identified person.

**Open question for the DPO**, not a solved problem.

### 5.3 EIP events make the person → wallets join computable from logs

`IdentityRegistered` / `IdentityRemoved` carry a wallet and the identity handle, and the handle is
derived from `personId`. The suite's own events were written to carry **a wallet and nothing
else**, precisely so that a stable per-person identifier never reached a log — where `delete`
cannot go and every archive node keeps it forever (GDPR Recital 26; `erasePerson` is complete as
to storage and silent as to history).

Tolerable **only** because the handle is a truncation and not invertible to the `personId`, and
because `personIdOf(wallet)` was already a public read — so the join was computable by contract
call before this existed. What changed is that it is now computable **from logs alone**.
Residual, not solved.

### 5.4 `investorCountry` is an on-chain datum no gate reads

`IdentityRegistry.investorCountry` and the `numericOfJurisdiction` / `jurisdictionOfNumeric`
register exist **because the standard demands `uint16` and for no other reason**. No `require` or
`revert` in this suite reads them.

That is the **§11 on-chain test failing on the standard's authority rather than the design's** —
the standing rule is that compliance data goes on-chain only where a gate reads it. **§16 D21 is
open**: whether an on-chain country code survives GDPR Art 5(1)(c) minimisation. The standard
answers yes by making it mandatory; the design has not conceded the point.

*Mitigated as far as it can be:* `Person.jurisdiction` (alpha-2) remains the **single source of
truth** and the numeric is **derived on read, never stored per person** — two copies of one
residence fact could drift, and a person reading FR in one and 276 in the other is an Art 3(2)
threshold counted against the wrong Member State. The table is governance-set and deliberately
**sparse**: populate only the Member States the programme admits. An exhaustive table would be an
on-chain dataset with no gating consumer, which is the same test failing again, harder.

---

## 6. The conformance test suite

Three tests, and the second is the one usually forgotten.

1. **Selector-level signature test.** For every member of `IERC3643`, `ICompliance`,
   `IIdentityRegistry`, `ITrustedIssuersRegistry` and `IClaimTopicsRegistry`: assert the selector
   is present on the deployed contract. `is <Interface>` already makes the compiler check this;
   the test catches a deployment wired to the wrong address.
2. **Undeclared-deviation test.** Fail when a member of the EIP set is **absent or altered and not
   listed in this file**. Parse the deviation ids out of §4 and reconcile. Without this, §4 rots
   silently and the register becomes a historical document.
3. **CI licence-provenance check.** The three mechanical checks in §1.

And the standing one, which predates all of this:

4. **Standard-independence check.** Nothing in §4–§10 of the design moved when the standard was
   fixed. A rule that appears or disappears in this suite because of conformance is a defect.

### ⚠️ What has actually been run, as of 2026-09-11: none of the four

**This suite has not been compiled since the ERC-3643 pass.** No Solidity compiler is present in
the environment the edit was made in — `solc`, `solcjs` and `forge` are all absent. The earlier
"compiles clean (solc 0.8.22, optimizer, viaIR: 0 errors, 0 warnings)" statement in
`REMAINING-COMPLIANCE.md` is from **2026-09-08** and predates every change described in this file.
Do not carry it forward.

Two **mechanical substitutes** were run instead, and they are much weaker than a compile:

| Check | Method | Result |
|---|---|---|
| Brace/paren balance | comment- and string-aware scan over all 31 `.sol` files | balanced |
| EIP member reconciliation | parse the interfaces out of `IERC3643.sol`, resolve inherited members, diff against each implementing contract | **zero missing functions**; three never-emitted events — `TokenUnbound`, `IdentityStorageSet`, `IdentityUpdated`, all three declared-and-dead in §4 |

What those two checks **cannot** see, and what a compile is therefore still owed for: type
mismatches, visibility and mutability mismatches against the interface, missing `override`
specifiers, stack-too-deep, and every runtime behaviour. **Compile before this file is shown to
anyone outside the team, and re-run the four tests above before it is cited in a disclosure.**

---

## 7. Cross-references

| Where | What |
|---|---|
| `eu_tokenized_securities_smart_contract_design.md` §3a | capability → `IERC3643` binding |
| — §3b | what closing D0 did not buy |
| — §3c | licence firewall |
| — §3d | conformance grade and this register |
| — §13 | the test suite above |
| — §16 D0 (closed), D8, D19, D21 | the decisions behind §4.2 and §5.4 |
| `IERC3643.sol` | the interface set, with the provenance header |
| `REMAINING-COMPLIANCE.md` §5 | the pre-existing `freezePartialTokens` leak that §5.1 joins |
| `DEPLOYMENT-DEFAULTS.md` | wiring, including `setCountryCode` before any holder in a State |
