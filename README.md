# ZK Personhood

A zero-knowledge personhood verification system. Users prove they are unique humans without revealing their identity.

## Contracts

- **PersonhoodRegistry.sol** — Main registry storing identity commitments and tracking verified users
- **Verifier.sol** — Simplified ZK proof verifier using BN254 pairings
- **Poseidon.sol** — Poseidon hash function implementation for efficient ZK-friendly hashing

## Getting Started

```bash
npm install
npx hardhat compile
npx hardhat test
```

## Deploy

```bash
npx hardhat run scripts/deploy.js --network sepolia
```
