# ERC-3643: The T-REX Standard — Explained

## What is ERC-3643?

**ERC-3643**, also known as **T-REX (Token for Regulated EXchanges)**, is an Ethereum token standard designed for **compliant security tokens**. It was developed by **Tokeny Solutions** and officially ratified as an Ethereum Improvement Proposal (EIP).

While ERC-1400 is a broad open-source framework, ERC-3643 is a more **structured, identity-centric** standard that integrates with the **ONCHAINID** protocol (ERC-734 / ERC-735) for investor identity management.

> **In short:** ERC-3643 = Security Token + On-Chain Digital Identity (ONCHAINID) + Modular Compliance Engine

It is especially strong for **European securities regulation (MiFID II, GDPR)** and is widely adopted by institutional issuers.

---

## ERC-1400 vs. ERC-3643 — Quick Comparison

| Feature | ERC-1400 | ERC-3643 |
|---------|----------|----------|
| Identity standard | Custom KYC mapping | **ONCHAINID (ERC-734/735)** — standardized |
| Compliance engine | Manual rules in contract | **Modular, pluggable compliance modules** |
| Regulatory focus | General/global | Strong fit for EU (MiFID II, GDPR) |
| Developer ecosystem | Open-source community | Tokeny + institutional partners |
| Adoption | Widely used in open-source | Preferred in European institutional markets |
| Flexibility | High, but complex | High, with cleaner architecture |

---

## Core Architecture of ERC-3643

ERC-3643 is composed of **4 main components** that work together:

```
┌─────────────────────────────────────────────────────────────┐
│                       ERC-3643 ECOSYSTEM                    │
│                                                             │
│  ┌───────────────┐    ┌───────────────┐    ┌─────────────┐ │
│  │  Token        │    │  Identity     │    │  Compliance │ │
│  │  Contract     │───►│  Registry     │───►│  Module     │ │
│  │  (T-REX)      │    │  (ONCHAINID)  │    │  Engine     │ │
│  └───────────────┘    └───────────────┘    └─────────────┘ │
│          │                                        │         │
│          ▼                                        ▼         │
│  ┌───────────────┐                      ┌─────────────────┐ │
│  │  Trusted      │                      │  Claim Topics   │ │
│  │  Issuers      │                      │  Registry       │ │
│  │  Registry     │                      │  (Rules)        │ │
│  └───────────────┘                      └─────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Component 1 — Token Contract (T-REX Token)
The core ERC-20 compatible token with compliance hooks built in.

### Component 2 — Identity Registry (ONCHAINID)
Every investor gets a **decentralized on-chain identity** (smart contract wallet) that stores their verified claims (KYC, accreditation status, country, etc.).

### Component 3 — Compliance Module Engine
A modular, pluggable rules engine that checks compliance before every transfer. Rules can be swapped/updated without changing the token contract.

### Component 4 — Trusted Issuers Registry
Defines which KYC/identity providers are trusted to issue claims about investors (e.g., Onfido, Sumsub, or a regulated bank).

---

## ONCHAINID — The Key Differentiator

**ONCHAINID** (based on ERC-734/ERC-735) gives every investor a **self-sovereign digital identity** on-chain — a smart contract that holds verified claims about them.

```
Investor's ONCHAINID (Smart Contract)
│
├── Claim: "KYC Verified" — issued by Onfido (Trusted Issuer)
├── Claim: "Accredited Investor" — issued by Compliance Firm
├── Claim: "Country: France" — issued by KYC Provider
└── Claim: "Age > 18" — issued by Identity Verifier
```

Each claim is:
- **Cryptographically signed** by the trusted issuer
- **Stored on-chain** in the investor's ONCHAINID contract
- **Verifiable without exposing raw personal data** (privacy-preserving)

```solidity
// ONCHAINID Claim structure (ERC-735)
struct Claim {
    uint256 topic;       // Type of claim (e.g., 1 = KYC, 2 = Accreditation)
    uint256 scheme;      // How it's verified (e.g., ECDSA = 1)
    address issuer;      // Trusted issuer who signed this claim
    bytes signature;     // Cryptographic proof
    bytes data;          // Claim data (hashed for privacy)
    string uri;          // Optional link to off-chain proof
}
```

---

## Key Technical Flows

### Token Transfer Flow with Compliance Check

```
Investor A wants to transfer 100 tokens to Investor B
        │
        ▼
1. Token contract calls → canTransfer(A, B, 100)
        │
        ▼
2. Compliance Module checks:
   ├── Does B have a valid ONCHAINID?
   ├── Does B's ONCHAINID have required claims? (KYC, country, accreditation)
   ├── Are the claims from a Trusted Issuer?
   ├── Are any lock-up or holding restrictions active?
   └── Do any jurisdiction rules block this transfer?
        │
        ├── ✅ All checks pass → Transfer executes
        └── ❌ Any check fails → Transfer reverted with reason code
```

---

### Compliance Module — Solidity Example

```solidity
// Modular compliance rule: Max number of investors per country
contract CountryRestrictionCompliance is ICompliance {

    // country code => max allowed investors
    mapping(uint16 => uint256) public maxInvestorsByCountry;
    // country code => current investor count
    mapping(uint16 => uint256) public investorsByCountry;

    function canTransfer(
        address _from,
        address _to,
        uint256 /*_amount*/
    ) external view override returns (bool) {

        // Get recipient's country claim from their ONCHAINID
        uint16 recipientCountry = _getCountry(_to);

        // Check if adding this investor exceeds the country cap
        if (investorsByCountry[recipientCountry] >= 
            maxInvestorsByCountry[recipientCountry]) {
            return false; // Deny transfer — country cap reached
        }

        return true;
    }

    function _getCountry(address investor) internal view returns (uint16) {
        // Reads the investor's "country" claim from their ONCHAINID
        IIdentity identity = IIdentityRegistry(identityRegistry)
            .identity(investor);
        bytes memory countryData = identity.getClaimData(COUNTRY_CLAIM_TOPIC);
        return abi.decode(countryData, (uint16));
    }
}
```

**Other available compliance modules:**
- `MaxInvestorsModule` — limits total number of token holders
- `CountryAllowListModule` — whitelist of allowed countries
- `CountryRestrictModule` — blacklist of restricted countries
- `TimeLocksModule` — lock-up periods after issuance
- `TransferFeesModule` — automatic fee deduction on transfer
- `MaxOwnershipModule` — limits one investor's max holding %

---

## Smart Contract Interaction Map

```solidity
// Simplified T-REX Token — core ERC-3643 token
contract Token is ERC20 {

    IIdentityRegistry public identityRegistry;  // ONCHAINID store
    ICompliance public compliance;               // Modular rules engine

    function transfer(address to, uint256 amount) 
        public override returns (bool) {
        
        // Step 1: Check identity registry — does recipient have valid identity?
        require(
            identityRegistry.isVerified(to), 
            "Recipient not verified"
        );

        // Step 2: Run compliance module checks
        require(
            compliance.canTransfer(msg.sender, to, amount),
            "Transfer not compliant"
        );

        // Step 3: Execute the transfer
        _transfer(msg.sender, to, amount);
        compliance.transferred(msg.sender, to, amount); // Update state
        return true;
    }

    // Forced recovery (lost wallet / legal order)
    function recoveryAddress(
        address lostWallet,
        address newWallet,
        address investorOnchainID
    ) external onlyAgent {
        uint256 investorTokens = balanceOf(lostWallet);
        _transfer(lostWallet, newWallet, investorTokens);
        identityRegistry.registerIdentity(newWallet, investorOnchainID, 
            identityRegistry.investorCountry(lostWallet));
    }
}
```

---

## Full Issuance Lifecycle

```
Step 1: Deploy ONCHAINID contracts for each investor
        │
        ▼
Step 2: Trusted KYC providers verify investors and issue on-chain claims
        │
        ▼
Step 3: Asset issuer deploys T-REX Token + registers it with:
        ├── Identity Registry (investor whitelist)
        ├── Trusted Issuers Registry (approved KYC providers)
        ├── Claim Topics Registry (required claim types)
        └── Compliance Contract (modular rules)
        │
        ▼
Step 4: Tokens issued (minted) to verified investor wallets
        │
        ▼
Step 5: Investors trade on exchanges — all transfers auto-checked by compliance
        │
        ▼
Step 6: Dividends/yield distributed by smart contract to all holders
        │
        ▼
Step 7: Investor redeems or exits — tokens burned, fiat returned
```

---

## Regulatory Compliance Built In

ERC-3643 is specifically designed to meet real regulatory frameworks:

| Regulation | How ERC-3643 Handles It |
|-----------|------------------------|
| **EU MiFID II** | Identity registry + investor classification claims |
| **GDPR** | Personal data stored off-chain; only hashed claims on-chain |
| **US Reg D (506c)** | Accredited investor claims verified by trusted issuers |
| **US Reg S** | Country restriction compliance modules block US persons |
| **AML/KYC** | All transfers require verified ONCHAINID with KYC claim |
| **FATF Travel Rule** | Investor identity traceable for large transfers |

---

## Real-World Projects Using ERC-3643

| Company | Country | Asset Type |
|---------|---------|-----------|
| **Tokeny Solutions** | Luxembourg | Platform infrastructure |
| **Euronext** | Europe | Digital bonds |
| **SGX (Singapore Exchange)** | Singapore | Tokenized securities |
| **SBI Digital Asset Holdings** | Japan | Security tokens |
| **Liquefy** | Hong Kong | Fund tokenization |
| **Mata Capital** | France | Real estate tokens |

---

## ERC-3643 Tech Stack for a Full Platform

| Layer | Technology |
|-------|-----------|
| **Blockchain** | Ethereum, Polygon, Avalanche |
| **Token Standard** | ERC-3643 (T-REX contracts) |
| **Identity** | ONCHAINID (ERC-734/ERC-735) |
| **KYC Provider** | Onfido, Sumsub, Veriff |
| **Oracle** | Chainlink (for valuations, yield data) |
| **Storage** | IPFS (legal documents) |
| **Custody** | Fireblocks, Copper, BitGo |
| **Frontend** | React + ethers.js / wagmi |

---

## For InnBlockchain — Development Scope

Building a compliant ERC-3643 RWA platform involves:

| Module | Description | Complexity |
|--------|------------|-----------|
| **ONCHAINID Setup** | Deploy identity contracts for all investors | Medium |
| **T-REX Token** | Core ERC-3643 token with all 4 registries | High |
| **KYC Integration** | Connect KYC provider → issue claims on ONCHAINID | High |
| **Compliance Modules** | Build custom rules (country, lock-up, max holders) | Medium |
| **Admin Dashboard** | Manage investors, claims, transfers, freeze | High |
| **Investor Portal** | Onboarding flow, portfolio view, transfer UI | Medium |
| **Legal Doc Registry** | IPFS + on-chain hash for documents | Low |
| **Dividend Engine** | Automated yield distribution smart contract | Medium |

**Estimated Project Value:** $100,000 – $500,000+ depending on jurisdiction and scale.

---

## Summary

```
ERC-3643 = T-REX Token
         + ONCHAINID (Privacy-preserving on-chain identity)
         + Trusted Issuers Registry
         + Claim Topics Registry
         + Modular Compliance Engine
         = Fully regulated, institutional-grade security token
```

ERC-3643 is the preferred standard when:
- ✅ Clients are in **European or Asian regulated markets**
- ✅ Strong **privacy compliance (GDPR)** is required
- ✅ Multiple **compliance rules** need to be swapped without redeploying the token
- ✅ Institutional investors require **standardized digital identity** integration
