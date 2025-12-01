# adcoin

A simple fungible token smart contract called **adcoin** built with [Clarinet](https://github.com/hirosystems/clarinet).

## Project structure

- `Clarinet.toml` – Clarinet project configuration
- `contracts/adcoin.clar` – main Clarity smart contract implementing the adcoin fungible token
- `settings/` – network configuration files (Devnet, Testnet, Mainnet)
- `tests/` – Clarinet JS / Vitest tests for the contract

## Requirements

- Node.js and npm (for tests)
- [Clarinet](https://docs.hiro.so/clarinet) (already installed on this machine)

Check Clarinet is available:

```bash path=null start=null
clarinet --version
```

## Using Clarinet

From the project root (`/home/anthony/Documents/GitHub/adcoin`):

### 1. Check the contract

Run static checks on the Clarity code:

```bash path=null start=null
clarinet check
```

### 2. Open a REPL

You can experiment with the contract in a Clarinet REPL:

```bash path=null start=null
clarinet console
```

Inside the console, you can call read-only functions, for example:

```clarity path=null start=null
(contract-call? .adcoin get-total-supply)
(contract-call? .adcoin get-name)
(contract-call? .adcoin get-symbol)
```

### 3. Run tests

Install JS dependencies and run the Vitest suite:

```bash path=null start=null
npm install
npm test
```

## Contract overview

The `adcoin` contract is a simple fungible token with:

- A `total-supply` data variable.
- A `balances` map tracking balances per principal.
- Read-only functions:
  - `get-total-supply`
  - `get-balance-of`
- Public functions:
  - `mint` – mint new tokens to a recipient.
  - `transfer` – transfer from the caller (`tx-sender`) to a recipient.

## Typical flow

1. **Mint tokens** (from the contract deployer / owner):
   ```clarity path=null start=null
   (contract-call? .adcoin mint tx-sender u1000000)
   ```

2. **Check balances**:
   ```clarity path=null start=null
   (contract-call? .adcoin get-balance-of tx-sender)
   ```

3. **Transfer tokens** (from caller to another principal):
   ```clarity path=null start=null
   (contract-call? .adcoin transfer u100 'ST3J2GVMMM2R07ZFBJDWTYEYAR8FZH5WKDTFJ9AHA)
   ```

## Running checks quickly

Any time you edit `contracts/adcoin.clar`, run:

```bash path=null start=null
clarinet check
```

This validates the syntax and performs static analysis on the contract.
