# ZK Personhood

A zero-knowledge personhood verification system designed to solve the sybil resistance problem in decentralized networks. Users can prove they are unique humans without revealing their identity, enabling trustless anti-sybil mechanisms for DAOs, airdrops, and community governance.

## Overview

ZK Personhood provides a cryptographic primitive for **unique human verification** on-chain. Unlike KYC-based solutions, it preserves privacy by using identity commitments and zero-knowledge proofs. Users register a hash of their identity secret (a commitment), and later prove they are the same unique individual without revealing the underlying secret.

### How It Works

1. **Registration** — User generates a random identity secret and computes `commitment = Poseidon(secret)`. The commitment is registered on-chain.
2. **Verification** — To prove personhood, the user generates a ZK proof showing they know the secret behind a registered commitment, without revealing which commitment or secret.
3. **Uniqueness** — Each address can only be verified once. The registry tracks verified users while maintaining unlinkability.

## Architecture

```
┌──────────────────────────────────────────────┐
│              PersonhoodRegistry                │
├──────────────────────────────────────────────┤
│ · identityCommitments (mapping)               │
│ · verifiedUsers (mapping)                     │
│ · commitmentList (array)                      │
├──────────────────────────────────────────────┤
│ + register(commitment)                        │
│ + verify(commitment, proof) → bool           │
│ + isRegistered(commitment) → bool            │
│ + getUserCount() → uint256                   │
└──────────────────────────────────────────────┘
                      ▲
                      │ uses
              ┌───────┴────────┐
              │  Poseidon Hash  │
              └────────────────┘
```

## Contracts

| Contract | Description |
|----------|-------------|
| **PersonhoodRegistry.sol** | Main registry — stores identity commitments, tracks verified users, emits events for registration and verification |
| **Verifier.sol** | ZK proof verifier contract — validates Groth16-style proofs using BN254 elliptic curve pairings |
| **Poseidon.sol** | Efficient ZK-friendly hash function implementation in Solidity — optimized for the BN254 scalar field |

## Tech Stack

- **Solidity ^0.8.20** — Smart contracts
- **Hardhat** — Development environment and testing framework
- **Poseidon Hash** — ZK-friendly hashing for efficient proof generation
- **BN254 Curve** — Ethereum-native elliptic curve for pairing-based cryptography

## Getting Started

### Prerequisites

- Node.js v18+
- npm or yarn

### Installation

```bash
git clone https://github.com/zkpersonood/zk-personhood.git
cd zk-personhood
npm install
```

### Compile

```bash
npx hardhat compile
```

### Test

```bash
npx hardhat test
```

Expected output:
```
  PersonhoodRegistry
    ✓ should register a commitment
    ✓ should not allow duplicate commitments
    ✓ should track user count

  3 passing (500ms)
```

### Deploy (Sepolia)

```bash
cp .env.example .env
# Edit .env with your PRIVATE_KEY and SEPOLIA_RPC
npx hardhat run scripts/deploy.js --network sepolia
```

## Use Cases

- **DAO Governance** — Ensure one-person-one-vote without doxxing participants
- **Airdrop Distribution** — Prevent sybil attacks in token distributions
- **Community Building** — Verify unique membership in decentralized communities
- **Gitcoin Grants** — Anti-sybil for quadratic funding rounds

## Security Considerations

- The Poseidon hash implementation uses a simplified 2-field construction — review before mainnet use
- Production deployments should integrate with a full Groth16 or PLONK proving system
- Identity commitments should use high-entropy secrets (256 bits minimum)

## License

MIT
