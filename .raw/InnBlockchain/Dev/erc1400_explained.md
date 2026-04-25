# ERC-1400: Security Token Standard — Explained

## What is ERC-1400?

**ERC-1400** is an Ethereum token standard specifically designed for **security tokens** — digital tokens that represent ownership in real-world regulated assets like stocks, bonds, real estate, or fund shares.

Unlike ERC-20 (basic fungible token) or ERC-721 (NFT), ERC-1400 adds a **compliance and regulatory layer** directly into the token smart contract. This makes it legally viable for tokenizing real-world assets (RWAs) that fall under securities law.

> **In short:** ERC-1400 = ERC-20 + Legal Compliance + Transfer Controls + Partitioned Ownership

---

## Why Not Just Use ERC-20?

| Feature | ERC-20 | ERC-1400 |
|---------|--------|----------|
| Basic transfer | ✅ | ✅ |
| KYC/AML enforcement | ❌ | ✅ |
| Transfer restrictions | ❌ | ✅ |
| Regulatory compliance | ❌ | ✅ |
| Forced transfers (court orders) | ❌ | ✅ |
| Document attachment (prospectus) | ❌ | ✅ |
| Partitioned tokens (tranches) | ❌ | ✅ |
| On-chain identity verification | ❌ | ✅ |

ERC-20 has no built-in way to restrict who can hold or transfer a token — not suitable for regulated securities.

---

## Core Architecture of ERC-1400

ERC-1400 is actually a **family of sub-standards** that work together:

```
ERC-1400 (Umbrella Standard)
│
├── ERC-1594  →  Core Security Token Functions (issuance, redemption)
├── ERC-1410  →  Partially Fungible Tokens / Partitions (tranches)
├── ERC-1643  →  Document Management (attach legal docs on-chain)
└── ERC-1644  →  Controller Operations (forced transfers for regulators)
```

---

## Key Features — Technical Deep Dive

### 1. Partitions (Tranches) — via ERC-1410

Partitions allow a **single token to have multiple classes** of shares — like Class A (voting) vs. Class B (non-voting) — all within the same smart contract.

```solidity
// A token holder can own tokens across different partitions
mapping(address => mapping(bytes32 => uint256)) internal _balanceOfByPartition;

// Example partitions
bytes32 public constant CLASS_A = "CLASS_A";  // 10,000 tokens
bytes32 public constant CLASS_B = "CLASS_B";  // 5,000 tokens

function balanceOfByPartition(bytes32 partition, address tokenHolder)
    external view returns (uint256) {
    return _balanceOfByPartition[tokenHolder][partition];
}
```

**Real-world use case:** A real estate property tokenized with:
- `SENIOR_TRANCHE` — priority income, lower risk (for institutional investors)
- `JUNIOR_TRANCHE` — higher return, higher risk (for retail investors)

---

### 2. Transfer Restrictions with `canTransfer()` — Core Compliance Hook

Before any token transfer, the contract checks compliance conditions:

```solidity
function canTransferByPartition(
    bytes32 partition,
    address to,
    uint256 value,
    bytes calldata data
) external view returns (bytes1 esCode, bytes32 appCode, bytes32 dest) {
    
    // Check 1: Is recipient KYC verified?
    if (!kycRegistry[to]) {
        return (0x50, "KYC_FAILED", partition);  // Transfer denied
    }

    // Check 2: Is the investor accredited? (for Reg D securities)
    if (!accreditedInvestors[to]) {
        return (0x50, "NOT_ACCREDITED", partition);
    }

    // Check 3: Lock-up period (e.g., 12 months)
    if (block.timestamp < lockupExpiry[msg.sender]) {
        return (0x55, "LOCK_UP_ACTIVE", partition);
    }

    // All checks passed
    return (0x51, "TRANSFER_ALLOWED", partition);
}
```

**ESC (Ethereum Status Codes) returned:**
| Code | Meaning |
|------|---------|
| `0x51` | Transfer Allowed |
| `0x50` | Transfer Denied |
| `0x55` | Funds Locked |
| `0x56` | Transfer Verified Off-chain |

---

### 3. Issuance & Redemption — via ERC-1594

```solidity
// Issue new tokens to a verified investor
function issue(
    address tokenHolder,
    uint256 value,
    bytes calldata data
) external onlyIssuer {
    require(kycRegistry[tokenHolder], "Investor not verified");
    _totalSupply += value;
    _balances[tokenHolder] += value;
    emit Issued(msg.sender, tokenHolder, value, data);
}

// Investor redeems tokens (burns them, gets fiat back off-chain)
function redeem(
    uint256 value,
    bytes calldata data
) external {
    require(_balances[msg.sender] >= value, "Insufficient balance");
    _totalSupply -= value;
    _balances[msg.sender] -= value;
    emit Redeemed(msg.sender, msg.sender, value, data);
    // Off-chain process then wires fiat to the investor's bank account
}
```

---

### 4. Document Management — via ERC-1643

Regulatory disclosures, prospectuses, and legal agreements are attached on-chain:

```solidity
struct Document {
    bytes32 docHash;       // SHA256 hash of the document content
    uint256 lastModified;  // Timestamp
    string uri;            // IPFS or HTTPS link to the document
}

mapping(bytes32 => Document) internal _documents;

// Attach the property's legal prospectus
function setDocument(
    bytes32 name,       // e.g., keccak256("PROSPECTUS")
    string calldata uri,        // "ipfs://Qm.../prospectus.pdf"
    bytes32 documentHash        // SHA256 of the PDF
) external onlyIssuer {
    _documents[name] = Document(documentHash, block.timestamp, uri);
    emit DocumentUpdated(name, uri, documentHash);
}
```

**Why it matters:** Regulators can verify on-chain that the legal document matches what was disclosed. The document hash is tamper-proof.

---

### 5. Controller Operations (Forced Transfers) — via ERC-1644

This allows a regulator-appointed controller to forcibly move tokens in cases of:
- Court orders
- Fraud recovery
- AML seizure

```solidity
// Only the controller (regulatory authority) can call this
function controllerTransfer(
    address from,
    address to,
    uint256 value,
    bytes calldata data,
    bytes calldata operatorData
) external onlyController {
    _transfer(from, to, value);
    emit ControllerTransfer(
        msg.sender, from, to, value, data, operatorData
    );
}
```

> This is a controversial but legally necessary feature. It ensures the token system is compliant with existing securities law.

---

## Full Token Lifecycle

```
1. Deploy ERC-1400 Contract
        │
        ▼
2. Set Up KYC Registry + Whitelisted Investors
        │
        ▼
3. Attach Legal Documents (Prospectus, SPV Agreement)
        │
        ▼
4. Issue Tokens to Investors (issuance)
        │
        ▼
5. Investors Trade (canTransfer() checks on every move)
        │
        ▼
6. Dividends / Yield Distributed via smart contract
        │
        ▼
7. Investor Redeems Tokens → Receives Fiat (redemption)
```

---

## ERC-1400 vs. ERC-3643

Both are security token standards. Here is how they compare:

| Feature | ERC-1400 | ERC-3643 |
|---------|----------|----------|
| Origin | Developer Community | Tokeny Solutions |
| Identity standard | Custom KYC mapping | Integrates ONCHAINID (ERC-734/735) |
| Adoption | Broader in open-source | Stronger in institutional Europe |
| Modularity | High (sub-standards) | High (modular compliance modules) |
| Preferred for | General RWA dev | GDPR-regulated, European markets |

---

## Popular Blockchains for ERC-1400 Deployment

| Blockchain | Why Used |
|-----------|----------|
| **Ethereum Mainnet** | Most trusted, highest liquidity |
| **Polygon** | Low gas fees for high-frequency transfers |
| **Avalanche** | Enterprise subnets for private compliance |
| **Hyperledger Besu** | Enterprise private chains (banks prefer) |
| **Stellar** | Designed for asset tokenization natively |

---

## Real Projects Using ERC-1400 / Security Token Standards

| Company | Asset Tokenized | Platform |
|---------|----------------|----------|
| **tZERO** | Private securities, real estate | Own platform |
| **Securitize** | Fund shares, bonds, equity | Ethereum + Polygon |
| **Figure** | Home equity loans | Provenance Blockchain |
| **RealT** | US rental properties | Ethereum |
| **Ondo Finance** | US Treasuries (RWA yield) | Ethereum |
| **BlackRock BUIDL** | Tokenized money market fund | Ethereum |

---

## For InnBlockchain — Development Scope

Building an ERC-1400 based RWA platform typically covers:

| Module | Work Involved |
|--------|--------------|
| **Security Token Contract** | Custom ERC-1400 / ERC-3643 smart contracts with investor restrictions |
| **KYC Registry** | On-chain whitelist tied to identity provider (e.g., Onfido, Sumsub) |
| **Document Storage** | IPFS integration + on-chain document hash registry |
| **Dividend Engine** | Automated yield distribution via oracle + smart contract |
| **Admin Dashboard** | Issue tokens, manage investors, set restrictions |
| **Investor Portal** | Buy / sell / view portfolio of tokenized assets |
| **Compliance Module** | Jurisdiction-based transfer rules (US Reg D, EU MiFID) |

**Estimated Project Size:** $80,000 – $400,000+ depending on scope and regulatory jurisdiction.
