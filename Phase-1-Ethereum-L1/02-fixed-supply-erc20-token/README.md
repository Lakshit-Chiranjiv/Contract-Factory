# FixedSupplyToken (FST)

A minimal fixed-supply ERC-20 token for Ethereum. The entire supply is minted once at deployment and can never be increased.

## Overview

| Property | Value |
|---|---|
| Name | Fixed Supply Token |
| Symbol | FST |
| Decimals | 18 |
| Total supply | 1,000,000 FST (`1000000000000000000000000` base units) |
| Standard | ERC-20 |
| Base implementation | OpenZeppelin `ERC20` |
| Solidity version | `^0.8.24` |
| License | MIT |

## How it works

- The contract inherits OpenZeppelin's audited `ERC20` implementation.
- The constructor calls `_mint(msg.sender, TOTAL_SUPPLY)` once, sending the full supply to the deployer.
- No other function calls `_mint`, and there is no `owner`, no `mint()`, no `burn()`, and no upgrade mechanism. Total supply is permanently fixed.

## Contract

`contracts/FixedSupplyToken.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FixedSupplyToken is ERC20 {
    uint256 public constant TOTAL_SUPPLY = 1_000_000 * 10 ** 18;

    constructor() ERC20("Fixed Supply Token", "FST") {
        _mint(msg.sender, TOTAL_SUPPLY);
    }
}
```

## Public interface

| Function | Type | Description |
|---|---|---|
| `name()` | view | Returns `"Fixed Supply Token"` |
| `symbol()` | view | Returns `"FST"` |
| `decimals()` | view | Returns `18` |
| `totalSupply()` | view | Returns the total supply (always `1000000000000000000000000`) |
| `TOTAL_SUPPLY()` | view | The constant used at mint time |
| `balanceOf(address)` | view | Balance of an address |
| `allowance(owner, spender)` | view | Remaining amount `spender` may spend for `owner` |
| `transfer(to, amount)` | write | Send tokens from the caller to `to` |
| `approve(spender, amount)` | write | Allow `spender` to spend up to `amount` of the caller's tokens |
| `transferFrom(from, to, amount)` | write | Spend tokens from `from` within the caller's allowance |

Events: `Transfer(from, to, value)` and `Approval(owner, spender, value)`.

## Amounts and decimals

All amounts are integers in base units. To send 1 FST, pass `1000000000000000000` (`10**18`). Wallets and UIs convert for display.

## Dependencies

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) (`@openzeppelin/contracts`)

## Deployment

The constructor takes no arguments. The deploying address receives the entire supply.

Before deploying to mainnet, consider:
- Changing the name, symbol and supply to your final values (they cannot be changed after deployment)
- Testing on a testnet (e.g. Sepolia) first
- Verifying the source code on Etherscan
- Having the contract independently reviewed

## Notes

- Tokens sent to the contract's own address or to a wrong address cannot be recovered.
- The deployer holds 100% of the supply at launch, so distribution is up to the deployer.

## License

MIT