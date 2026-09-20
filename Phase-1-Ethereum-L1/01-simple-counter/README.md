# SimpleCounter

A minimal Solidity smart contract for Ethereum L1 that stores a single counter value on-chain.

## What it does

- Stores a `count` (starts at 0)
- Anyone can increment or decrement the count
- Only the contract deployer (owner) can reset the count to 0
- Emits a `CountChanged` event every time the count changes

## Contract details

- **File:** `SimpleCounter.sol`
- **Solidity version:** `^0.8.24`
- **License:** MIT

## Functions

| Function      | Access        | Description                          |
|---------------|---------------|---------------------------------------|
| `increment()` | Anyone        | Increases count by 1                  |
| `decrement()` | Anyone        | Decreases count by 1 (fails if count is 0) |
| `reset()`     | Owner only    | Resets count to 0                     |
| `getCount()`  | Anyone (read) | Returns the current count             |
| `owner()`     | Anyone (read) | Auto-generated getter, returns owner address |

## Events

| Event           | Emitted when            | Data                              |
|------------------|-------------------------|------------------------------------|
| `CountChanged`   | count changes           | address that changed it, new count |

## Deployment notes

- No constructor arguments needed.
- Deployer's address automatically becomes `owner`.
- Designed for Ethereum L1, but works on any EVM-compatible chain/testnet.

## Status

Basic version — for learning/testing purposes. Not audited, not intended for mainnet use with real funds yet.