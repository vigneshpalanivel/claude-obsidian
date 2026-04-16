---
title: "Hyperledger Fabric CA"
type: concept
tags:
  - blockchain
  - hyperledger
  - fabric
  - certificate-authority
  - identity
  - PKI
  - security
status: current
updated: 2026-04-16 (rev 2)
related:
  - "[[Hyperledger-Fabric]]"
  - "[[Blockchain-Pharmaceutical-Supply-Chain]]"
  - "[[autoresearch-hyperledger-fabric-ca]]"
---

# Hyperledger Fabric CA

## What It Is

Hyperledger Fabric CA is the official Certificate Authority (CA) server and client for Hyperledger Fabric networks. It handles **identity** -- the foundation of Fabric's permissioned model. Every actor in a Fabric network (peers, orderers, admins, client applications) holds an X.509 certificate issued by a CA. Those certificates determine what each actor is allowed to do.

Fabric CA is a standalone service: a **server** (REST API + database) and a **client** CLI (`fabric-ca-client`) used to interact with it. SDKs can also call the server directly.

> CA = the root of trust for an organization. Without it, no identities can be issued, no nodes can join, no transactions can be submitted.

---

## CA Types in a Fabric Network

Fabric recognizes two functional roles for CAs. Each organization typically runs both:

### Organization CA (eCert CA / Enrollment CA)
Issues **identity certificates** (ECerts) for all human and node actors in the organization:
- Peer nodes
- Orderer nodes
- Admin users
- Client applications

### TLS CA
Issues **TLS certificates** used to encrypt and authenticate communications between nodes (peer-to-peer, peer-to-orderer, client-to-peer). Completely separate from the org CA -- do not mix TLS and enrollment certificate issuance from the same CA in production.

**Recommended minimum per organization: 1 Org CA + 1 TLS CA.**

### Root CA vs Intermediate CA

**Root CA** -- self-signed certificate; the ultimate trust anchor. In production, after bootstrapping intermediate CAs, the root CA should be taken offline to reduce attack surface.

**Intermediate CA** -- certificate issued by the root CA (or another intermediate). All day-to-day certificate operations go through the intermediate CA. If the intermediate CA is compromised, you can revoke it and issue a new one from the (offline) root CA without rotating the root trust anchor.

Chain of trust: `Root CA -> Intermediate CA -> Identity Certificates`

Intermediate CAs are optional but strongly recommended for production networks.

---

## Certificate Types

### Enrollment Certificates (ECerts)
X.509 certificates that represent identities in Fabric. Four sub-types based on NodeOUs:

| Sub-type | Used by | Role in Fabric |
|---|---|---|
| **Admin cert** | Network/org admins | Authorized to perform admin operations (install chaincode, create channels) |
| **Peer cert** | Peer nodes | Endorse and commit transactions |
| **Orderer cert** | Orderer nodes | Participate in consensus, package blocks |
| **Client cert** | Applications / SDK | Submit transaction proposals, query ledger |

NodeOUs (Organizational Units embedded in certificates) allow Fabric to automatically classify identity type from the cert -- no manual mapping needed. Recommended for all production deployments.

### TLS Certificates
Separate certificate set used only for transport-layer encryption. Every node holds both an ECert (identity) and a TLS cert (communication). They are issued by different CAs (Org CA vs TLS CA) and stored in separate MSP subdirectories.

---

## Registration vs Enrollment

These two terms are frequently confused. They are distinct steps:

**Registration** -- creates a username + password (secret) record in the CA database. No certificate issued yet. An admin registers an identity, defining its type (peer/client/admin/orderer), affiliations, and attributes. The secret is then passed to the entity that will enroll.

**Enrollment** -- the enrolled entity generates a key pair locally, submits a CSR (Certificate Signing Request) to the CA along with the registration secret, and receives back a signed X.509 certificate. The private key never leaves the entity.

```
Admin registers: fabric-ca-client register --id.name peer1 --id.type peer --id.secret peerPW
Peer enrolls:    fabric-ca-client enroll -u https://peer1:peerPW@ca.org1.example.com:7054
```

Result of enrollment: `msp/` directory containing the cert (`signcerts/`), private key (`keystore/`), and CA cert chain (`cacerts/`).

---

## MSP Folder Structure

After enrollment, each node/user has a local MSP directory:

```
msp/
  admincerts/       # Admin certificates (if NodeOUs not used)
  cacerts/          # Root CA certificate(s)
  intermediatecerts/ # Intermediate CA certificate(s) [optional]
  keystore/         # Private key (never shared)
  signcerts/        # The entity's own X.509 certificate
  tlscacerts/       # TLS CA root certificate
  crls/             # Certificate Revocation Lists [optional]
  config.yaml       # NodeOU classification config
```

The channel MSP (stored on the ledger, shared with all channel members) contains only public material: `cacerts`, `admincerts`, `intermediatecerts`, `crls`. No private keys.

---

## Attributes and Affiliations

### Attributes
Key-value pairs embedded in certificates. Used for fine-grained access control in chaincode:
- `hf.Registrar.Roles` -- which identity types this identity can register
- `hf.GenCRL` -- can generate Certificate Revocation Lists
- `hf.Revoker` -- can revoke certificates
- Custom attributes: any `key:value` pair, readable inside chaincode via `stub.GetCreator()` and cert parsing

Example use in chaincode: only identities with `attr:department=manufacturing` may invoke a specific chaincode function.

### Affiliations
Hierarchical grouping of identities within an organization (e.g., `org1.manufacturing`, `org1.finance`). Affiliations can be referenced in endorsement policies and chaincode-level ACLs. Useful for multi-department organizations where different business units operate on the same Fabric network.

---

## Identity Flow: Full Lifecycle

```
1. Deploy TLS CA
2. Enroll TLS CA bootstrap admin
3. Register TLS identities for all nodes
4. Deploy Org CA
5. Enroll Org CA bootstrap admin
6. Register org identities (peers, orderers, users)
7. Each node/user enrolls -> generates key pair + receives cert
8. Assemble MSP directories
9. Distribute channel MSP (public certs only) to all channel members
10. Nodes start up with their local MSP + TLS certs
```

The TLS CA must be deployed first (before Org CA) because TLS is required for all inter-node communication including the CA-to-node enrollment handshake.

---

## Certificate Operations

### Renewal / Re-enrollment
Certificates expire (default 1 year for enrollment certs). Re-enrollment uses `fabric-ca-client reenroll`. Fabric CA supports re-enrollment with the existing key pair even after the certificate has expired -- important for disaster recovery scenarios.

### Revocation
Revocation is CRL-based (Certificate Revocation List):
```bash
fabric-ca-client revoke -e <enrollment_id>
fabric-ca-client gencrl
```
The generated CRL file is placed in the `msp/crls/` directory of all peers. Peers check the CRL when validating transaction signatures.

**Critical limitation: TLS certificate revocation is not enforced.** If a TLS cert is compromised, the only remedy is to replace it on the node and restart. There is no live revocation check for TLS certs in Fabric.

**No OCSP support** -- Fabric CA does not implement OCSP (Online Certificate Status Protocol). All revocation is via CRL distribution.

---

## Storage Backends

The CA server stores identity and certificate records in a database. Supported backends:

| Backend | Notes |
|---|---|
| **SQLite** | Default; single-node CA only; not suitable for HA |
| **PostgreSQL** | Recommended for production |
| **MySQL** | Supported |
| **LDAP** | If LDAP is enabled, identity data lives in LDAP instead of the DB; `registry` section ignored |

For a CA cluster (multiple CA server instances sharing load), all instances must share the same PostgreSQL/MySQL database.

---

## HSM Integration (Hardware Security Module)

For high-security environments (financial institutions, regulated industries), CA private keys should be stored in an HSM rather than on disk. Fabric CA supports PKCS#11 interface:

```yaml
bccsp:
  default: PKCS11
  pkcs11:
    lib: /path/to/pkcs11/library.so
    pin: "12345"
    label: "ForFabric"
```

When HSM is configured: the CA private key is generated inside the HSM and never exported. Certificate signing operations happen inside the HSM. Supported vendors: Entrust nShield (2024 integration guide available), Thales DPoD, AWS CloudHSM.

HSM is mandatory for any Fabric deployment subject to FIPS 140-2 or similar cryptographic hardware requirements (common in pharma, finance, government).

**AWS CloudHSM** is the recommended AWS-native path. It runs dedicated HSM hardware in your VPC and provides an official PKCS11 library. Requires one extra config param (`altid`) vs other HSM vendors:

```yaml
bccsp:
  default: PKCS11
  pkcs11:
    lib: /opt/cloudhsm/lib/libcloudhsm_pkcs11.so
    pin: "<CU_user>:<CU_password>"
    label: "<token_label>"
    altid: "<key_handle>"   # CloudHSM-specific requirement
    hash: SHA2
    security: 256
```

**HSM scope limitation:** HSM only protects ECert signing keys. **TLS private keys must remain file-based** -- Fabric does not support HSM storage for TLS keys regardless of HSM vendor.

---

## LDAP Integration

When an enterprise already has an LDAP/Active Directory user store, Fabric CA can delegate identity lookup to it:

```yaml
ldap:
  enabled: true
  url: ldap://ldap.example.com:389/dc=example,dc=com
  tls: ...
  attribute:
    names: ['uid', 'member', 'ou']
    converters:
      - name: hf.Registrar.Roles
        value: attr("ou")
```

LDAP attributes map to Fabric CA attributes and affiliations. Identity info lives in LDAP; certificate issuance still goes through Fabric CA. Useful when org already manages users in Active Directory and does not want a separate identity store.

---

## Production Deployment Checklist

Key items from official Fabric CA production checklist:

- [ ] Deploy TLS CA before Org CA
- [ ] Use intermediate CAs; take root CA offline after bootstrapping
- [ ] Use PostgreSQL or MySQL (not SQLite) for CA database
- [ ] Enable TLS on all CA server endpoints
- [ ] Use HSM for CA private key storage in regulated environments
- [ ] Configure `csr.expiry` appropriately (default 1 year ECert; 10 year CA cert)
- [ ] Separate TLS CA profiles from enrollment CA profiles (no cross-issuance)
- [ ] Set `hf.GenCRL` and `hf.Revoker` attributes on dedicated admin identities only
- [ ] Monitor certificate expiry -- set up alerts well before expiry (no auto-renewal)
- [ ] Document the registration secrets for disaster recovery (lost secrets require re-registration)

---

## Common Mistakes

| Mistake | Consequence |
|---|---|
| Using one CA for both TLS and enrollment certs | Hard to audit, no clean separation of concerns, operationally messy |
| Using SQLite in production | CA becomes a single point of failure; no HA possible |
| Not deploying intermediate CAs | Root CA must stay online; compromise of CA = compromise of entire org trust |
| Ignoring certificate expiry | Nodes stop communicating when certs expire; hard to recover if overlapping renewal not planned |
| Storing CA private key on disk without HSM | CA key compromise = all issued certs untrusted; network must be rebuilt |
| Mixing `hf.Revoker` privilege broadly | Any compromised identity with this attribute can revoke peers and orderers |

---

## Relationship to MSP

The CA *issues* certificates. The MSP *uses* them to make authorization decisions. They are separate but tightly coupled:

- Each organization's MSP contains the CA's root cert (so peers know which CA to trust)
- The channel MSP (on ledger) aggregates each org's trust anchor
- When a transaction arrives signed by identity X, the peer checks: is X's cert signed by a CA whose root is in the channel MSP? If yes, X is a valid network participant

A CA change (new root, revoked intermediate) requires updating the MSP configuration on all affected channels via a channel config update transaction.

---

## Application Layer Authentication (User Panel)

Fabric CA has **no concept of login**. It issues certificates -- that is all. A web panel or application UI requires a separate authentication layer. The three layers never overlap:

```
┌─────────────────────────────────────┐
│   Web Panel / Application UI        │  Your code: username + password login (JWT/sessions)
├─────────────────────────────────────┤
│   Application Backend / SDK         │  Wallet: loads enrolled cert+key for the session
├─────────────────────────────────────┤
│   Fabric CA  →  Fabric Network      │  Certificate issuance (one-time) + tx signing
└─────────────────────────────────────┘
```

**Wallet** is the SDK concept bridging the app and Fabric. After panel login succeeds, the backend loads the user's enrolled identity (cert + private key) from the wallet and uses it to sign transactions:

```js
const wallet = await Wallets.newFileSystemWallet('./wallet');
const identity = await wallet.get(username);
const gateway = new Gateway();
await gateway.connect(connectionProfile, { wallet, identity: username });
```

Fabric CA is called **once** at user provisioning time (enrollment), not on every login. Every subsequent login reuses the cert already stored in the wallet.

---

## Identity Patterns: Do All App Users Need a CA Identity?

**No -- not necessarily.** Three patterns exist depending on audit and access control requirements:

### Pattern 1 -- One Identity Per App User
Every application user gets their own cert from Fabric CA.

- Full on-chain auditability: ledger records exactly which user submitted each tx
- Per-user revocation possible
- Scales poorly for large user bases (wallet management per user, private key storage)
- **Best for:** B2B consortia, regulated industries (pharma, trade finance) where per-participant audit is mandatory

### Pattern 2 -- Single Shared Backend Identity (Most Common)
One enrolled identity for the entire backend. All app users log in normally; the backend submits every tx under one Fabric identity.

```
Alice logs in → Backend (enrolled as "app-backend") → submits tx to Fabric
Bob logs in   → Backend (enrolled as "app-backend") → submits tx to Fabric
```

- Unlimited app users, zero CA involvement per user
- No per-user on-chain trace (ledger only shows "app-backend")
- Simple wallet: one cert, one key
- **Best for:** consumer-facing apps, internal tools

### Pattern 3 -- One Identity Per Role (Hybrid)
A small fixed set of Fabric identities, one per business role. App users are unlimited; the backend picks the matching role identity per request.

```
Fabric CA identities:   backend-buyer | backend-supplier | backend-auditor
App DB users:           alice (buyer) → uses backend-buyer cert
                        bob   (buyer) → uses backend-buyer cert
                        carol (auditor) → uses backend-auditor cert
```

- Role-level chaincode ACL enforcement; user-level enforcement stays in app DB
- **Best for:** enterprise panels with a defined set of roles

### Decision Guide

```
Need to know on the ledger which specific person did each tx?
  YES → Pattern 1 (one cert per user)
  NO  → Need chaincode-level role enforcement?
          YES → Pattern 3 (one cert per role)
          NO  → Pattern 2 (single backend identity)
```

---

## User Types and Roles in Fabric CA

Fabric CA has **4 fixed NodeOU types** for all identities. All end users in your application are type `client`:

```
client    → application users submitting transactions  (all your app users)
admin     → network/org administrators
peer      → peer nodes
orderer   → orderer nodes
```

**Multiple users under one type:** unlimited. Type is a protocol-level classification, not a business role.

### Affiliations (Department Grouping)

Affiliations add a hierarchical sub-org grouping on top of type:

```
org1
 ├── org1.manufacturing
 │     ├── alice  (type: client)
 │     └── bob    (type: client)
 └── org1.finance
       └── carol  (type: client)
```

```bash
fabric-ca-client register \
  --id.name alice \
  --id.type client \
  --id.affiliation org1.manufacturing \
  --id.secret alicepw
```

### Custom Attributes (Business Roles)

For application-level roles (buyer, seller, auditor), use **custom attributes** embedded in the certificate:

```bash
fabric-ca-client register \
  --id.name alice \
  --id.type client \
  --id.affiliation org1.manufacturing \
  --id.attrs 'role=buyer,department=procurement' \
  --id.secret alicepw
```

Chaincode reads the attribute per transaction:

```go
role, _, err := cid.GetAttributeValue(ctx.GetStub(), "role")
if role != "buyer" {
    return fmt.Errorf("only buyers can invoke this")
}
```

### Full Identity Model

```
NodeOU type (client/admin/peer/orderer)   ← protocol layer
        └── Affiliation (org1.finance)    ← department/group layer
                └── Custom attrs          ← business role layer
                    (role=auditor)
```

| Layer | Controls | Enforced by |
|---|---|---|
| NodeOU type | Can submit txs vs administer network | Fabric MSP / channel policy |
| Affiliation | Sub-org grouping | Endorsement policy, chaincode |
| Custom attribute | Business role logic | Chaincode only |
| App DB | Panel login, UI permissions, session | Your backend |

---

## Related Concepts

- [[Hyperledger-Fabric]] -- the broader framework that Fabric CA serves
- [[Blockchain-Pharmaceutical-Supply-Chain]] -- pharma supply chain networks (MediLedger-style) require careful CA design for multi-org trust with competitor privacy
