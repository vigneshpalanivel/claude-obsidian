---
title: Upgrade Architecture — EU-RWA-Contracts
date: 2026-09-08
status: design for the shared upgrade stack; supersedes the upgrade limb of DoraGovernor.sol
scope: Gnosis Safe + OpenZeppelin TimelockController + ProxyAdmin + TransparentUpgradeableProxy. No custom contracts.
---

# Upgrade Architecture

One upgrade path for every contract in this suite, whatever regime the client owes.

**There is no custom code here.** Everything is OpenZeppelin and Safe, deployed unmodified. What
this document adds is the wiring, one convention, and four operating rules that replace things the
contracts deliberately do not do.

---

## 1. The stack

```
Safe (M-of-N)  →  TimelockController  →  ProxyAdmin  →  TransparentUpgradeableProxy  →  implementation
```

Each box takes orders only from the box on its left. Break a link and everything to its right is
unreachable.

| Box | Job | Source |
|---|---|---|
| Safe | humans sign off, M-of-N | Safe |
| `TimelockController` | holds the queue, refuses early execution | OpenZeppelin |
| `ProxyAdmin` | flips the proxy to a new implementation | OpenZeppelin |
| `TransparentUpgradeableProxy` | the address everyone else uses; never changes | OpenZeppelin |

---

## 2. Roles

| Role | Granted to | Never granted to |
|---|---|---|
| `PROPOSER_ROLE` | the Safe | an EOA |
| `EXECUTOR_ROLE` | the Safe, plus an optional ops relayer | `address(0)` |
| `CANCELLER_ROLE` | the Safe **and** every guardian, directly | — |
| `DEFAULT_ADMIN_ROLE` | nobody, after bootstrap | anyone, permanently |
| `ProxyAdmin` owner | the `TimelockController` | the Safe, an EOA |

⚠️ **`DEFAULT_ADMIN_ROLE` must be renounced.** Until it is, the deployer holds a no-delay path to
every proxy — it can grant itself `PROPOSER_ROLE` and skip the wait entirely. That role *is* the
control.

⚠️ **`EXECUTOR_ROLE` must not go to `address(0)`.** OZ reads the zero address as "anyone may
execute", and it is the configuration most tutorials show. Open execution means a stranger can land
an operation the Safe was still thinking about cancelling.

⚠️ **`CANCELLER_ROLE` goes to guardians directly.** That is the guardian's whole power in this
design, and it is a real one: the Safe cannot take it back without scheduling the revocation, which
means a delay, in public, in front of the guardian who can cancel that too.

⚠️ **`ProxyAdmin`'s owner is the timelock, never the Safe.** Pointing it at the Safe removes the
delay from the upgrade path completely.

⚠️ **The Safe signer set is not the responsible-persons set, and Prospectus Art 11 makes that a
composition rule, not a preference.** Art 11(1) names specific persons — with a function and a
registered address — in the prospectus, and Art 11(2) attaches **civil liability** to them for
information that turns out inaccurate or misleading. The prospectus describes this contract's
behaviour. So if a signing quorum reachable **without** any named responsible person can schedule an
upgrade that moves deployed behaviour away from disclosed behaviour, **those persons carry personal
liability for a change they did not authorise.** Fix it in one of two places, and record which:

- make the threshold unsatisfiable without at least one named responsible person, **or**
- give every named responsible person `CANCELLER_ROLE` directly.

Neither is a contract feature. Both are deployment configuration, and belong in
`DEPLOYMENT-DEFAULTS.md` next to the role grants.

---

## 3. The convention: the document hash goes in the salt

`schedule(target, value, data, predecessor, salt, delay)` — the `salt` is an arbitrary `bytes32` you
have to pass anyway. **Put the anchored document hash there.**

From OZ v5.6 `TimelockController.schedule`:

```solidity
emit CallScheduled(id, 0, target, value, data, predecessor, delay);
if (salt != bytes32(0)) {
    emit CallSalt(id, salt);      // ← the document hash, indexed by operation id
}
```

What that buys, for zero extra contracts:

- The document hash is **bound into the operation id**. It cannot be changed after scheduling, and
  executing with a different salt derives a different id the timelock does not recognise.
- `CallSalt` gives an on-chain, timestamped link between the upgrade and the document.
- Proving to an NCA that the supplement preceded the change is a log query, not a Confluence page.

⚠️ **This is detective, not preventive.** Nothing reverts. A signer can put a wrong or stale hash in
the salt and the timelock will not care. The control is the reconciliation job in §5, and a
reconciliation job with no owner is not a control.

⚠️ **Use a non-zero salt on every operation, even ones with no document.** A zero salt emits no
`CallSalt` at all, so "no event" is ambiguous between *no document needed* and *nobody bothered*.
Use a constant sentinel — `keccak256("NO_DISCLOSURE_REQUIRED")` — so the absence is stated rather
than inferred.

⚠️ **"Which document?" has four possible answers and one of them is *none*. Decide before
scheduling, not while drafting the release note.** The salt is one slot; the duty behind it is not
uniform:

| When | Duty | What goes in the salt |
|---|---|---|
| Between prospectus approval and the offer closing / trading starting, **whichever is later** | Prospectus **Art 23** supplement — NCA has 5 working days, then a 3-working-day withdrawal window opens | the supplement's version hash |
| Instrument admitted to trading, outside that window | **MAR Art 17** disclosure of inside information — no NCA pre-approval, but see §9's Art 17(1a) problem | the announcement's hash |
| ELTIF | **ELTIF Arts 23–24** — its own prospectus regime, distinct from the Prospectus Regulation | the ELTIF prospectus hash |
| Retail in scope | **PRIIPs KID**, Art 10 review cadence — re-anchors, but opens **no** withdrawal window | the KID version hash |
| Change is not material, or nothing above applies | none | `NO_DISCLOSURE_REQUIRED` |

⚠️ **Art 23 is the one people over-apply.** Its window **closes** at offer close or start of trading,
whichever is later. **Most upgrades in an instrument's life fall outside it** — they happen years
after the offer closed, and owe MAR Art 17 or nothing at all, not a 5-working-day NCA clock. A
rolling or reopened offer under a base prospectus re-enters the window each time, so the question is
**per offer, not per instrument**. Getting this wrong in the safe direction is expensive rather than
unsafe: it budgets weeks for releases that owe nothing.

---

## 4. Sequence

1. **Propose.** The Safe calls `schedule(...)`, with the document hash as the salt. **This is the
   approval moment** — the signers check the registry before signing.
2. **Wait.** The delay runs.
3. **Execute.** Someone with `EXECUTOR_ROLE` calls `execute(...)`.

⚠️ **Nothing happens automatically at the end of step 2.** A timelock is a floor, not a trigger.
`_schedule` writes one thing — `_timestamps[id] = block.timestamp + delay` — and after that moment
`getOperationState` reports `Ready` instead of `Waiting`. `Ready` means *allowed*, not *done*.
Smart contracts cannot self-schedule; somebody must send the transaction. **Put the execute step in
the release checklist**, or an approved upgrade sits there indefinitely looking like it is in
progress when it is stopped.

---

## 5. Four operating rules with no on-chain enforcement

Each replaces something the contracts deliberately do not do. All four need a named owner in the
resilience runbook.

**1. Reconcile `CallSalt` against the DocumentRegistry.** For every scheduled operation, check the
salt resolves to a document that `documentStatus` reports as anchored **and** approved. Alert
otherwise. This is the disclosure control. Nothing on-chain performs it.

**2. Cancel stale operations.** ⚠️ **A ready operation never expires.** Confirmed against OZ v5.6:
`getOperationState` has no upper bound, so an operation stays executable indefinitely until it is
executed or cancelled. An upgrade approved six months ago — against a document since superseded, an
implementation since replaced, by people who have since left — is still live and one transaction
away. Review the pending queue on a schedule and `cancel` what is dead.

**3. Re-check the document before executing, not just before scheduling.** The Safe's approval is
spent at step 1 and nothing re-reads anything at step 3. If a document is withdrawn during the
delay, the timelock will still execute. **The alert on withdrawal has to reach a guardian who
cancels**, because no contract will stop it.

**4. Watch the events.** `CallScheduled`, `CallSalt`, `CallExecuted`, `Cancelled`, `RoleGranted`,
`RoleRevoked`, `MinDelayChange`. A two-day delay nobody is watching is a two-day wait. `RoleGranted`
matters most: it is how a bypass gets installed.

---

## 6. Why there is no custom gate contract

Recorded so it is not re-litigated. A wrapper holding `PROPOSER_ROLE` that reads the
`DocumentRegistry` and reverts was designed, written and **rejected**. Three reasons:

1. **It proves less than it appears to.** It can check that *some* approved document exists. It
   cannot check that the document describes *this* change — that link is human judgement, and a
   rushed signer satisfies the gate by pointing at last month's approved supplement. It stops
   forgetting, not rushing.
2. **It is silently bypassable.** Grant `PROPOSER_ROLE` to the Safe "as a fallback", or
   `EXECUTOR_ROLE` to `address(0)` following a tutorial, and the check never runs. Nothing looks
   wrong on-chain. A control that can be off without appearing off is worse than a documented manual
   step.
3. **The salt gives most of the value for none of the cost.** §3 produces the same evidence — bound,
   timestamped, immutable — with no unaudited code on the upgrade path.

⚠️ **What was genuinely lost is rule 3 in §5:** the wrapper re-ran the check at execution, catching a
document withdrawn during the delay. A guardian cancelling on an alert covers it, and that is a
weaker control honestly described rather than a stronger one assumed.

If an auditor or NCA later requires a preventive rather than detective gate, the wrapper is a known
design: `PROPOSER_ROLE` and `EXECUTOR_ROLE` held by a contract that calls the registry and reverts.
Adding it is a scheduled role swap, not a redesign.

---

## 7. The proxy

⚠️ **OpenZeppelin 5.x changed the ProxyAdmin model and it catches teams migrating from 4.x.** In
5.x, `TransparentUpgradeableProxy`'s constructor deploys **its own** `ProxyAdmin` and sets
`initialOwner`; the proxy's admin is immutable and there is no shared admin. In 4.x you deployed one
`ProxyAdmin` and pointed many proxies at it. A 4.x deployment script silently produces **N admins to
keep in step instead of one**.

⚠️ **The proxy's admin must be a contract, never an EOA and never the Safe.** A transparent proxy
routes every call from the admin address into the upgrade path instead of the implementation. An
admin that is also an ordinary caller loses the ability to use the contract it administers —
silently, by getting the wrong function back.

⚠️ **`ProxyAdmin` is `Ownable`, which is single-step.** Transferring ownership to a mistyped address
bricks every proxy behind it, permanently, with no recovery. The delay is the only thing between a
typo and a dead deployment, so review of that particular operation is not routine.

⚠️ **Storage layout is the upgrade risk none of this governance touches.** Reordering, removing or
retyping an existing variable reinterprets live storage — balances read as compliance flags. Append
only, and run a layout diff in CI. Everything in this document is about *who* may upgrade and
*whether it was disclosed*; none of it catches *this*.

---

## 8. Deployment order

1. **`TimelockController`** — `(minDelay, proposers: [], executors: [], admin: deployer)`
2. Grant `PROPOSER_ROLE` → Safe; `EXECUTOR_ROLE` → Safe (+ relayer); `CANCELLER_ROLE` → Safe and
   each guardian
3. **Renounce `DEFAULT_ADMIN_ROLE` from the deployer.** Not optional, not "before mainnet".
4. **`TransparentUpgradeableProxy`** per upgradeable contract — `(implementation, initialOwner = timelock, initCalldata)`
5. Configure the alerts in §5 rule 4, and name an owner for each rule in §5

⚠️ **Verify step 2 on-chain before step 3, by reading the role members back — not from the
deployment script.** After the renounce, a *missing* grant is only fixable through the delay, and a
*surplus* grant is not visible in normal operation at all. The set must be exactly what §2 says.

⚠️ **Step 5 is not paperwork.** With no gate contract, §5 is the entire disclosure control. A
deployment that goes live without those alerts has a documented process and no enforcement of any
kind.

---

## 9. Open item — `DoraGovernor.sol`

`DoraGovernor` carries its own upgrade queue, its own timelock, and a `disclosureArtefactHash`
welded into `queueUpgrade`. All of it is now superseded by the OZ stack above.

Two options, and this needs a decision rather than a default:

- **Strip it.** Keep only what is DORA-specific — the `IctIncident` events, the key-rotation
  register, and `tripFromOracle` — and delete `queueUpgrade`, `revealUpgrade`, `executeUpgrade`,
  `cancelUpgrade` and the timelock. What remains is an incident and resilience log, which is what
  the name should have meant.
- **Retire it.** Move the incident events and key register to a plainly named resilience contract
  and delete the file.

⚠️ **`DoraGovernor.pause` / `unpause` is a *protocol* pause — it halts the modules that read it.**
That is a different thing from stopping an upgrade, and it stays either way. Only the upgrade limb
moves.

⚠️ **The commit-reveal in `queueUpgrade` does not survive the move, and that is deliberate.**
`TimelockController.schedule` takes the calldata in the clear. Where MAR Art 17(1a) makes early
disclosure the problem, the answer is to **schedule later** — a protracted process is delayed by not
starting the clock, not by obscuring it. The concealment was thinner than it looked anyway: the
payload is `upgradeAndCall(proxy, implementation, initData)`, and the implementation's *behaviour*
is disclosed by publishing source, which is an off-chain act either way.
