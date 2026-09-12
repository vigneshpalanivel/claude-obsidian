---
title: "Using ERC-3643 and ONCHAINID Without GPL-3.0"
type: concept
status: current
created: 2026-09-11
tags:
  - ERC-3643
  - ONCHAINID
  - GPL-3.0
  - licensing
  - security-token
  - tokenization
  - innblockchain
related:
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[GDPR-Regulation]]"
  - "[[Asset-Tokenization-RWA]]"
---

# Using ERC-3643 and ONCHAINID Without GPL-3.0

Reusable across projects. The question is always the same: *does someone else's source code end up inside mine?*

> **The one rule: copyleft follows source code, not vocabulary.** Implementing a published specification creates no licence obligation. Copying, importing or inheriting someone's implementation does.

---

## What is actually GPL-3.0

| Thing | Licence | Meaning |
|---|---|---|
| **EIP-3643** — the specification | None. It's a spec | Free to implement. Function names, parameter orders, event signatures **are** the standard |
| **T-REX** — Tokeny's implementation | **GPL-3.0** (they sell a proprietary alternative) | Copying it makes your build a derivative work |
| **ONCHAINID** — `onchain-id/solidity` | **GPL-3.0** | Same. Ships `factory/` and `proxy/` for per-user identity deployment |

ONCHAINID implements **ERC-734/ERC-735, which were never merged as EIPs** — abandoned 2017 drafts. So adopting it buys no standards conformance beyond what EIP-3643 itself requires.

---

## Does GPL apply? The decision table

| What you do | GPL reaches your contracts? |
|---|---|
| Write your own contracts from the EIP text | **No.** This is what conformance means |
| Declare your own `IIdentity` / `IERC3643` interface | **No.** An interface you wrote is yours |
| Call a deployed ONCHAINID by address through your interface | **No.** Interoperation, not linking |
| Deploy their contracts **unmodified** | **No** — for your code. Their deployed code stays GPL; satisfied by keeping notices and pointing at the public repo |
| `import` / inherit / copy any of their `.sol` | **Yes.** That compilation unit is a derivative work |
| Modify their `.sol` at all | **Yes.** Including gas tweaks and extra fields |

---

## The trap: the factory

If you deploy one identity per user, the naive way is a factory that does `import "Identity.sol"; new Identity(...)`. **That pulls their source into your compilation unit — your factory becomes GPL.**

Avoid it by using their shipped `factory/` + `proxy/` contracts (deploy `IdFactory`, call it), or deploying bytecode from off-chain. Your registry then calls the resulting address through your own interface.

---

## Enforce it mechanically, not by policy

One convenience copy-paste by one engineer under deadline is the entire exposure. A wiki page does not stop that.

1. **Per-file SPDX header** (`// SPDX-License-Identifier: MIT`)
2. **Dependency allow-list** — CI fails on `@tokenY/*`, `@onchain-id/*`, any T-REX path
3. **Closed import graph** — no import resolves outside your own tree
4. **Per-file provenance** — *"written from EIP-3643, no third-party copyleft"* must be evidenceable for the audit

The difference that matters: *"don't import it"* is a build failure. *"Interoperate at arm's length"* is an argument you must keep winning.

---

## What you may claim

Never *"fully ERC-3643 compliant"* unqualified if any surface deviates. Where the standard appears in a prospectus it is a disclosure content item, so an overstatement is a defect in a disclosure document — not a code-review nit.

The safe form names the interface implemented and lists deviations in a conformance register published with the audit.

---

## ⚠️ Licence is the easy part

Two problems no licence strategy touches, both live whether you use ONCHAINID or your own code:

- **Erasure.** A per-person identity contract is a persistent on-chain identifier bound to an identified natural person, and it cannot be deleted. ONCHAINID's own erasure story is an off-chain database delete — and `Identity.sol` has **no `selfdestruct`**, while `removeClaim` emits the claim hash and off-chain URI to a permanent log on its way out. Clearing claims is the ceiling. *(Verified from source, 2026-09-09.)*
- **Linkability.** One identity reused across issuers correlates that investor across every platform they touch. That's the product's selling point and the data-protection problem, and you cannot take one without the other.

Both are DPO decisions, not counsel's. Do not settle them by writing code.
